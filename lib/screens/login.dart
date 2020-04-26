import 'package:chatico/models/sign_in.dart';
import 'package:chatico/screens/signup.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chatico/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  SignInModel model = SignInModel(username: '', password: '');

  @override
  void initState() {
    super.initState();
    setState(() {
      this.loading = true;
    });

    storage.read(key: 'token').then((data) {
      if (data != null && data.isNotEmpty) {
        ApiService.verifyToken(data).then((data) {
          if (data == true)
            goToHomeScreen();
          else {
            showSessionExpiredToast();
            setState(() {
              this.loading = false;
            });
          }
        }).catchError((e) {
          showSessionExpiredToast();
        });
      } else {
        setState(() {
          this.loading = false;
        });
      }
    });
  }

  void goToHomeScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void showSessionExpiredToast() {
    CommonMethods.showErrorToast('Session expired');
  }

  void submitForm() async {
    setState(() {
      this.loading = true;
    });
    if (_formKey.currentState.validate()) {
      try {
        var response = await ApiService.signIn(model);
        print(response['token']);
        await storage.write(key: 'token', value: response['token']);
        await storage.write(key: 'userId', value: response['userId']);

        goToHomeScreen();
      } catch (e) {
        setState(() {
          loading = false;
        });

        CommonMethods.showErrorToast('Username or password is incorrect!');
      }
    } else {
      setState(() {
        this.loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !loading
          ? Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Hero(
                            tag: 'logo',
                            child: Image.asset(
                              'images/cellphone.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(65, 148, 68, 0.9),
                              Color.fromRGBO(114, 214, 118, 0.9),
                              Color.fromRGBO(65, 148, 68, 0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(170),
                            bottomRight: Radius.circular(170),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Welcome to Chatico',
                          style: TextStyle(
                              fontFamily: 'Monserrat',
                              decoration: TextDecoration.none,
                              color: Color.fromRGBO(23, 42, 58, 1),
                              fontSize: 35),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                        child: Form(
                          key: _formKey,
                          child: KeyboardAvoider(
                            autoScroll: true,
                            child: Column(
                              children: <Widget>[
                                Material(
                                  color: Colors.white,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      this.model.username = value;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(11.0),
                                          borderSide: new BorderSide(),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(11.0),
                                          borderSide: new BorderSide(
                                              color: Color.fromRGBO(
                                                  9, 188, 138, 1)),
                                        ),
                                        hasFloatingPlaceholder: false,
                                        alignLabelWithHint: true,
                                        filled: true,
                                        hintText: 'Username',
                                        fillColor: Colors.transparent),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Username is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Material(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: TextFormField(
                                      obscureText: true,
                                      onChanged: (value) {
                                        this.model.password = value;
                                      },
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(11.0),
                                            borderSide: new BorderSide(),
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(11.0),
                                            borderSide: new BorderSide(
                                                color: Color.fromRGBO(
                                                    9, 188, 138, 1)),
                                          ),
                                          hasFloatingPlaceholder: false,
                                          alignLabelWithHint: true,
                                          filled: true,
                                          hintText: 'Password',
                                          fillColor: Colors.transparent),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  height: 50,
                                  child: OutlineButton(
                                    highlightedBorderColor:
                                        Color.fromRGBO(9, 188, 138, 1),
                                    focusColor: Color.fromRGBO(9, 188, 138, 1),
                                    textColor: Color.fromRGBO(9, 188, 138, 1),
                                    highlightColor: Colors.white,
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(9, 188, 138, 1)),
                                    onPressed: this.submitForm,
                                    child: Text('Log in'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Dont have an account? Click here',
                                      style: TextStyle(
                                          color: Color.fromRGBO(23, 42, 58, 1),
                                          decoration: TextDecoration.none,
                                          fontSize: 15,
                                          fontFamily: 'Monserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : LoaderWidet(),
    );
  }
}
