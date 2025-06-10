class ChatroomModel {
   String? chatroomId;
   String? participantId;

  ChatroomModel({required this.chatroomId, required this.participantId});

  /// converting oject to Json
  ChatroomModel.fromMap(Map<String, dynamic> map) {
    this.participantId = map["participantId"];
    this.chatroomId = map["chatroomId"];
  }

/// converting Json to object
  Map<String, dynamic> toMap() {
    return {
      "chatroomId" : this.chatroomId,
      "participantId" : this.participantId
    }; 
  }
}
