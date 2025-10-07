import 'package:isar_community/isar.dart';
import 'package:one_stop_journaling/core/services/isar_service.dart';
import 'package:one_stop_journaling/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';

class JournalLocalDatasourceImpl implements JournalLocalDatasource {
  @override
  Future<void> addJournal(Journal journal) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.journals.put(journal);
    });
  }

  @override
  Future<void> deleteJournal(int id) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.journals.delete(id);
    });
  }

  @override
  Future<Journal> getJournalById(int id) async {
    final journal = await IsarService.isar.journals.get(id);
    if (journal == null) {
      throw Exception('Journal with id $id not found');
    }
    return journal;
  }

  @override
  Future<List<Journal>> getJournals() async {
    return await IsarService.isar.journals.where().findAll();
  }

  @override
  Future<List<Journal>> getJournalsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await IsarService.isar.journals
        .filter()
        .dateBetween(startOfDay, endOfDay)
        .findAll();
  }

  @override
  Future<List<Journal>> getJournalsByMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    late final DateTime endOfMonth;
    if (month.month == 12) {
      endOfMonth = DateTime(
        month.year + 1,
        1,
        1,
        23,
        59,
        59,
      ).subtract(const Duration(days: 1));
    } else {
      endOfMonth = DateTime(
        month.year,
        month.month + 1,
        1,
        23,
        59,
        59,
      ).subtract(const Duration(days: 1));
    }

    return await IsarService.isar.journals
        .filter()
        .dateBetween(startOfMonth, endOfMonth)
        .findAll();
  }

  @override
  Future<void> updateJournal(Journal journal) async {
    await IsarService.isar.writeTxn(() async {
      final existingJournal = await IsarService.isar.journals.get(journal.id);
      if (existingJournal == null) {
        throw Exception('Journal with id ${journal.id} not found');
      }
      await IsarService.isar.journals.put(journal);
    });
  }
}
