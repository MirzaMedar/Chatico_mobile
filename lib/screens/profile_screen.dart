import 'dart:convert';
import 'dart:io';

import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:chatico/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chatico/widgets/alert_modal_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user;
  String token;
  bool loading = true;
  var newImageByteArray;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    storage.readAll().then((data) {
      token = data['token'];
      setState(() {
        this.loading = false;
      });
    });
  }

  _onProfileImageClick(context) async {
    //var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //print(image.path);
    Alert(
      context: context,
      type: AlertType.none,
      title: "Pick image",
      desc: "Choose image source",
      buttons: [
        DialogButton(
          color: Color.fromRGBO(9, 188, 138, 1),
          child: AlertModalButton(
            icon: Icons.camera,
            label: 'Camera',
          ),
          onPressed: _onCameraSourcePicked,
          width: 120,
        ),
        DialogButton(
          color: Color.fromRGBO(9, 188, 138, 1),
          child: AlertModalButton(
            icon: Icons.image,
            label: 'Gallery',
          ),
          onPressed: _onGallerySourcePicked,
          width: 120,
        )
      ],
    ).show();
  }

  Future<File> _pickImage(ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: source);
      return Future.value(image);
    } catch (e) {
      CommonMethods.showErrorToast('An error occured. Try again!');
    }
  }

  _onCameraSourcePicked() async {
    setState(() {
      this.loading = true;
    });

    Navigator.pop(context);

    File image = await _pickImage(ImageSource.camera);

    if (image != null) {
      try {
        var imageBytes = await image.readAsBytes();

        await ApiService.uploadImage(imageBytes, this.token);

        setState(() {
          this.newImageByteArray = imageBytes;
          this.loading = false;
        });
      } catch (e) {
        CommonMethods.showErrorToast('An error occured. Try again!');
      }
    }
  }

  _onGallerySourcePicked() async {
    setState(() {
      this.loading = true;
    });

    Navigator.pop(context);

    File image = await _pickImage(ImageSource.gallery);

    if (image != null) {
      try {
        var imageBytes = await image.readAsBytes();

        await ApiService.uploadImage(imageBytes, this.token);

        setState(() {
          this.newImageByteArray = imageBytes;
          this.loading = false;
        });
      } catch (e) {
        print(e);
        CommonMethods.showErrorToast('An error occured. Try again!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: this.loading
          ? LoaderWidet()
          : FutureBuilder(
              future: ApiService.getUserById(token),
              builder: (context, snapshot) {
                print((snapshot.data.runtimeType));
                if (snapshot.hasData) {
                  return Container(
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
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ProfileInfoItem(
                                        icon: Icons.person,
                                        label: snapshot.data['userData']['name']
                                            .toString(),
                                      ),
                                      ProfileInfoItem(
                                        icon: Icons.email,
                                        label: snapshot.data['userData']
                                                ['email']
                                            .toString(),
                                      ),
                                      ProfileInfoItem(
                                        icon: Icons.verified_user,
                                        label: snapshot.data['userData']
                                                ['username']
                                            .toString(),
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
                                    color: Color.fromRGBO(214, 214, 214, 1),
                                    blurRadius: 8),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _onProfileImageClick(context);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 70,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: this.newImageByteArray !=
                                                          null
                                                      ? MemoryImage(this
                                                          .newImageByteArray)
                                                      : (snapshot.data['userData']['imageUrl']
                                                                      .toString() !=
                                                                  null &&
                                                              snapshot.data['userData']['imageUrl']
                                                                      .toString() !=
                                                                  ''
                                                          ? NetworkImage(snapshot
                                                              .data['userData']
                                                                  ['imageUrl']
                                                              .toString())
                                                          : ExactAssetImage(
                                                              'images/no-image.jpg'))),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      9, 188, 138, 1),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  82, 82, 82, 0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.photo_camera,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${snapshot.data['userData']['name'].toString()}',
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
                  );
                } else if (snapshot.hasError) {
                  CommonMethods.showErrorToast('An error occured. Try again!');
                }
                return LoaderWidet();
              },
            ),
    );
  }
}
