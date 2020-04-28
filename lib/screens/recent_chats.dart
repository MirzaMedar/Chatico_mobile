import 'package:chatico/widgets/loader.dart';
import 'package:chatico/widgets/online_users_horizontal_list.dart';
import 'package:chatico/widgets/recent_chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

class RecentChatsScreen extends StatefulWidget {
  SocketIO socketIO;

  RecentChatsScreen({this.socketIO});

  @override
  _RecentChatsScreenState createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  final storage = new FlutterSecureStorage();
  String token;
  String userId;
  SocketIO socketIO;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    storage.readAll().then((data) {
      setState(() {
        token = data['token'];
        userId = data['userId'];
      });
    });

    /*this.initSocket().then((data) {
      setState(() {
        this.loading = false;
      });
      return;
    })*/
  }

/*
  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  Future<void> initSocket() async {
    this.userId = await storage.read(key: 'userId');
    print("USERID:${this.userId}");

    socketIO = SocketIOManager().createSocketIO(
      ApiService.getApiUrl(),
      "/",
      query: "{'userId': ${this.userId}}",
      socketStatusCallback: _socketStatus,
    );

    print("INIT SOCKET!!!");
    socketIO.init(query: "userId=${this.userId}");
    print("prosao init");
    socketIO.connect();
    print("prosao connect");

    return Future.value();
  }*/

  @override
  Widget build(BuildContext context) {
    return this.loading
        ? LoaderWidet()
        : Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: OnlineUsersHorizontalList(
                    token: this.token,
                    userId: this.userId,
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: RecentChatsList(
                    token: this.token,
                    userId: this.userId,
                  ),
                ),
              ],
            ),
          );
  }
}
