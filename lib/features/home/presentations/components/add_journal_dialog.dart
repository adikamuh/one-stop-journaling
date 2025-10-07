import 'package:flutter/material.dart';
import 'package:one_stop_journaling/core/shared/helpers/helper.dart';
import 'package:one_stop_journaling/core/shared/themes/themes.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

class AddJournalDialog extends StatefulWidget {
  final Journal? journal;
  final DateTime date;
  final bool isEdit;
  const AddJournalDialog({super.key, this.journal, required this.date})
    : isEdit = journal != null;

  @override
  State<AddJournalDialog> createState() => _AddJournalDialogState();
}

class _AddJournalDialogState extends State<AddJournalDialog> {
  final TextEditingController _journalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _journalController.text = widget.journal!.text;
    } else {
      _journalController.text = '';
    }
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: appColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Text(
              widget.isEdit
                  ? DateHelper.formatDateTime(widget.journal!.date)
                  : DateHelper.formatDateTime(widget.date),
              style: appFonts.subtitle.semibold.ts,
            ),
            AppTextField(
              controller: _journalController,
              hint: 'How you feels about today?',
              multiLines: true,
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    text: 'Cancel',
                    isFitParent: true,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: AppButton(
                    text: widget.isEdit ? 'Update' : 'Save',
                    isFitParent: true,
                    onTap: () {
                      if (_journalController.text.isEmpty) {
                        SnackbarHelper.error('Journal text cannot be empty');
                        return;
                      }
                      late final Journal newJournal;
                      if (widget.isEdit) {
                        newJournal = widget.journal!.copyWith(
                          text: _journalController.text,
                          updatedAt: DateTime.now(),
                        );
                      } else {
                        newJournal = Journal(
                          
                          text: _journalController.text,
                          date: widget.date,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                      }
                      Navigator.of(context).pop(newJournal);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
