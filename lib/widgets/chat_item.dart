import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final String imageUrl;
  final bool online;
  final String message;
  final String date;
  final String name;
  final String userId;

  ChatItem(
      {this.imageUrl,
      this.online,
      this.message,
      this.date,
      this.name,
      this.userId});

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: Hero(
                                      tag: widget.userId,
                                      key: ValueKey(widget.userId),
                                      child: CircleAvatar(
                                        backgroundImage: widget.imageUrl.isEmpty
                                            ? ExactAssetImage(
                                                'images/no-image.jpg')
                                            : NetworkImage(widget.imageUrl),
                                      ),
                                    ),
                                  ),
                                  widget.online
                                      ? Positioned(
                                          top: 50,
                                          left: 50,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  9, 188, 138, 1),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.name,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    fontFamily: 'Monserrat'),
                              ),
                              Text(
                                widget.message,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    fontFamily: 'Monserrat'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 0.7, color: Colors.grey[300]),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    widget.date,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Monserrat'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
