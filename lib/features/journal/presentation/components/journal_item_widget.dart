import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/home/presentations/components/add_journal_dialog.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

class JournalItemWidget extends StatelessWidget {
  final Journal journal;
  final Function(Journal journal) onEdit;
  const JournalItemWidget({
    super.key,
    required this.journal,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: appColors.surfaceBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateHelper.formatDateTime(journal.date),
                style: appFonts.semibold.ts,
              ),
              GestureDetector(
                onTap: () => _onEdit(context),
                child: Icon(Icons.edit, size: 16, color: appColors.primary),
              ),
            ],
          ),
          Text(journal.text, style: appFonts.ts),
        ],
      ),
    );
  }

  void _onEdit(BuildContext context) async {
    final result = await showDialog<Journal?>(
      context: context,
      builder: (context) =>
          AddJournalDialog(date: journal.date, journal: journal),
    );

    if (result == null) return;
    onEdit(result);
  }
}
