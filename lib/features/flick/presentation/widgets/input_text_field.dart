import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData iconData;
  const CustomTextField({
    Key key,
    this.controller,
    this.label,
    this.hint,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            iconData,
            size: 18,
            color: Colors.white,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
