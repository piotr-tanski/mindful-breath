import 'package:flutter/material.dart';

class SessionListItem {
  SessionListItem(this.heading, this.description);

  Widget build(BuildContext context, void Function() onPressed) {
    return TextButton(
      child: Column(
        children: [
          Text(
            heading,
            style: Theme.of(context).textTheme.headline5,
          ),
          const Divider(height: 20),
          Text(
            description,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
      onPressed: onPressed,
    );
  }

  final String heading;
  final String description;
}