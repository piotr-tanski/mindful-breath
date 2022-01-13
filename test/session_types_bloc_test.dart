import 'package:breath/src/data/repositories/in_memory_session_types_repository.dart';
import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:breath/src/presentation/blocs/add_session_types_bloc.dart';
import 'package:breath/src/presentation/blocs/remove_session_types_bloc.dart';
import 'package:breath/src/presentation/blocs/retrieve_session_types_bloc.dart';

import 'package:flutter_test/flutter_test.dart';

List<SessionType> getDefaultSessionTypes() =>  <SessionType>[
  SessionType("test1", SessionParameters(inhale: const Duration(seconds: 1), exhale: const Duration(seconds: 1))),
  SessionType("test2", SessionParameters(inhale: const Duration(seconds: 1), exhale: const Duration(seconds: 1))),
  SessionType("test3", SessionParameters(inhale: const Duration(seconds: 1), exhale: const Duration(seconds: 1))),
];

List<SessionType> getZeroSessionTypes() =>  <SessionType>[];

void main() {
  test('Test get session types', () async {
    final bloc = RetrieveSessionTypesBloc(InMemorySessionTypesRepository(getDefaultSessionTypes()), NullSessionTypesRepository());

    final list = await bloc.getSessionTypes();
    expect(list.length, 3);
  });

  test('Test get session types from two sources', () async {
    final bloc = RetrieveSessionTypesBloc(InMemorySessionTypesRepository(getDefaultSessionTypes()), InMemorySessionTypesRepository(getDefaultSessionTypes()));

    final list = await bloc.getSessionTypes();
    expect(list.length, 6);
  });

  test('Test get session types if no session types', () async {
    final bloc = RetrieveSessionTypesBloc(InMemorySessionTypesRepository(getZeroSessionTypes()), NullSessionTypesRepository());

    final list = await bloc.getSessionTypes();
    expect(list.length, 0);
  });

  test('Test get session types if null repositories passed', () async {
    final bloc = RetrieveSessionTypesBloc(NullSessionTypesRepository(), NullSessionTypesRepository());

    final list = await bloc.getSessionTypes();
    expect(list.length, 0);
  });

  test('Test add session types', () async {
    final repo = InMemorySessionTypesRepository(getDefaultSessionTypes());
    final bloc = AddSessionTypesBloc(repo);

    final preList = await repo.getSessions();
    expect(preList.length, 3);

    await bloc.add(SessionType("test4", SessionParameters(inhale: const Duration(seconds: 1), exhale: const Duration(seconds: 1))));
    final postList = await repo.getSessions();
    expect(postList.length, 4);
  });

  test('Test remove session types', () async {
    final repo = InMemorySessionTypesRepository(getDefaultSessionTypes());
    final bloc = RemoveSessionTypesBloc(repo);

    final preList = await repo.getSessions();
    expect(preList.length, 3);

    await bloc.remove(preList[0]);
    final postList = await repo.getSessions();
    expect(postList.length, 2);
  });

  test('Test remove session types if no session types', () async {
    final repo = InMemorySessionTypesRepository(getZeroSessionTypes());
    final bloc = RemoveSessionTypesBloc(repo);

    final preList = await repo.getSessions();
    expect(preList.length, 0);

    await bloc.remove(SessionType("test1", SessionParameters(inhale: const Duration(seconds: 1), exhale: const Duration(seconds: 1))));
    final postList = await repo.getSessions();
    expect(postList.length, 0);
  });
}
