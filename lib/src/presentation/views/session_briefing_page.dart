import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/presentation/views/session_page.dart';
import 'package:breath/src/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';

class SessionBriefingPage extends StatefulWidget {
  const SessionBriefingPage({Key? key, required this.sessionType}) : super(key: key);

  final SessionType sessionType;

  @override
  State<SessionBriefingPage> createState() => _SessionBriefingPageState();
}

class _SessionBriefingPageState extends State<SessionBriefingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(title: "Start session"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(widget.sessionType.name, style: Theme.of(context).textTheme.headline4)),
              const Divider(
                  height: 20,
                  color: Colors.transparent
              ),
              Center(child: Text(widget.sessionType.description, style: Theme.of(context).textTheme.headline5)),
            ]
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SessionPage(sessionType: widget.sessionType)));
        },
      ),
    );
  }
}
