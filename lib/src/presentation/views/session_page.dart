import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_phase.dart';
import 'package:breath/src/domain/entities/session_state.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/presentation/blocs/session_bloc.dart';
import 'package:breath/src/data/models/sound_notifier_impl.dart';
import 'package:breath/src/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

const kCircleMinWidth = 1.0;
const kCircleMinHeight = 1.0;
const kCircleMaxWidth = 300.0;
const kCircleMaxHeight = 300.0;

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc = SessionBloc(Session(widget.sessionType), SoundNotifierImpl());
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
  }

  void _setInhaleState(SessionState state) {
    setState(() {
      _animationDuration = state.duration;
      _currentWidth = _innerCircleMaxSize(_maxWidth);
      _currentHeight = _innerCircleMaxSize(_maxHeight);
      _displayedText = "Breathe in";
    });
  }

  void _setHoldBreathState(SessionState state) {
    setState(() {
      _animationDuration = const Duration();
      _currentWidth = _innerCircleMaxSize(_maxWidth);
      _currentHeight = _innerCircleMaxSize(_maxHeight);
      _displayedText = "Hold";
    });
  }

  double _innerCircleMaxSize(double dimension) => dimension - 5.0;

  void _setExhaleState(SessionState state) {
    setState(() {
      _animationDuration = state.duration;
      _currentWidth = kCircleMinWidth;
      _currentHeight = kCircleMinHeight;
      _displayedText = "Breathe out";
    });
  }

  void _setHoldEmptyLungsState(SessionState state) {
    setState(() {
      _animationDuration = const Duration();
      _currentWidth = kCircleMinWidth;
      _currentHeight = kCircleMinHeight;
      _displayedText = "Hold";
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxHeight = _maxWidth = _getCircleMaxRadius();
    return Scaffold(
      appBar: createAppBar(title: widget.sessionType.name),
      body: Stack(
        children: <Widget>[
          Center(
              child: Container(
                  width: _maxWidth,
                  height: _maxHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  )
              )
          ),
          Center(
              child: AnimatedContainer(
                width: _currentWidth,
                height: _currentHeight,
                duration: _animationDuration,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  )
              )
          ),
          Center(
            child: Text(_displayedText, style: Theme.of(context).textTheme.headline5),
          )
        ],
      ),
    );
  }

  double _getCircleMaxRadius() {
    const factor = 0.6;
    final base = _isPortraitMode() ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    return base * factor;
  }

  bool _isPortraitMode() => MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

  late SessionBloc _bloc;

  var _animationDuration = const Duration();
  var _currentWidth = kCircleMinWidth;
  var _currentHeight = kCircleMinHeight;
  var _maxWidth = kCircleMaxWidth;
  var _maxHeight = kCircleMaxHeight;
  var _displayedText = "";
}
