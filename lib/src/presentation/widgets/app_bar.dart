import 'package:flutter/material.dart';

AppBar createAppBar({required String title}) {
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