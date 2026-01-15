import 'package:bloc/bloc.dart';
import 'package:one_stop_journaling/core/di/injectors.dart';
import 'package:one_stop_journaling/core/services/log_service.dart';
import 'package:one_stop_journaling/core/shared/models/state_controller.dart';
import 'package:one_stop_journaling/features/home/presentations/blocs/home_screen_cubit.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_month_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/update_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/presentation/blocs/journal_history_state.dart';

class JournalHistoryCubit extends Cubit<StateController<JournalHistoryState>> {
  final GetJournalsByMonthUsecase getJournalsByMonthUsecase;
  final UpdateJournalUsecase updateJournalUsecase;
  JournalHistoryCubit({
    required this.getJournalsByMonthUsecase,
    required this.updateJournalUsecase,
  }) : super(StateController.idle()) {
    fetch();
  }

  void fetch({DateTime? month}) async {
    emit(StateController.loading());
    final targetMonth = month ?? DateTime.now();
    try {
      final result = await getJournalsByMonthUsecase.call(targetMonth);
      final sortedJournals = List<Journal>.from(result)
        ..sort((a, b) => b.date.compareTo(a.date));

      late final bool hasNextPage;
      late final bool hasPreviousPage;
      if (targetMonth.month == DateTime.now().month &&
          targetMonth.year == DateTime.now().year) {
        hasNextPage = false;
        hasPreviousPage = true;
      } else {
        hasNextPage = true;
        hasPreviousPage = true;
      }

      emit(
        StateController.success(
          JournalHistoryState(
            journals: sortedJournals,
            selectedMonth: targetMonth,
            hasNextPage: hasNextPage,
            hasPreviousPage: hasPreviousPage,
          ),
        ),
      );
    } catch (e, s) {
      LogService.logError('Error initializing JournalHistoryCubit', e, s);
      emit(
        StateController.failure(
          errorMessage: 'Failed to load journal history',
          data: null,
        ),
      );
    }
  }

  void updateJournal(Journal journal) async {
    emit(StateController.loading(data: state.inferredData));
    try {
      await updateJournalUsecase.call(journal);
      sl.get<HomeScreenCubit>(instanceName: AppInstances.homeCubit).init();
    } catch (e, s) {
      LogService.logError('Error updating journal', e, s);
      emit(
        StateController.failure(
          errorMessage: 'Failed to update journal',
          data: state.inferredData,
        ),
      );
    } finally {
      fetch(month: state.inferredData?.selectedMonth);
    }
  }
}
