import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class DeleteJournalUsecase {
  final JournalRepository _repository;
  DeleteJournalUsecase(this._repository);

  Future<void> call(int journalId) async {
    return _repository.deleteJournal(journalId);
  }
}
