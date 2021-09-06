import 'package:flutter/material.dart';
import 'package:waller/screens/imageview.dart';

class ImageTile extends StatelessWidget {
  final String url;
  ImageTile({
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageView(url: url)));
      },
      child: Container(
        height: 100,
        width: 50,
        child: Image.network(
          url,
          //images[index]['src']['portrait'],
          height: 100,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
