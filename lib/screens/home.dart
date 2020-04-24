import 'package:chatico/providers/socket_provider.dart';
import 'package:chatico/screens/login.dart';
import 'package:chatico/screens/profile_screen.dart';
import 'package:chatico/screens/recent_chats.dart';
import 'package:chatico/screens/users.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userId;
  SocketIO socketIO;
  int currentPage = 0;
  bool loading = false;
  final storage = new FlutterSecureStorage();

  List<Widget> pages = [
    new RecentChatsScreen(),
    new UsersScreen(),
  ];

  @override
  void initState() {
    this.initSocket().then((data) {
      print('CONNECTED TO SOCKET!');
      return;
    });

    setState(() {
      currentPage = 0;
    });

    super.initState();
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

    Provider.of<SocketProvider>(context).setSocket(socketIO);

    socketIO.init(query: "userId=${this.userId}");

    socketIO.connect();

    return Future.value();
  }

  void goToProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  void logOut() async {
    setState(() {
      this.loading = true;
    });
    await this.storage.deleteAll();
    socketIO.disconnect();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 2;

    return GestureDetector(
      child: SafeArea(
        child: !this.loading
            ? Container(
                child: Scaffold(
                  bottomNavigationBar: SlidingUpPanel(
                    minHeight: 70,
                    maxHeight: height,
                    backdropEnabled: true,
                    backdropColor: Colors.transparent,
                    color: Colors.transparent,
                    body: Scaffold(
                        appBar: AppBar(
                          leading: Container(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          elevation: 4,
                          actions: <Widget>[
                            GestureDetector(
                              onTap: logOut,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.power_settings_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          backgroundColor: Color.fromRGBO(61, 166, 94, 0.9),
                          title: Text(
                            'Chatico',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Monserrat',
                                fontSize: 20),
                          ),
                        ),
                        body: pages[this.currentPage]),
                    panel: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            padding: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey[200]),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (this.currentPage != 0)
                                              this.currentPage = 0;
                                          });
                                        },
                                        child: NavItem(
                                            text: 'Recent chats',
                                            icon: Icons.history,
                                            active: currentPage == 0),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (this.currentPage != 1)
                                              this.currentPage = 1;
                                          });
                                        },
                                        child: NavItem(
                                          text: 'Online users',
                                          icon: Icons.supervised_user_circle,
                                          active: currentPage == 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: this.goToProfile,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 0.5),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: Color.fromRGBO(
                                                      9, 188, 138, 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Profile',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Moserrat',
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                217, 217, 217, 0.5),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.settings,
                                                size: 40,
                                                color: Color.fromRGBO(
                                                    9, 188, 138, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Settings',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'Moserrat',
                                              fontSize: 20),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 0.5),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.share,
                                                  size: 40,
                                                  color: Color.fromRGBO(
                                                      9, 188, 138, 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Moserrat',
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: this.logOut,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 0.5),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.power_settings_new,
                                                    size: 40,
                                                    color: Color.fromRGBO(
                                                        9, 188, 138, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Log out',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: 'Moserrat',
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              )
            : LoaderWidet(),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;

  NavItem({this.text, this.icon, this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          this.icon,
          size: 30,
          color: this.active ? Color.fromRGBO(9, 188, 138, 1) : Colors.black54,
        ),
        Text(
          this.text,
          style: TextStyle(
              color:
                  this.active ? Color.fromRGBO(9, 188, 138, 1) : Colors.black54,
              fontFamily: 'Monserrat',
              fontSize: 15),
        ),
      ],
    );
  }
}
