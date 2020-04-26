import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  ProfileInfoItem({this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width * 0.05)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(9, 188, 138, 1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                this.icon,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              this.label,
              style: TextStyle(
                color: Color.fromRGBO(23, 42, 58, 1),
                fontFamily: 'Monserrat',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
