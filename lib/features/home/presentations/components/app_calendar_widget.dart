import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/home/presentations/components/add_journal_dialog.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/presentation/journal_history_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendarWidget extends StatefulWidget {
  final List<Journal> journals;
  final Function(Journal journal) onUpdate;
  final Function(Journal journal) onAdd;
  const AppCalendarWidget({
    super.key,
    required this.journals,
    required this.onUpdate,
    required this.onAdd,
  });

  @override
  State<AppCalendarWidget> createState() => _AppCalendarWidgetState();
}

class _AppCalendarWidgetState extends State<AppCalendarWidget> {
  final DateTime now = DateTime.now();
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = now;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('History', style: appFonts.subtitle.semibold.ts),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const JournalHistoryScreen(),
                  ),
                );
              },
              child: Text('see all', style: appFonts.primary.ts),
            ),
          ],
        ),
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime(now.year, now.month, 1),
          startingDayOfWeek: StartingDayOfWeek.monday,
          lastDay: now,
          onDaySelected: _onDaySelected,
          headerStyle: HeaderStyle(
            titleTextStyle: appFonts.bold.ts,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.chevron_left, color: appColors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: appColors.white),
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            headerPadding: const EdgeInsets.only(bottom: 18),
          ),
          availableGestures: AvailableGestures.none,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: appFonts.ts,
            weekendStyle: appFonts.ts,
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: appFonts.ts,
            outsideDaysVisible: false,
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: _dayBuilder,
            todayBuilder: _dayBuilder,
            disabledBuilder: (context, day, focusedDay) {
              return Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: Text(day.day.toString(), style: appFonts.gray.ts),
                ),
              );
            },
          ),
        ),
        _buildJournalByDay(context, _focusedDay),
      ],
    );
  }

  Widget _buildJournalByDay(BuildContext context, DateTime day) {
    final journal = widget.journals.firstWhereOrNull(
      (journal) =>
          journal.date.day == day.day &&
          journal.date.month == day.month &&
          journal.date.year == day.year,
    );

    if (journal == null) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text('no journal for this day', style: appFonts.ts),
                AppButton(
                  text: 'Add Journal',
                  onTap: () {
                    _onAdd(day);
                  },
                  isFitParent: true,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateHelper.formatDateTime(_focusedDay),
              style: appFonts.semibold.ts,
            ),
            IconButton(
              onPressed: () {
                _onEdit(journal);
              },
              icon: Icon(Icons.edit, color: appColors.primary, size: 20),
            ),
          ],
        ),
        Text(journal.text, style: appFonts.ts),
      ],
    );
  }

  void _onEdit(Journal journal) async {
    final result = await showDialog<Journal?>(
      context: context,
      builder: (context) {
        return AddJournalDialog(date: journal.date, journal: journal);
      },
    );

    if (result != null) {
      widget.onUpdate(result);
    }
  }

  void _onAdd(DateTime date) async {
    final result = await showDialog<Journal?>(
      context: context,
      builder: (context) {
        return AddJournalDialog(date: date);
      },
    );

    if (result != null) {
      widget.onAdd(result);
    }
  }

  Widget _dayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    final bool hasJournal = widget.journals.any(
      (journal) => journal.date.day == day.day,
    );
    final bool isFocused =
        day.day == focusedDay.day &&
        day.month == focusedDay.month &&
        day.year == focusedDay.year;

    late final Color bgColor;
    if (isFocused) {
      bgColor = appColors.primary;
    } else if (hasJournal) {
      bgColor = appColors.primary.withValues(alpha: 0.5);
    } else {
      bgColor = Colors.transparent;
    }

    return Container(
      width: 30,
      height: 30,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: Text(day.day.toString(), style: appFonts.ts)),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }
}
