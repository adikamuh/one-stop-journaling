import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:collection/collection.dart';
import 'package:one_stop_journaling/core/di/injectors.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/models/state_controller.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/home/presentations/blocs/home_screen_cubit.dart';
import 'package:one_stop_journaling/features/home/presentations/components/add_journal_dialog.dart';
import 'package:one_stop_journaling/features/home/presentations/components/yesterday_journal_widget.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/add_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_month_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/update_journal_usecase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenCubit _cubit;
  final _journalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = HomeScreenCubit(
      getJournalsByMonthUsecase: sl<GetJournalsByMonthUsecase>(),
      addJournalUsecase: sl<AddJournalUsecase>(),
      updateJournalUsecase: sl<UpdateJournalUsecase>(),
    )..init();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, StateController<List<Journal>>>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is Loading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is Failure) {
          SnackbarHelper.error(
            state.inferredErrorMessage ?? 'An error occurred',
          );
        }
      },
      builder: (context, state) {
        // final bool isTodayExists =
        //     state.inferredData?.any(
        //       (journal) => journal.date.day == DateTime.now().day,
        //     ) ??
        //     false;
        final Journal? todayJournal = state.inferredData?.firstWhereOrNull(
          (journal) => journal.date.day == DateTime.now().day,
        );
        final Journal? yesterdayJournal = state.inferredData?.firstWhereOrNull(
          (journal) =>
              journal.date.day ==
              DateTime.now().subtract(const Duration(days: 1)).day,
        );
        return Scaffold(
          backgroundColor: appColors.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
                top: MediaQuery.of(context).padding.top + 20,
              ),
              child: Column(
                spacing: 24,
                children: [
                  Text(
                    'One Stop\nJournaling',
                    style: appFonts.titleSmall.bold.ts,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    DateHelper.formatDateTime(DateTime.now()),
                    style: appFonts.subtitle.semibold.ts,
                  ),
                  if (todayJournal == null) ...[
                    AppTextField(
                      controller: _journalController,
                      hint: 'How you feels about today?',
                      multiLines: true,
                    ),
                    AppButton(
                      text: 'Save',
                      isFitParent: true,
                      onTap: () {
                        _onSave();
                      },
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            todayJournal.text,
                            style: appFonts.ts,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      text: 'Edit',
                      isFitParent: true,
                      onTap: () {
                        _onEdit(todayJournal);
                      },
                    ),
                  ],
                  if (yesterdayJournal != null)
                    Row(
                      children: [
                        Expanded(
                          child: YesterdayJournalWidget(
                            journal: yesterdayJournal,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSave() async {
    if (_journalController.text.isEmpty) {
      SnackbarHelper.error('Please write something before saving.');
      return;
    }

    final result = await _cubit.add(_journalController.text);
    if (!result) return;
    SnackbarHelper.success('Journal entry saved successfully!');
    _journalController.clear();
  }

  void _onEdit(Journal journal) async {
    final result = await showDialog<Journal?>(
      context: context,
      builder: (context) =>
          AddJournalDialog(date: journal.date, journal: journal),
    );
    if (result == null) return;
    final updateResult = await _cubit.update(result.text);
    if (!updateResult) return;
    SnackbarHelper.success('Journal entry updated successfully!');
  }
}
