import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/use_cases/next_session_phase.dart';
import 'package:breath/src/presentation/blocs/session_bloc.dart';
import 'package:breath/src/domain/entities/session.dart';

import 'package:flutter_test/flutter_test.dart';

const kSessionName = "test";

class StubSoundNotifier implements SoundNotifier
{
  @override
  void play() { }
}

SessionParameters getDefaultParams() => SessionParameters(
    inhale: const Duration(milliseconds: 1),
    holdBreath: const Duration(milliseconds: 1),
    exhale: const Duration(milliseconds: 1),
    holdEmptyLungs: const Duration(milliseconds: 1));

SessionType getDefaultSessionType() => SessionType(kSessionName, getDefaultParams());

Session getDefaultSession() => Session(getDefaultSessionType());

void main() {
  test('Test session start & stop', () async {
    bool interrupted = false;
    final bloc = SessionBloc(getDefaultSession(), StubSoundNotifier());

    Future.delayed(const Duration(milliseconds: 50), () {
      interrupted = true;
      bloc.stopSession();
    });
    await bloc.startSession();
    bloc.dispose();

    expect(interrupted, true);
    expect(bloc.isActive, false);
  });

  test('Test session stop if not started', () async {
    final bloc = SessionBloc(getDefaultSession(), StubSoundNotifier());

    bloc.stopSession();
    bloc.dispose();
    expect(bloc.isActive, false);
  });
}
