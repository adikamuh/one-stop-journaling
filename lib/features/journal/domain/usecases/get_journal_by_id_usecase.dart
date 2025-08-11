import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class GetJournalByIdUsecase {
  final JournalRepository _repository;
  GetJournalByIdUsecase(this._repository);

  Future<Journal?> call(int id) async {
    return await _repository.getJournalById(id);
  }
}
