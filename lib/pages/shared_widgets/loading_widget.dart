import 'package:flutter/material.dart';

class LoadListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(),
        const Text("Please wait while we load data")
      ],
    );
    ;
  }
}
