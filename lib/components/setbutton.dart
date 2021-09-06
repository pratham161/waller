import 'package:flutter/material.dart';

class SetButton extends StatelessWidget {
  final VoidCallback onPressed;
  SetButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: MaterialButton(
          child: Text(
            'Set Wallpaper',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onPressed),
    );
  }
}
