import 'package:flutter/material.dart';

class OnlineUserHorizontalListItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  OnlineUserHorizontalListItem({this.imageUrl, this.name});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Color.fromRGBO(9, 188, 138, 1),
              ),
            ),
            child: CircleAvatar(
              backgroundImage:
                  this.imageUrl == ''
                      ? ExactAssetImage('images/no-image.jpg')
                      : NetworkImage(
                          this.imageUrl),
            ),
          ),
          Text(
            this.name,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Color.fromRGBO(23, 42, 58, 1),
                fontFamily: 'Monserrat',
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
