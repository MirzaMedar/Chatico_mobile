import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/chat_item.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String token;
  String userId;
  bool loading = true;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    storage.readAll().then((data) {
      setState(() {
        token = data['token'];
        userId = data['userId'];
        this.loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.loading
        ? LoaderWidet()
        : Container(
            child: FutureBuilder(
              future: ApiService.getUsers(this.token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data['users'].length,
                      itemBuilder: (context, index) {
                        bool isMe =
                            snapshot.data['users'][index]['_id'] == userId;
                        var date = DateTime.parse(
                            snapshot.data['users'][index]['date']);
                        return !isMe
                            ? ChatItem(
                                userId: snapshot.data['users'][index]['_id']
                                    .toString(),
                                date:
                                    'Joined on ${date.day}.${date.month}.${date.year}',
                                name: snapshot.data['users'][index]['name']
                                    .toString(),
                                imageUrl: snapshot.data['users'][index]
                                            ['imageUrl'] !=
                                        null
                                    ? snapshot.data['users'][index]['imageUrl']
                                        .toString()
                                    : '',
                                message: snapshot.data['users'][index]
                                        ['username']
                                    .toString(),
                                online: snapshot.data['users'][index]
                                            ['socketId'] !=
                                        null
                                    ? true
                                    : false)
                            : Text('');
                      });
                } else if (snapshot.hasError)
                  CommonMethods.showErrorToast(
                      'An error occured while getting online users list!');
                return LoaderWidet();
              },
            ),
          );
  }
}
