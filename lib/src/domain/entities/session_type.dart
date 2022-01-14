import 'session_params.dart';

import 'package:equatable/equatable.dart';

class SessionType with EquatableMixin
{
  SessionType(this.name, this.parameters, {this.shortDescription = "", this.description = "", this.predefined = false, this.id = -1});

  int id;
  final String name;
  final String shortDescription;
  final String description;
  final SessionParameters parameters;
  final bool predefined;

  @override
  List<Object> get props {
    return [name, parameters];
  }
}