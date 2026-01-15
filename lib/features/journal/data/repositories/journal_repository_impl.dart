import 'package:one_stop_journaling/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDatasource _localDatasource;
  JournalRepositoryImpl(this._localDatasource);

  @override
  Future<List<Journal>> getJournals() async {
    final journals = await _localDatasource.getJournals();
    journals.sort((a, b) => b.date.compareTo(a.date));
    return journals;
  }

  @override
  Future<Journal> getJournalById(int id) async {
    return await _localDatasource.getJournalById(id);
  }

  @override
  Future<void> addJournal(Journal journal) async {
    await _localDatasource.addJournal(journal);
  }

  @override
  Future<void> updateJournal(Journal journal) async {
    await _localDatasource.updateJournal(journal);
  }

  @override
  Future<void> deleteJournal(int id) async {
    await _localDatasource.deleteJournal(id);
  }

  @override
  Future<List<Journal>> getJournalsByDate(DateTime date) async {
    final journals = await _localDatasource.getJournalsByDate(date);
    journals.sort((a, b) => b.date.compareTo(a.date));
    return journals;
  }

  @override
  Future<List<Journal>> getJournalsByMonth(DateTime month) async {
    final journals = await _localDatasource.getJournalsByMonth(month);
    journals.sort((a, b) => b.date.compareTo(a.date));
    return journals;
  }
}
