import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/string.dart';
import 'package:portfolio_app/data/chatroom_model.dart';
import 'package:portfolio_app/presentation/widget/chat/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({required this.chatroom, super.key});
  ChatroomModel chatroom;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(chatCollection)
          .doc(chatroom.chatroomId)
          .collection(chatMessageNode)

          /// cause we are using reverse in listview builder to show msgs at bottom hence set the descending true
          .orderBy(chatMessageCreatedOnNode, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("No data"),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        final loadedMsg = snapshot.data!.docs;

        return ListView.builder(
            reverse: true,
            itemCount: loadedMsg.length,
            itemBuilder: (context, index) {
              final currentmsg = loadedMsg[index];
              final nextmsg = index == loadedMsg.length - 1
                  ? currentmsg
                  : loadedMsg[index + 1];
              return currentmsg.data()[chatMessageSenderIdNode] !=
                      nextmsg.data()[chatMessageSenderIdNode]
                  ? MessageBubble.first(
                      // username: "ahdksjhd",
                      message: currentmsg.data()[chatMessageTextNode],
                      isMe: currentmsg.data()[chatMessageSenderIdNode] ==
                          user.uid)
                  : MessageBubble.next(
                      message: currentmsg.data()[chatMessageTextNode],
                      isMe: currentmsg.data()[chatMessageSenderIdNode] ==
                          user.uid);
            });
      },
    );
  }
}
