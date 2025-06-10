class MessageModel {
  String? senderId;
  String? messageId;
  String? text;
  bool? seen;
  DateTime? createdOn;

  MessageModel(
      {required this.senderId,
      required this.messageId,
      required this.createdOn,
      required this.seen,
      required this.text});

  MessageModel.fromMap(Map<String, dynamic> map) {
    senderId = map["senderId"];
    messageId = map["messageId"];
    text = map["text"];
    seen = map["seen"];
    createdOn = map["createdOn"];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "messageId": messageId,
      "text": text,
      "seen": seen,
      "createdOn": createdOn
    };
  }
}
