import 'package:isar/isar.dart';
import 'package:one_stop_journaling/features/journal/domain/entities/journal.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Isar? _isar;
  IsarService._privateConstructor();

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [JournalSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  static Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not initialized. Call IsarServices.init() first.');
    }
    return _isar!;
  }
}
