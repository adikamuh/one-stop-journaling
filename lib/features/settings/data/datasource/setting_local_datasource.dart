import 'package:one_stop_journaling/features/settings/domain/entities/setting_model.dart';

abstract class SettingLocalDatasource {
  Future<void> addAndUpdateSetting(SettingModel setting);
  Future<SettingModel?> getSetting();
}
