import 'package:chatico/screens/chat_screen.dart';
import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/chat_item.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';

class RecentChatsList extends StatelessWidget {
  final String userId;
  final String token;

  RecentChatsList({this.userId, this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            userId: snapshot.data['recentChats'][index]['id'],
                            userFirstNameLastName: snapshot.data['recentChats']
                                [index]['name'],
                            userImageUrl: snapshot.data['recentChats'][index]
                                ['imageUrl'],
                          ),
                        ),
                      );
                    },
                    child: Dismissible(
                      confirmDismiss: (direction) {
                        print(direction);
                      },
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        width: 50,
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 280.0),
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
                          name: snapshot.data['recentChats'][index]['name']
                              .toString(),
                          imageUrl: snapshot.data['recentChats'][index]
                                      ['imageUrl'] !=
                                  null
                              ? snapshot.data['recentChats'][index]['imageUrl']
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
          } else if (snapshot.hasError)
            CommonMethods.showErrorToast(
                'An error occured while getting online users list!');
          return LoaderWidet();
        },
      ),
    );
  }
}
