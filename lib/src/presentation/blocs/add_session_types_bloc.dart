import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:breath/src/domain/use_cases/add_session_type.dart';

class AddSessionTypesBloc
{
  AddSessionTypesBloc(this._sessionTypesRepo);

  Future<void> add(SessionType sessionType) async {
    final addSession = AddSessionTypeUseCase(_sessionTypesRepo);
    await addSession(sessionType);
  }

  final SessionTypesRepository _sessionTypesRepo;
}