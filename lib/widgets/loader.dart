import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SpinKitWave(
        color: Color.fromRGBO(9, 188, 138, 1),
        size: 40.0,
      ),
    );
  }
}
