import 'package:flutter/material.dart';

class HorizontalSeprator extends StatelessWidget {
  const HorizontalSeprator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade700,
      height: 1,
    );
  }
}

class CircularSeprator extends StatelessWidget {
  const CircularSeprator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 1,
      backgroundColor: Colors.white,
    );
  }
}
