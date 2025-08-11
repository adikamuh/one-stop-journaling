import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class AddJournalUsecase {
  final JournalRepository _journalRepository;
  AddJournalUsecase(this._journalRepository);

  Future<void> call(Journal journal) async {
    return _journalRepository.addJournal(journal);
  }
}
