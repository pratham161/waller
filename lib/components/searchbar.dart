import 'package:flutter/material.dart';
import 'package:waller/screens/searchview.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        cursorColor: Colors.black,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchView(query: value)));
        },
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 20),
            border: InputBorder.none),
      ),
    );
  }
}
