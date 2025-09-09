import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:one_stop_journaling/core/di/injectors.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/models/state_controller.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_month_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/update_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/presentation/blocs/journal_history_cubit.dart';
import 'package:one_stop_journaling/features/journal/presentation/blocs/journal_history_state.dart';
import 'package:one_stop_journaling/features/journal/presentation/components/journal_item_widget.dart';

class JournalHistoryScreen extends StatefulWidget {
  const JournalHistoryScreen({super.key});

  @override
  State<JournalHistoryScreen> createState() => _JournalHistoryScreenState();
}

class _JournalHistoryScreenState extends State<JournalHistoryScreen> {
  late final JournalHistoryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = JournalHistoryCubit(
      updateJournalUsecase: sl<UpdateJournalUsecase>(),
      getJournalsByMonthUsecase: sl<GetJournalsByMonthUsecase>(),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal History', style: appFonts.titleSmall.semibold.ts),
        backgroundColor: appColors.surfaceBg,
        foregroundColor: appColors.white,
      ),
      backgroundColor: appColors.background,
      body:
          BlocConsumer<
            JournalHistoryCubit,
            StateController<JournalHistoryState>
          >(
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      if (state.inferredData?.selectedMonth != null &&
                          state.inferredData?.hasNextPage != null &&
                          state.inferredData?.hasPreviousPage != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (!state.inferredData!.hasPreviousPage) {
                                  return;
                                }
                                _cubit.fetch(
                                  month: DateTime(
                                    state.inferredData!.selectedMonth.year,
                                    state.inferredData!.selectedMonth.month - 1,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: state.inferredData!.hasPreviousPage
                                    ? appColors.white
                                    : appColors.grayFont,
                                size: 20,
                              ),
                            ),
                            Text(
                              DateHelper.formatMonthYear(
                                state.inferredData!.selectedMonth,
                              ),
                              style: appFonts.subtitle.semibold.ts,
                            ),
                            IconButton(
                              onPressed: () {
                                if (!state.inferredData!.hasNextPage) {
                                  return;
                                }
                                _cubit.fetch(
                                  month: DateTime(
                                    state.inferredData!.selectedMonth.year,
                                    state.inferredData!.selectedMonth.month + 1,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: state.inferredData!.hasNextPage
                                    ? appColors.white
                                    : appColors.grayFont,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (state is Success &&
                          state.inferredData?.journals.isNotEmpty == true) ...[
                        ...state.inferredData?.journals.map(
                              (journal) => JournalItemWidget(
                                journal: journal,
                                onEdit: (journal) {
                                  _cubit.updateJournal(journal);
                                },
                              ),
                            ) ??
                            [],
                      ],
                      if (state is Success &&
                          state.inferredData?.journals.isEmpty == true) ...[
                        Text('no journal for this month', style: appFonts.ts),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
