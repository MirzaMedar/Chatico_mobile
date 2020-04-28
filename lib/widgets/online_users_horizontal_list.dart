import 'package:chatico/services/api.dart';
import 'package:chatico/utils/common_methods.dart';
import 'package:chatico/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'online_user_horizontal_list_item.dart';

class OnlineUsersHorizontalList extends StatelessWidget {
  final String token;
  final String userId;

  OnlineUsersHorizontalList({this.token, this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ApiService.getOnlineUsers(token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data['responseArray'].length,
                itemBuilder: (context, index) {
                  bool isMe =
                      snapshot.data['responseArray'][index]['_id'] == userId;
                  return OnlineUserHorizontalListItem(
                      name: snapshot.data['responseArray'][index]['name']
                          .toString(),
                      imageUrl: snapshot.data['responseArray'][index]
                              ['imageUrl']
                          .toString());
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
