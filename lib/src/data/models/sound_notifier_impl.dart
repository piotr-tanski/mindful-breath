import 'package:breath/src/domain/use_cases/next_session_phase.dart';

import 'package:audioplayers/audioplayers.dart';

class SoundNotifierImpl implements SoundNotifier
{
  @override
  void play() async {
    const path = 'notification.mp3';
    await _player.play(path);
  }

  final _player = AudioCache();
}