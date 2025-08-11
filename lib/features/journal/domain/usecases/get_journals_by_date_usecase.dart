import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class GetJournalsByDateUsecase {
  final JournalRepository _journalRepository;
  GetJournalsByDateUsecase(this._journalRepository);

  Future<List<Journal>> call(DateTime date) async {
    return await _journalRepository.getJournalsByDate(date);
  }
}
