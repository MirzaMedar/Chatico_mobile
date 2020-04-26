import 'package:chatico/models/sign_up.dart';
import 'package:chatico/screens/login.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  SignUpModel model =
      SignUpModel(name: '', email: '', password: '', username: '');

  void submitForm() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await ApiService.signUp(this.model);
        CommonMethods.showSuccessToast('Account created successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } catch (e) {
        setState(() {
          loading = false;
        });
        CommonMethods.showErrorToast('An error occured. Please try again!');
      }
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
                        flex: 1,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Hero(
                              tag: 'logo',
                              child: Image.asset(
                                'images/cellphone.png',
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
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontFamily: 'Monserrat',
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(23, 42, 58, 1),
                                fontSize: 35),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 50, top: 10),
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
                                        this.model.name = value;
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
                                          hintText: 'Name',
                                          fillColor: Colors.transparent),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Material(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 20),
                                      child: TextFormField(
                                        onChanged: (value) {
                                          this.model.email = value;
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      11.0),
                                              borderSide: new BorderSide(),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      11.0),
                                              borderSide: new BorderSide(
                                                  color: Color.fromRGBO(
                                                      9, 188, 138, 1)),
                                            ),
                                            hasFloatingPlaceholder: false,
                                            alignLabelWithHint: true,
                                            filled: true,
                                            hintText: 'Email',
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
                                          return '';
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
                                        onChanged: (value) {
                                          this.model.password = value;
                                        },
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      11.0),
                                              borderSide: new BorderSide(),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      11.0),
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
                                      focusColor:
                                          Color.fromRGBO(9, 188, 138, 1),
                                      textColor: Color.fromRGBO(9, 188, 138, 1),
                                      highlightColor: Colors.white,
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(9, 188, 138, 1)),
                                      onPressed: this.submitForm,
                                      child: Text('Sign up'),
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
            : LoaderWidet());
  }
}
