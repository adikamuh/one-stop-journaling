import 'package:one_stop_journaling/features/settings/data/datasource/setting_local_datasource.dart';
import 'package:one_stop_journaling/features/settings/domain/entities/setting_model.dart';
import 'package:one_stop_journaling/features/settings/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingLocalDatasource _localDatasource;
  SettingRepositoryImpl(this._localDatasource) {
    init();
  }

  @override
  Future<void> init() async {
    final curSetting = await _localDatasource.getSetting();
    if (curSetting == null) {
      await _localDatasource.addAndUpdateSetting(
        SettingModel(enableLocalAuth: false),
      );
    }
  }

  @override
  Future<bool> isLocalAuthEnabled() async {
    final curSetting = await _localDatasource.getSetting();
    return curSetting?.enableLocalAuth ?? false;
  }

  @override
  Future<void> toggleEnableLocalAuth(bool isEnabled) {
    return _localDatasource.addAndUpdateSetting(
      SettingModel(enableLocalAuth: isEnabled),
    );
  }
}
