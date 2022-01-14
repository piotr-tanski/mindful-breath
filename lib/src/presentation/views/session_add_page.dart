import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:breath/src/presentation/blocs/add_session_types_bloc.dart';
import 'package:breath/src/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SessionAddPage extends StatefulWidget {
  const SessionAddPage({Key? key, required this.title, required this.repository}) : super(key: key);

  final String title;
  final SessionTypesRepository repository;

  @override
  State<SessionAddPage> createState() => _SessionAddPageState();
}

class _SessionAddPageState extends State<SessionAddPage> {

  @override
  void initState() {
    super.initState();
    bloc = AddSessionTypesBloc(widget.repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(title: widget.title),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text';
                    }
                    name = value;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the session name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    description = value ?? "";
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the session description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final seconds = int.parse(value);
                    if (seconds < 1) {
                      return 'The value needs to be greater than 0';
                    }
                    inhale = Duration(seconds: seconds);
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the inhalation duration',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final seconds = int.parse(value);
                    holdBreath = Duration(seconds: seconds);
                  },
                  initialValue: "0",
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the holding your breath duration',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final seconds = int.parse(value);
                    if (seconds < 1) {
                      return 'The value needs to be greater than 0';
                    }
                    exhale = Duration(seconds: seconds);
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the exhalation duration',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final seconds = int.parse(value);
                    holdEmptyLungs = Duration(seconds: seconds);
                  },
                  initialValue: "0",
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the holding your lungs empty duration',
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        backgroundColor: Colors.white,
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            bloc.add(SessionType(
                name,
                SessionParameters(
                  inhale: inhale,
                  holdBreath: holdBreath,
                  exhale: exhale,
                  holdEmptyLungs: holdEmptyLungs,
                ),
                shortDescription: description,
                description: description
            ));
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  late AddSessionTypesBloc bloc;

  final _formKey = GlobalKey<FormState>();
  var name = "";
  var description = "";
  var inhale = const Duration();
  var holdBreath = const Duration();
  var exhale = const Duration();
  var holdEmptyLungs = const Duration();
}
