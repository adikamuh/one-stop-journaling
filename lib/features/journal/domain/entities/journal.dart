import 'package:isar/isar.dart';

part 'journal.g.dart';

@collection
class Journal {
  Id id = Isar.autoIncrement;
  final String text;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Journal({
    this.id = Isar.autoIncrement,
    required this.text,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  Journal copyWith({
    String? text,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Journal(
      id: id,
      text: text ?? this.text,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
