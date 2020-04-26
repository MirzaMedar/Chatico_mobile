import 'package:flutter/material.dart';

class BottomSheetHeaderNavItem extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;

  BottomSheetHeaderNavItem({this.text, this.icon, this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          this.icon,
          size: 30,
          color: this.active ? Color.fromRGBO(9, 188, 138, 1) : Colors.black54,
        ),
        Text(
          this.text,
          style: TextStyle(
              color:
                  this.active ? Color.fromRGBO(9, 188, 138, 1) : Colors.black54,
              fontFamily: 'Monserrat',
              fontSize: 15),
        ),
      ],
    );
  }
}
