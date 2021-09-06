import 'package:flutter/material.dart';
import 'package:waller/components/categorytile.dart';
import 'package:waller/components/imagetile.dart';
import 'package:waller/components/loadmore.dart';
import 'package:waller/components/searchbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        Uri.parse('https://api.pexels.com/v1/curated?per_page=20'),
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
    String url = 'https://api.pexels.com/v1/curated?per_page=20&page=$page';
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
        elevation: 0,
        centerTitle: true,
        title: Text(
          'WALL-ART',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBar(),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  CategoryTile(
                    title: 'Dark',
                    imagePath: 'images/dark.jpg',
                  ),
                  CategoryTile(
                    title: 'Black & white',
                    imagePath: 'images/b&w.jpg',
                  ),
                  CategoryTile(
                    title: 'Nature',
                    imagePath: 'images/nature.jpg',
                  ),
                  CategoryTile(
                    title: 'Wildlife',
                    imagePath: 'images/wildlife.jpg',
                  ),
                  CategoryTile(
                    title: 'Cars',
                    imagePath: 'images/cars.jpg',
                  ),
                  CategoryTile(
                    title: 'Bikes',
                    imagePath: 'images/bikes.jpg',
                  ),
                  CategoryTile(
                    title: 'Motivation',
                    imagePath: 'images/motivation.jpg',
                  ),
                  CategoryTile(
                    title: 'City',
                    imagePath: 'images/city.jpg',
                  ),
                  CategoryTile(
                    title: 'Street Art',
                    imagePath: 'images/streetart.jpg',
                  ),
                  CategoryTile(
                    title: 'Texture',
                    imagePath: 'images/texture.jpg',
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}
