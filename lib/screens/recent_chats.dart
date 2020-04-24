import 'package:chatico/screens/chat_screen.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/widgets/chat_item.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

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

  @override
  void initState() {
    super.initState();

    storage.readAll().then((data) {
      setState(() {
        token = data['token'];
        userId = data['userId'];
      });
    });

    this.initSocket().then((data) {
      print('SOCKET INICIJALIZIRAN!');
      return;
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              child: FutureBuilder(
                future: ApiService.getOnlineUsers(token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data['responseArray'].length,
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data['responseArray'][index]
                                  ['_id'] ==
                              userId;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(3),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: Color.fromRGBO(9, 188, 138, 1),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: snapshot
                                                    .data['responseArray']
                                                [index]['imageUrl'] ==
                                            ''
                                        ? ExactAssetImage('images/no-image.jpg')
                                        : NetworkImage(
                                            snapshot.data['responseArray']
                                                [index]['imageUrl']),
                                  ),
                                ),
                                Text(
                                  snapshot.data['responseArray'][index]['name']
                                      .toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color.fromRGBO(23, 42, 58, 1),
                                      fontFamily: 'Monserrat',
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        });
                  } else
                    return LoaderWidet();
                },
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: FutureBuilder(
              future: ApiService.getRecentChats(this.userId, this.token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data['recentChats'].length,
                      itemBuilder: (context, index) {
                        var date = DateTime.parse(
                            snapshot.data['recentChats'][index]['date']);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  userId: snapshot.data['recentChats'][index]
                                      ['id'],
                                  userFirstNameLastName: snapshot
                                      .data['recentChats'][index]['name'],
                                  userImageUrl: snapshot.data['recentChats']
                                      [index]['imageUrl'],
                                ),
                              ),
                            );
                          },
                          child: Dismissible(
                            confirmDismiss: (direction) {
                              print(direction);
                            },
                            secondaryBackground: Container(
                              width: 50,
                              color: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 280.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add to favorites',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            background: Container(
                              width: 50,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 280.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            key: ValueKey(index.toString()),
                            child: ChatItem(
                                userId: snapshot.data['recentChats'][index]['id']
                                    .toString(),
                                date: '${date.day}.${date.month}.${date.year}',
                                name: snapshot.data['recentChats'][index]
                                        ['name']
                                    .toString(),
                                imageUrl: snapshot.data['recentChats'][index]
                                            ['imageUrl'] !=
                                        null
                                    ? snapshot.data['recentChats'][index]
                                            ['imageUrl']
                                        .toString()
                                    : '',
                                message: snapshot.data['recentChats'][index]
                                        ['lastMessage']
                                    .toString(),
                                online: snapshot.data['recentChats'][index]
                                            ['socketId'] !=
                                        null
                                    ? true
                                    : false),
                          ),
                        );
                      });
                } else
                  return LoaderWidet();
              },
            ),
          ),
        ],
      ),
    );
  }
}
