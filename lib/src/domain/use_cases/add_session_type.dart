import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class AddSessionTypeUseCase
{
  AddSessionTypeUseCase(this._repository);

  Future<void> call(SessionType sessionType) async {
    _repository.addSession(sessionType);
  }

  final SessionTypesRepository _repository;
}