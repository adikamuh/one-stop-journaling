import 'package:get_it/get_it.dart';
import 'package:one_stop_journaling/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:one_stop_journaling/features/journal/data/datasources/journal_local_datasource_impl.dart';
import 'package:one_stop_journaling/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:one_stop_journaling/features/journal/domain/repositories/journal_repository.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/add_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/delete_journal_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journal_by_id_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_date_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_by_month_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/get_journals_usecase.dart';
import 'package:one_stop_journaling/features/journal/domain/usecases/update_journal_usecase.dart';

final sl = GetIt.instance;

void initCoreDependencies() {
  // Journal Modules
  sl.registerLazySingleton<JournalLocalDatasource>(
    () => JournalLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(sl<JournalLocalDatasource>()),
  );
  sl.registerFactory<AddJournalUsecase>(
    () => AddJournalUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<DeleteJournalUsecase>(
    () => DeleteJournalUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<GetJournalByIdUsecase>(
    () => GetJournalByIdUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<GetJournalsByDateUsecase>(
    () => GetJournalsByDateUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<GetJournalsByMonthUsecase>(
    () => GetJournalsByMonthUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<GetJournalsUsecase>(
    () => GetJournalsUsecase(sl<JournalRepository>()),
  );
  sl.registerFactory<UpdateJournalUsecase>(
    () => UpdateJournalUsecase(sl<JournalRepository>()),
  );
  // End of Journal Modules
}
