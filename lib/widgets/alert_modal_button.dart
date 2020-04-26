import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertModalButton extends StatelessWidget {
  final String label;
  final IconData icon;

  AlertModalButton({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            this.icon,
            color: Colors.white,
          ),
          Text(
            this.label,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      );
  }
}
