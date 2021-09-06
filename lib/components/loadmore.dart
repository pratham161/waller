import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final VoidCallback onPressed;
  LoadMore({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      width: double.infinity,
      child: TextButton(
          child: Text(
            'Load More',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: onPressed),
    );
  }
}
