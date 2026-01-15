import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

abstract class JournalRepository {
  Future<List<Journal>> getJournals();
  Future<Journal> getJournalById(int id);
  Future<void> addJournal(Journal journal);
  Future<void> updateJournal(Journal journal);
  Future<void> deleteJournal(int id);
  Future<List<Journal>> getJournalsByDate(DateTime date);
  Future<List<Journal>> getJournalsByMonth(DateTime month);
}
