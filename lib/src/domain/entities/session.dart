import 'session_phase.dart';
import 'session_type.dart';

class InvalidSessionParameters implements Exception {}

class Session
{
  Session(this._type) {
    if (!_type.parameters.isValid()) {
      throw InvalidSessionParameters();
    }
  }

  String get name => _type.name;
  SessionPhase get currentPhase => _currentPhase;
  Duration get currentPhaseDuration => _type.parameters.getPhaseDuration(_currentPhase);

  void reset() {
    _currentPhase = SessionPhase.inactive;
  }

  SessionPhase nextPhase() {
    _currentPhase = _getNextPhase();
    while (!_type.parameters.isPhaseDefined(_currentPhase)) {
      _currentPhase = _getNextPhase();
    }
    return _currentPhase;
  }

  SessionPhase _getNextPhase() {
    switch (_currentPhase) {
      case SessionPhase.inactive: return SessionPhase.inhale;
      case SessionPhase.inhale: return SessionPhase.holdBreath;
      case SessionPhase.holdBreath: return SessionPhase.exhale;
      case SessionPhase.exhale: return SessionPhase.holdEmptyLungs;
      case SessionPhase.holdEmptyLungs: return SessionPhase.inhale;
    }
  }

  final SessionType _type;
  SessionPhase _currentPhase = SessionPhase.inactive;
}