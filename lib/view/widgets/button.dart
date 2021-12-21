import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.name,
    required this.onClicked,
   Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onClicked,
    height: 50,
    minWidth: 100,
    color: Colors.blue,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child:  Text(
      name,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}