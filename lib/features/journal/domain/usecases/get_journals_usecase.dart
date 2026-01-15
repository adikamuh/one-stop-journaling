import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';

class GetJournalsUsecase {
  final JournalRepository _repository;
  GetJournalsUsecase(this._repository);

  Future<List<Journal>> call() async {
    return await _repository.getJournals();
  }
}
