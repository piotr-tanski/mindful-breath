import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_phase.dart';
import 'package:breath/src/domain/entities/session_type.dart';

import 'package:flutter_test/flutter_test.dart';

const kSessionName = "test";

SessionParameters getDefaultParams() => SessionParameters(
    inhale: const Duration(seconds: 4),
    holdBreath: const Duration(),
    exhale: const Duration(seconds: 6),
    holdEmptyLungs: const Duration());

SessionParameters getAdvancedParams() => SessionParameters(
    inhale: const Duration(seconds: 4),
    holdBreath: const Duration(seconds: 3),
    exhale: const Duration(seconds: 6),
    holdEmptyLungs: const Duration(seconds: 5));

SessionParameters getZeroParams() => SessionParameters(
    inhale: const Duration(),
    holdBreath: const Duration(),
    exhale: const Duration(),
    holdEmptyLungs: const Duration());

SessionType getDefaultSessionType() => SessionType(kSessionName, getDefaultParams());

SessionType getAdvancedSessionType() => SessionType(kSessionName, getAdvancedParams());

SessionType getZeroSessionType() => SessionType(kSessionName, getZeroParams());

void main() {
  test('Test session name', () {
    final session = Session(getDefaultSessionType());
    expect(session.name, kSessionName);
  });
  test('Test initial phase duration', () {
    final session = Session(getDefaultSessionType());
    session.nextPhase();
    expect(session.currentPhaseDuration, const Duration(seconds: 4));
  });
  test('Test next phase duration', () {
    final session = Session(getDefaultSessionType());

    session.nextPhase();
    final newCurrent = session.nextPhase();

    expect(newCurrent, SessionPhase.exhale);
    expect(session.currentPhaseDuration, const Duration(seconds: 6));
  });
  test('Test phase cycle', () {
    final session = Session(getAdvancedSessionType());
    var newCurrent = session.nextPhase();
    expect(newCurrent, SessionPhase.inhale);
    expect(session.currentPhaseDuration, const Duration(seconds: 4));

    newCurrent = session.nextPhase();
    expect(newCurrent, SessionPhase.holdBreath);
    expect(session.currentPhaseDuration, const Duration(seconds: 3));

    newCurrent = session.nextPhase();
    expect(newCurrent, SessionPhase.exhale);
    expect(session.currentPhaseDuration, const Duration(seconds: 6));

    newCurrent = session.nextPhase();
    expect(newCurrent, SessionPhase.holdEmptyLungs);
    expect(session.currentPhaseDuration, const Duration(seconds: 5));

    newCurrent = session.nextPhase();
    expect(newCurrent, SessionPhase.inhale);
    expect(session.currentPhaseDuration, const Duration(seconds: 4));
  });
  test('Test wrong session params', () {
    expect(() => Session(getZeroSessionType()), throwsA(isA<InvalidSessionParameters>()));
  });
}
