import 'package:breath/src/domain/services/next_phase_notifier.dart';
import 'package:breath/src/domain/settings/settings_provider.dart' as settings;

import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class NotifierFactory {
  static NextPhaseNotifier create(List<settings.Notification> notifications) {
    if (notifications.isEmpty) {
      return NullNotifier();
    }
    if (notifications.length == 1) {
      return _getNotifier(notifications[0]);
    }
    return MixedNotifier(List.generate(notifications.length, (index) { return _getNotifier(notifications[index]); }));
  }

  static NextPhaseNotifier _getNotifier(settings.Notification notification) {
    switch (notification) {
      case settings.Notification.sound: return SoundNotifier();
      case settings.Notification.vibration: return VibrationNotifier();
    }
  }
}

class NullNotifier implements NextPhaseNotifier
{
  @override
  void notify() { }
}

class SoundNotifier implements NextPhaseNotifier
{
  @override
  void notify() async {
    const path = 'notification.mp3';
    await _player.play(path);
  }

  final _player = AudioCache();
}

class VibrationNotifier implements NextPhaseNotifier
{
  @override
  void notify() async {
    final hasVibrator = await Vibration.hasVibrator() ?? false;
    final hasCustomSupport = await Vibration.hasCustomVibrationsSupport() ?? false;
    if (hasVibrator) {
      if (hasCustomSupport) {
        Vibration.vibrate(duration: 200);
      }
      else {
        Vibration.vibrate();
      }
    }
  }
}

class MixedNotifier implements NextPhaseNotifier
{
  MixedNotifier(this._notifiers);

  @override
  void notify() async {
    for (final notifier in _notifiers) {
      notifier.notify();
    }
  }

  final List<NextPhaseNotifier> _notifiers;
}