class ChatroomModel {
   String? chatroomId;
   String? participantId;
   String? participantName;


  ChatroomModel({required this.chatroomId, required this.participantId, required this.participantName});

  /// converting oject to Json
  ChatroomModel.fromMap(Map<String, dynamic> map) {
    this.participantId = map["participantId"];
    this.chatroomId = map["chatroomId"];
    this.participantName = map["participantName"];
  }

/// converting Json to object
  Map<String, dynamic> toMap() {
    return {
      "chatroomId" : this.chatroomId,
      "participantId" : this.participantId,
      "participantName" : this.participantName
    }; 
  }
}
