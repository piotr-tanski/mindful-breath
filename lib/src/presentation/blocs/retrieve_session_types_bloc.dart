import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:breath/src/domain/use_cases/get_session_types.dart';

class RetrieveSessionTypesBloc
{
  RetrieveSessionTypesBloc(this._predefinedSessionTypesRepo, this._customSessionTypesRepo);

  Future<List<SessionType>> getSessionTypes() async {
    final predefinedSessionTypes = _getSessionTypes(_predefinedSessionTypesRepo);
    final customSessionTypes = _getSessionTypes(_customSessionTypesRepo);
    final sessionTypes = await Future.wait([predefinedSessionTypes, customSessionTypes]);
    return Future(() => <SessionType>[...sessionTypes[0], ...sessionTypes[1]]);
  }

  Future<List<SessionType>> _getSessionTypes(SessionTypesRepository repository) async {
    final getSessionTypes = GetSessionTypesUseCase(repository);
    return getSessionTypes();
  }

  final SessionTypesRepository _predefinedSessionTypesRepo;
  final SessionTypesRepository _customSessionTypesRepo;
}