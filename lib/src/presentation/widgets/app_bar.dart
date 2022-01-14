import 'package:flutter/material.dart';

AppBar createHomePageAppBar({required String title, required void Function() onClicked}) {
  return AppBar(
    title: Text(title),
    shape: const Border(
        bottom: BorderSide(
            color: Colors.grey,
            width: 4
        )
    ),
    elevation: 4,
    actions: [
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            child: const Icon(
              Icons.settings,
              size: 26.0,
            ),
            onTap: onClicked,
          )
      ),
    ],
  );
}

AppBar createCommonAppBar({required String title}) {
  return AppBar(
    title: Text(title),
    shape: const Border(
        bottom: BorderSide(
            color: Colors.grey,
            width: 4
        )
    ),
    elevation: 4,
  );
}