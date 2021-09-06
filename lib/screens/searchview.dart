import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waller/components/imagetile.dart';
import 'dart:convert';

import 'package:waller/components/loadmore.dart';

class SearchView extends StatefulWidget {
  final String query;
  SearchView({required this.query});
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrendingImages();
  }

  getTrendingImages() async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=${widget.query}&per_page=20'),
        headers: {
          'Authorization':
              '563492ad6f9170000100000178320e8b26ff421e83aadb37d0914c96'
        });
    Map result = jsonDecode(response.body);
    setState(() {
      images = result['photos'];
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/search?query=${widget.query}&per_page=20&page=$page';
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f9170000100000178320e8b26ff421e83aadb37d0914c96'
    });
    Map result = jsonDecode(response.body);
    setState(() {
      images.addAll(result['photos']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.query,
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return ImageTile(
                      url: images[index]['src']['portrait'],
                    );
                  }),
            ),
          ),
          LoadMore(onPressed: () {
            loadMore();
          }),
        ],
      ),
    );
  }
}
