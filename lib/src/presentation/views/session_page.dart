import 'dart:async';

import 'package:breath/src/data/settings/application_settings.dart';
import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_phase.dart';
import 'package:breath/src/domain/entities/session_state.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/presentation/blocs/session_bloc.dart';
import 'package:breath/src/data/services/phase_notifier_impl.dart';
import 'package:breath/src/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key, required this.sessionType}) : super(key: key);

  final SessionType sessionType;

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {

  @override
  void dispose() {
    Wakelock.toggle(enable: false);
    _bloc.stopSession();
    _bloc.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _settings.enabledNotifications.then((value) {
      _bloc = SessionBloc(Session(widget.sessionType), NotifierFactory.create(value));
      _bloc.states.listen((newState) {
        switch (newState.phase) {
          case SessionPhase.inhale: _setInhaleState(newState); break;
          case SessionPhase.holdBreath: _setHoldBreathState(newState); break;
          case SessionPhase.exhale: _setExhaleState(newState); break;
          case SessionPhase.holdEmptyLungs: _setHoldEmptyLungsState(newState); break;
          case SessionPhase.inactive: break;
        }
      });
      _bloc.startSession();
      Wakelock.toggle(enable: true);
    });
  }

  void startCountdownTimer({Duration interval = const Duration(seconds: 1)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (timer) {
      if (_countdown == 1) {
        timer.cancel();
      }
      else {
        setState(() {
          --_countdown;
        });
      }
    });
  }

  void _setInhaleState(SessionState state) {
    setState(() {
      _animationDuration = state.duration;
      _countdown = state.duration.inSeconds;
      _currentRadius = _innerCircleMaxRadius(_maxRadius);
      _displayedText = "Breathe in";
    });
    startCountdownTimer();
  }

  void _setHoldBreathState(SessionState state) {
    setState(() {
      _animationDuration = const Duration();
      _countdown = state.duration.inSeconds;
      _currentRadius = _innerCircleMaxRadius(_maxRadius);
      _displayedText = "Hold";
    });
    startCountdownTimer();
  }

  double _innerCircleMaxRadius(double dimension) => dimension - 5.0;

  void _setExhaleState(SessionState state) {
    setState(() {
      _animationDuration = state.duration;
      _countdown = state.duration.inSeconds;
      _currentRadius = _minRadius;
      _displayedText = "Breathe out";
    });
    startCountdownTimer();
  }

  void _setHoldEmptyLungsState(SessionState state) {
    setState(() {
      _animationDuration = const Duration();
      _countdown = state.duration.inSeconds;
      _currentRadius = _minRadius;
      _displayedText = "Hold";
    });
    startCountdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _firstInitialization();
    }
    return Scaffold(
      appBar: createCommonAppBar(title: widget.sessionType.name),
      body: Stack(
        children: <Widget>[
          Center(
              child: Container(
                  width: _maxRadius,
                  height: _maxRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  )
              )
          ),
          Center(
              child: AnimatedContainer(
                width: _currentRadius,
                height: _currentRadius,
                duration: _animationDuration,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  )
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(_displayedText ?? "", style: Theme.of(context).textTheme.headline5)),
              Center(child: Text("$_countdown", style: Theme.of(context).textTheme.headline5)),
            ],
          ),
        ],
      ),
    );
  }

  void _firstInitialization() {
    _maxRadius = _getCircleMaxRadius();
    _currentRadius = _minRadius = _getCircleMinRadius();
    _initialized = true;
  }

  double _getCircleMaxRadius() {
    const factor = 0.8;
    final base = _isPortraitMode() ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    return base * factor;
  }

  double _getCircleMinRadius() => _getCircleMaxRadius() * 0.5;

  bool _isPortraitMode() => MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

  final _settings = PersistentSettings();

  late SessionBloc _bloc;
  late double _minRadius;
  late double _maxRadius;
  late double _currentRadius;

  var _animationDuration = const Duration();
  bool _initialized = false;
  int _countdown = 0;

  Timer? _timer;
  String? _displayedText;
}
