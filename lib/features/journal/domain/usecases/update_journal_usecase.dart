import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class UpdateJournalUsecase {
  final JournalRepository _repository;
  UpdateJournalUsecase(this._repository);

  Future<void> call(Journal journal) async {
    return _repository.updateJournal(journal);
  }
}
