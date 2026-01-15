import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class GetJournalsByMonthUsecase {
  final JournalRepository _journalRepository;
  GetJournalsByMonthUsecase(this._journalRepository);

  Future<List<Journal>> call(DateTime month) async {
    return await _journalRepository.getJournalsByMonth(month);
  }
}
