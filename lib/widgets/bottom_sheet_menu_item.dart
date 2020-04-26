import 'package:flutter/material.dart';

class BottomSheetMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function toDo;

  BottomSheetMenuItem({this.label, this.icon, this.toDo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.toDo,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(217, 217, 217, 0.5),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  this.icon,
                  size: 40,
                  color: Color.fromRGBO(9, 188, 138, 1),
                ),
              ],
            ),
          ),
          Text(
            this.label,
            style: TextStyle(
                color: Colors.black54, fontFamily: 'Moserrat', fontSize: 20),
          ),
        ],
      ),
    );
  }
}
