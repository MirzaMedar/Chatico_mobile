import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(9, 188, 138, 1),
              Colors.greenAccent
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Monserrat',
                                decoration: TextDecoration.none,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 7,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
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
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Mirza Medar',
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
                           Row(
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
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'mirzamedar@gmail.com',
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
                        Row(
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
                                    Icons.verified_user,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'mirzamedar',
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
                       
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(214, 214, 214, 1), blurRadius: 8),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          child: Icon(
                            Icons.edit,
                            color: Color.fromRGBO(23, 42, 58, 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage('images/avatar.jpg')),
                            border: Border.all(color: Color.fromRGBO(9, 188, 138, 1), width: 2),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Mirza Medar',
                      style: TextStyle(
                        color: Color.fromRGBO(23, 42, 58, 1),
                        fontFamily: 'Monserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
