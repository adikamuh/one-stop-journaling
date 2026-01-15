abstract class SettingRepository {
  Future<void> init();
  Future<void> toggleEnableLocalAuth(bool isEnabled);
  Future<bool> isLocalAuthEnabled();
}
