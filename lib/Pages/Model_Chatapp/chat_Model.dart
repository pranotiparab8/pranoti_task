class ChatMessage {
  String sender;
  String message;
  String messageType;
  String date;
  String preMsg;
  String preMsgType;
  String text;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.messageType,
    required this.date,
    required this.preMsg,
    required this.preMsgType,
    required this.text,
  });

  // factory ChatMessage.fromJson(Map<String, dynamic> json) {
  //   return ChatMessage(
  //     sender: json['sender'] ?? '',
  //     message: json['message'] ?? '',
  //     messageType: json['messageType'] ?? '',
  //     date: json['date'] ?? '',
  //     preMsg: json['preMsg'] ?? '',
  //     preMsgType: json['preMsgType'] ?? '',
  //     text: json['text'] ?? '',
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'sender': sender,
  //     'message': message,
  //     'messageType': messageType,
  //     'date': date,
  //     'preMsg': preMsg,
  //     'preMsgType': preMsgType,
  //     'text': text,
  //   };
  // }
}
