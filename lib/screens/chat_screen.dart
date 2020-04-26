import 'dart:convert';

import 'package:chatico/providers/socket_provider.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:chatico/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:provider/provider.dart';
import 'package:chatico/constants/socket_events.dart' as SocketContants;

class ChatScreen extends StatefulWidget {
  var userImageUrl;
  final String userId;
  final String userFirstNameLastName;

  @override
  _ChatScreenState createState() => _ChatScreenState();

  ChatScreen({
    this.userId,
    this.userFirstNameLastName,
    this.userImageUrl,
  });
}

class _ChatScreenState extends State<ChatScreen> {
  String token;
  SocketIO socketIO;
  String loggedUserId;
  String newMessage = '';
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  var controller = new TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    storage.readAll().then((data) {
      setState(() {
        token = data['token'];
        loggedUserId = data['userId'];
      });

      this.socketIO = Provider.of<SocketProvider>(context).getSocket();
      this.socketIO.subscribe(
          SocketContants.ON_PRIVATE_MESSAGE_RECEIVED, _onMessageReceived);
    });

    print(widget.userId);
  }

  _onMessageReceived(dynamic message) {
    this.setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    this.socketIO.unSubscribe(SocketContants.ON_PRIVATE_MESSAGE_RECEIVED,
        _onMessagesSocketUnsubscriberd);
  }

  _onMessagesSocketUnsubscriberd() {
    print('::Unsubscribed from messages socket::');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(23, 42, 58, 1), blurRadius: 10)
                  ],
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      child: Hero(
                        tag: widget.userId,
                        key: ValueKey(widget.userId),
                        child: CircleAvatar(
                          backgroundImage: widget.userImageUrl != null
                              ? NetworkImage(widget.userImageUrl)
                              : ExactAssetImage('images/no-image.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: SizedBox(
                child: Container(
                  color: Colors.white,
                  child: FutureBuilder(
                    future: ApiService.getChatMessages(widget.userId, token),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemCount: snapshot.data['messages'].length,
                          itemBuilder: (context, index) {
                            return Message(
                              message: snapshot.data['messages'].reversed
                                  .toList()[index]['message'],
                              isMyMessage: snapshot.data['messages'].reversed
                                      .toList()[index]['senderId'] ==
                                  widget.userId,
                            );
                          },
                        );
                      }
                      return LoaderWidet();
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(23, 42, 58, 0.5), blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      child: TextFormField(
                                        controller: this.controller,
                                        onChanged: (value) {
                                          this.newMessage = value;
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
                                            hasFloatingPlaceholder: true,
                                            alignLabelWithHint: true,
                                            filled: true,
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                this.socketIO.sendMessage(
                                      SocketContants.ON_PRIVATE_MESSAGE_SENT,
                                      jsonEncode(
                                        {
                                          "senderId": loggedUserId,
                                          "receiverId": widget.userId,
                                          "message": this.newMessage
                                        },
                                      ),
                                    );
                                this.setState(() {
                                  this.newMessage = '';
                                  this.controller.clear();
                                });
                              },
                              child: Icon(
                                Icons.send,
                                color: Color.fromRGBO(9, 188, 138, 1),
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
