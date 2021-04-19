import 'package:flutter/material.dart';

class CustomIcons extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onPressed;
  const CustomIcons({this.text, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(iconData), onPressed: onPressed),
        Text(text)
      ],
    );
  }
}
