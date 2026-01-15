import 'package:isar_community/isar.dart';
import 'package:one_stop_journaling/core/services/isar_service.dart';
import 'package:one_stop_journaling/features/settings/data/datasource/setting_local_datasource.dart';
import 'package:one_stop_journaling/features/settings/domain/entities/setting_model.dart';

class SettingLocalDatasourceImpl implements SettingLocalDatasource {
  @override
  Future<void> addAndUpdateSetting(SettingModel setting) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.settingModels.put(setting);
    });
  }

  @override
  Future<SettingModel?> getSetting() async {
    final settings = await IsarService.isar.settingModels.where().findAll();
    if (settings.isNotEmpty) {
      return settings.first;
    }
    return null;
  }
}
