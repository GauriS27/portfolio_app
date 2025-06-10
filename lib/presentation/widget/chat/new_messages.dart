import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/string.dart';
import 'package:portfolio_app/data/chatroom_model.dart';
import 'package:portfolio_app/data/message_model.dart';
import 'package:uuid/uuid.dart';

class NewMessages extends StatefulWidget {
  ChatroomModel chatroom;
  NewMessages({required this.chatroom, super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _messageController = TextEditingController();
  var uuid = Uuid();

  @override
  void dispose() {
    _messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void onSend() async {
    var _enteredmsg = _messageController.text;
    if (_enteredmsg.trim().isEmpty) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser!;
    final msgId = uuid.v1();

    /// create an msg node and in that noe set the MessgModel
    MessageModel msgModel = MessageModel(
        senderId: currentUser.uid,
        messageId: msgId,
        createdOn: DateTime.now(),
        seen: false,
        text: _messageController.text);

    FirebaseFirestore.instance
        .collection(chatCollection)
        .doc(widget.chatroom.chatroomId)
        .collection(chatMessageNode)
        .doc(msgId)
        .set(msgModel.toMap());

    // final userdata = await FirebaseFirestore.instance
    //     .collection(userCollectionName)
    //     .doc(currentUser.uid)
    //     .get();

    // FirebaseFirestore.instance.collection(chatCollectionName).add({
    //   chatCollectionTextNode: _enteredmsg,
    //   chatCollectionCreatedAtNode: Timestamp.now(),
    //   chatCollectionUserIdNode: currentUser.uid,
    //   chatCollectionUserNameNode: userdata.data()!["username"],
    //   chatCollectionSentToNode: adminName,
    // });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              style: theme.textTheme.bodySmall,
              autocorrect: true,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ),
        IconButton(onPressed: onSend, icon: Icon(Icons.send))
      ],
    );
  }
}
