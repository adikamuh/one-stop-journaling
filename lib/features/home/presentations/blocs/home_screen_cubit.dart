import 'package:bloc/bloc.dart';
import 'package:one_stop_journaling/core/services/log_service.dart';
import 'package:one_stop_journaling/core/shared/models/state_controller.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/add_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_month_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/update_journal_usecase.dart';

class HomeScreenCubit extends Cubit<StateController<List<Journal>>> {
  final GetJournalsByMonthUsecase getJournalsByMonthUsecase;
  final AddJournalUsecase addJournalUsecase;
  final UpdateJournalUsecase updateJournalUsecase;
  HomeScreenCubit({
    required this.getJournalsByMonthUsecase,
    required this.addJournalUsecase,
    required this.updateJournalUsecase,
  }) : super(StateController.idle());

  void init() async {
    emit(StateController.loading());
    try {
      final result = await getJournalsByMonthUsecase.call(DateTime.now());
      if (result.isEmpty) {
        emit(StateController.success([]));
      } else {
        emit(StateController.success(result));
      }
    } catch (e, s) {
      LogService.logError('Error initializing HomeScreenCubit', e, s);
      emit(
        StateController.failure(
          errorMessage: 'Failed to initialize',
          data: null,
        ),
      );
    }
  }

  Future<bool> add(String text) async {
    if (text.isEmpty) {
      emit(
        StateController.failure(errorMessage: 'Journal text cannot be empty'),
      );
      return false;
    }

    emit(StateController.loading());
    try {
      final journal = Journal(
        text: text,
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await addJournalUsecase.call(journal);
      return true;
    } catch (e, s) {
      LogService.logError('Error adding journal', e, s);
      emit(
        StateController.failure(
          errorMessage: 'Failed to add journal',
          data: null,
        ),
      );
      return false;
    } finally {
      init();
    }
  }

  Future<bool> update(String text) async {
    if (text.isEmpty) {
      emit(
        StateController.failure(errorMessage: 'Journal text cannot be empty'),
      );
      return false;
    }

    final currentState = state.inferredData;
    emit(StateController.loading());
    try {
      if (currentState == null || currentState.isEmpty) {
        emit(StateController.failure(errorMessage: 'No journals to update'));
        return false;
      }

      final updatedJournal = currentState.first.copyWith(
        text: text,
        updatedAt: DateTime.now(),
      );
      await updateJournalUsecase.call(updatedJournal);
      return true;
    } catch (e, s) {
      LogService.logError('Error updating journal', e, s);
      emit(
        StateController.failure(
          errorMessage: 'Failed to update journal',
          data: null,
        ),
      );
      return false;
    } finally {
      init();
    }
  }
}
