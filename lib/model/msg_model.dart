class Message {
  String? id;
  String? toId;
  String? fromId;
  String? msg;
  String? type;
  String? createdAt;
  String? read;
  String? roomId;

  Message({
    required this.id,
    required this.createdAt,
    required this.fromId,
    required this.msg,
    required this.read,
    required this.toId,
    required this.type,
    required this.roomId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      fromId: json['fromId'] ?? '',
      msg: json['msg'] ?? '',
      read: json['read'] ?? '',
      toId: json['toId'] ?? '',
      type: json['type'] ?? '',
      roomId: json['roomId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'msg': msg,
      'read': read,
      'toId': toId,
      'type': type,
      'fromId': fromId,
      'roomId': roomId,
    };
  }
}
