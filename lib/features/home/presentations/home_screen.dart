import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:one_stop_journaling/core/di/injectors.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/models/state_controller.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/home/presentations/blocs/home_screen_cubit.dart';
import 'package:one_stop_journaling/features/home/presentations/components/add_journal_dialog.dart';
import 'package:one_stop_journaling/features/home/presentations/components/app_calendar_widget.dart';
import 'package:one_stop_journaling/features/home/presentations/components/settings_dialog.dart';
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
    _cubit = sl.registerSingleton<HomeScreenCubit>(
      HomeScreenCubit(
        getJournalsByMonthUsecase: sl<GetJournalsByMonthUsecase>(),
        addJournalUsecase: sl<AddJournalUsecase>(),
        updateJournalUsecase: sl<UpdateJournalUsecase>(),
      ),
      instanceName: AppInstances.homeCubit,
      dispose: (cubit) => cubit.close(),
    )..init();
  }

  @override
  void dispose() {
    sl.unregister<HomeScreenCubit>(instanceName: AppInstances.homeCubit);
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, StateController<HomeScreenState>>(
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
        return Scaffold(
          backgroundColor: appColors.background,
          appBar: AppBar(
            title: Text(
              'One Stop Journaling',
              style: appFonts.titleSmall.bold.ts,
            ),
            centerTitle: true,
            backgroundColor: appColors.background,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SettingsDialog(),
                  );
                },
                icon: Icon(Icons.settings_outlined, color: appColors.white),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
                top: 20,
              ),
              child: Column(
                spacing: 24,
                children: [
                  Text(
                    DateHelper.formatDateTime(DateTime.now()),
                    style: appFonts.subtitle.semibold.ts,
                  ),
                  if (state.inferredData?.todayJournal == null) ...[
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
                            state.inferredData?.todayJournal?.text ?? '-',
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
                        _onEdit(state.inferredData!.todayJournal!);
                      },
                    ),
                  ],
                  if (state.inferredData?.yesterdayJournal != null)
                    Row(
                      children: [
                        Expanded(
                          child: YesterdayJournalWidget(
                            journal: state.inferredData!.yesterdayJournal!,
                          ),
                        ),
                      ],
                    ),
                  AppCalendarWidget(
                    journals: state.inferredData?.journals ?? [],
                    onAdd: (journal) async {
                      final result = await _cubit.addByDay(journal);
                      if (result) {
                        SnackbarHelper.success(
                          'Journal entry added successfully!',
                        );
                      } else {
                        SnackbarHelper.error('Failed to add journal entry.');
                      }
                    },
                    onUpdate: (journal) async {
                      final result = await _cubit.updateByDay(journal);
                      if (result) {
                        SnackbarHelper.success(
                          'Journal entry updated successfully!',
                        );
                      } else {
                        SnackbarHelper.error('Failed to update journal entry.');
                      }
                    },
                  ),
                  const SizedBox(height: 10),
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

    final result = await _cubit.addToday(_journalController.text);
    if (result) {
      SnackbarHelper.success('Journal entry saved successfully!');
      _journalController.clear();
    } else {
      SnackbarHelper.error('Failed to save journal entry.');
    }
  }

  void _onEdit(Journal journal) async {
    final result = await showDialog<Journal?>(
      context: context,
      builder: (context) =>
          AddJournalDialog(date: journal.date, journal: journal),
    );
    if (result == null) return;
    final updateResult = await _cubit.updateToday(result.text);
    if (updateResult) {
      SnackbarHelper.success('Journal entry updated successfully!');
    } else {
      SnackbarHelper.error('Failed to update journal entry.');
    }
  }
}
