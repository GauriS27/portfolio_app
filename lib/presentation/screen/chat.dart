import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/string.dart';
import 'package:portfolio_app/core/ui.dart';
import 'package:portfolio_app/data/chatroom_model.dart';
import 'package:portfolio_app/presentation/screen/home.dart';
import 'package:portfolio_app/presentation/screen/login.dart';
import 'package:portfolio_app/presentation/widget/chat/chat_messages.dart';
import 'package:portfolio_app/presentation/widget/chat/new_messages.dart';

class ChatScreen extends StatefulWidget {
  ChatroomModel chatroom;
  ChatScreen({required this.chatroom, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  var _username = "User";
  var _email = "";

  getUserName() async {
    try {
      await _fireStore.collection(userCollectionName).get().then(
        (querySnapShot) {
          for (var queryData in querySnapShot.docs) {
            // print("queryData ${queryData.id}");
            if (queryData.id == FirebaseAuth.instance.currentUser!.uid) {
              setState(() {
                _username =
                    queryData.data()[userCollectionUsernameNode].toString();
                _email = queryData.data()[userCollectionEmailNode].toString();
              });

              break;
            }
            // if (queryData[userCollectionEmailNode] ==
            //     FirebaseAuth.instance.currentUser!.uid) {}
          }
        },
      );
    } on FirebaseException catch (e) {
      print("Errorr ..........  $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              ColorConstant.scaffolfBgPrimaryColor,
              ColorConstant.scaffolfBgSecondaryColor,
              ColorConstant.scaffolfBgTernaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.65]),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                ColorConstant.scaffolfBgPrimaryColor.withOpacity(0.5),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _username,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  _email,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () async {
            //         await FirebaseAuth.instance.signOut();
            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => LoginScreen(),
            //           ),
            //           (route) => false,
            //         );
            //       },
            //       icon: Icon(
            //         Icons.exit_to_app_rounded,
            //         color: ColorConstant.greenColor.withOpacity(0.6),
            //       ))
            // ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorConstant.scaffolfBgPrimaryColor,
                    ColorConstant.scaffolfBgSecondaryColor,
                    ColorConstant.scaffolfBgTernaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.5, 0.65]),
            ),
            child: Column(
              children: [
                Expanded(
                    child: ChatMessages(
                  chatroom: widget.chatroom,
                )),
                NewMessages(
                  chatroom: widget.chatroom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
