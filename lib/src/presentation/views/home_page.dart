import 'package:breath/src/data/repositories/custom_session_types_repository.dart';
import 'package:breath/src/data/repositories/predefined_session_types_repository.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/presentation/blocs/remove_session_types_bloc.dart';
import 'package:breath/src/presentation/views/session_add_page.dart';
import 'package:breath/src/presentation/views/session_briefing_page.dart';
import 'package:breath/src/presentation/views/settings_page.dart';
import 'package:breath/src/presentation/widgets/app_bar.dart';
import 'package:breath/src/presentation/widgets/session_list_item.dart';
import 'package:breath/src/presentation/blocs/retrieve_session_types_bloc.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    retrieveBloc = RetrieveSessionTypesBloc(PredefinedSessionTypesRepository(), _customSessionTypesRepository);
    removeBloc = RemoveSessionTypesBloc(_customSessionTypesRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createHomePageAppBar(title: widget.title, onClicked: onSettingsClicked),
      body: FutureBuilder(
        future: retrieveBloc.getSessionTypes(),
        initialData: const <SessionType>[],
        builder: (BuildContext context, AsyncSnapshot<List<SessionType>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              )
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
             return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
          }
          return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                if (!item.predefined) {
                  return Dismissible(
                      key: Key(item.name),
                      onDismissed: (direction) {
                         setState(() {
                            removeBloc.remove(item);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Session \'${item.name}\' deleted')));
                      },
                      child: SessionListItem(item.name, item.shortDescription)
                          .build(context, () => onSessionChosen(item)),
                      background: Container(color: Colors.red.shade900));
                }
                return SessionListItem(item.name, item.shortDescription)
                    .build(context, () => onSessionChosen(item));
              }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.white,
        onPressed: onSessionAdd,
      ),
    );
  }

  void onSettingsClicked() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  void onSessionChosen(SessionType session) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SessionBriefingPage(sessionType: session)));
  }
  
  void onSessionAdd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SessionAddPage(title: "Add session", repository: _customSessionTypesRepository))).then((value) {
      setState(() { });
    });
  }

  late RetrieveSessionTypesBloc retrieveBloc;
  late RemoveSessionTypesBloc removeBloc;
  final _customSessionTypesRepository = CustomSessionTypesRepositoryFactory.create();
}
