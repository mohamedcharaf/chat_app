class GroupRoom {
  String id;
  String name ;
  String image;
  List members;
  String lastMessage;
  String lastMessageTime;
  String createdAt;
  List admin ;

  GroupRoom({
    required this.id,
    required this.name,
    required this.image,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
    required this.admin,
  });

  factory GroupRoom.fromJson(Map<String, dynamic> json) {
    return GroupRoom(
      id: json['id'] ?? '',
      members: json['members'] ?? [],
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
       name: json['name'] ?? '',
        image: json['image'] ?? '', admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'createdAt': createdAt,
      'image':image,
      'name':name,
      'admin':admin,
    };
  }
}
