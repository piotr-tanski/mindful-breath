enum Notification
{
  sound,
  vibration
}

abstract class SettingsProvider
{
  Future<List<Notification>> get enabledNotifications;
}

abstract class SettingsMutator
{
  Future<void> enable(Notification notification);
  Future<void> disable(Notification notification);
}