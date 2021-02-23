import 'package:flutter/material.dart';

class PopUpItem extends StatelessWidget {
  IconData iconData;
  String text;
  PopUpItem(this.iconData, this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
