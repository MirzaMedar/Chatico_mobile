import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final bool isMyMessage;

  Message({this.message, this.isMyMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(top: 10, left: !this.isMyMessage ? 200 : 10, right: this.isMyMessage ? 200 : 10, bottom: 10),
            padding: EdgeInsets.all(15),
            child: Text(
              this.message,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontFamily: 'Monserrat',
                  fontSize: 13),
            ),
            decoration: BoxDecoration(
                color: !this.isMyMessage ? Color.fromRGBO(9, 188, 138, 1) : Color.fromRGBO(23, 42, 58, 1),
                borderRadius: BorderRadius.only(
                  topRight: !this.isMyMessage ? Radius.circular(0) : Radius.circular(10),
                  topLeft: this.isMyMessage ? Radius.circular(0) : Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
          ),
        ),
      ],
    );
  }
}
