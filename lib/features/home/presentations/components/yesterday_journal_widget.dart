import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

class YesterdayJournalWidget extends StatelessWidget {
  final Journal journal;
  const YesterdayJournalWidget({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Yesterday', style: appFonts.subtitle.semibold.ts),
        Text(
          DateHelper.formatDateTime(journal.date),
          style: appFonts.semibold.ts,
        ),
        Text(journal.text, style: appFonts.ts),
      ],
    );
  }
}
