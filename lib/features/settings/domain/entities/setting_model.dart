import 'package:isar_community/isar.dart';

part 'setting_model.g.dart';

@collection
class SettingModel {
  Id id = Isar.autoIncrement;
  final bool enableLocalAuth;

  SettingModel({this.id = Isar.autoIncrement, required this.enableLocalAuth});

  SettingModel copyWith({bool? enableLocalAuth}) {
    return SettingModel(
      id: id,
      enableLocalAuth: enableLocalAuth ?? this.enableLocalAuth,
    );
  }
}
