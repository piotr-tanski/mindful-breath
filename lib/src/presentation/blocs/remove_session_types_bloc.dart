import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:breath/src/domain/use_cases/remove_session_type.dart';

class RemoveSessionTypesBloc
{
  RemoveSessionTypesBloc(this._sessionTypesRepo);

  Future<void> remove(SessionType sessionType) async {
    final removeSession = RemoveSessionTypeUseCase(_sessionTypesRepo);
    await removeSession(sessionType);
  }

  final SessionTypesRepository _sessionTypesRepo;
}