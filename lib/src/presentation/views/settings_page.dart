import 'package:breath/src/data/settings/application_settings.dart';
import 'package:breath/src/domain/settings/settings_provider.dart' as settings;
import 'package:breath/src/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPagePageState();
}

class _SettingsPagePageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final notifications = _settings.enabledNotifications;
    return Scaffold(
      appBar: createCommonAppBar(title: "Settings"),
      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
              'From Piotr Tański Programming',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center),
        ),
        color: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: notifications,
        initialData: const <settings.Notification>[],
        builder: (BuildContext context, AsyncSnapshot<List<settings.Notification>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            );
          }
          return Column(
            children: [
              SwitchListTile(
                title: const Text('Enable sounds'),
                value: snapshot.data!.contains(settings.Notification.sound),
                onChanged: (value) {
                  setState(() { _changeSetting(settings.Notification.sound, value); });
                },
                secondary: const Icon(Icons.volume_up),
              ),
              SwitchListTile(
                title: const Text('Enable vibrations'),
                value: snapshot.data!.contains(settings.Notification.vibration),
                onChanged: (value) {
                  setState(() { _changeSetting(settings.Notification.vibration, value); });
                },
                secondary: const Icon(Icons.vibration),
              ),
            ]
          );
        }
      )
    );
  }

  void _changeSetting(settings.Notification setting, bool newValue) {
    if (newValue) {
      _settings.enable(setting);
    }
    else {
      _settings.disable(setting);
    }
  }

  final _settings = PersistentSettings();
}
