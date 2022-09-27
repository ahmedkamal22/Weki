class MessageModel {
  String? receiverId;
  String? senderId;
  String? messageText;
  String? messageDate;

  MessageModel({
    this.receiverId,
    this.senderId,
    this.messageText,
    this.messageDate,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    receiverId = json["receiverId"];
    senderId = json["senderId"];
    messageText = json["messageText"];
    messageDate = json["messageDate"];
  }

  Map<String, dynamic> toMap() {
    return {
      "receiverId": receiverId,
      "senderId": senderId,
      "messageText": messageText,
      "messageDate": messageDate,
    };
  }
}
