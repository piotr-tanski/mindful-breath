import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class GetSessionTypesUseCase
{
  GetSessionTypesUseCase(this._repository);

  Future<List<SessionType>> call() => _repository.getSessions();

  final SessionTypesRepository _repository;
}