import 'package:breath/src/domain/settings/settings_provider.dart' as settings;

import 'package:shared_preferences/shared_preferences.dart';

class Settings
{
  static const enableSound = "enable_sound";
  static const enableVibration = "enable_vibration";

  static const defaultSoundSetting = true;
  static const defaultVibrationSetting = false;
}

class PersistentSettings implements settings.SettingsProvider, settings.SettingsMutator
{
  @override
  Future<List<settings.Notification>> get enabledNotifications => _getEnabledNotifications();

  Future<List<settings.Notification>> _getEnabledNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return Future(() {
      var list = <settings.Notification>[];
      if (_isSoundNotificationEnabled(prefs)) {
        list.add(settings.Notification.sound);
      }
      if (_isVibrationEnabled(prefs)) {
        list.add(settings.Notification.vibration);
      }
      return list;
    });
  }

  bool _isSoundNotificationEnabled(SharedPreferences prefs) => prefs.getBool(Settings.enableSound) ?? Settings.defaultSoundSetting;
  bool _isVibrationEnabled(SharedPreferences prefs) => prefs.getBool(Settings.enableVibration) ?? Settings.defaultVibrationSetting;

  @override
  Future<void> enable(settings.Notification notification) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_toSettingString(notification), true);
  }

  @override
  Future<void> disable(settings.Notification notification) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_toSettingString(notification), false);
  }

  String _toSettingString(settings.Notification notification) {
    switch (notification) {
      case settings.Notification.sound: return Settings.enableSound;
      case settings.Notification.vibration: return Settings.enableVibration;
    }
  }
}