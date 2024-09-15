class ChatUser {
  String? id;
  String? name;
  String? email;
  String? about;
  String? image;
  String? createdAt;
  String? lastActivated;
  String? pushToken;
  bool? online;
  List? myUsers ;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.createdAt,
    required this.lastActivated,
    required this.pushToken,
    required this.online,
    required this.myUsers,
  });
  factory ChatUser.fromJson(Map<String,dynamic> json){
    return 
    ChatUser(
      id: json['id'], 
      name:json['name'] , 
      email: json['email'], 
      about: json['about'],
      image: json['image'],
      createdAt: json['created'],
      lastActivated: json['lastActivated'],
      pushToken:json['pushToken'], 
      online: json['online'],
      myUsers: json['my_users']);
  }
  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'email': email,
    'about': about,
    'image': image,
    'createdAt': createdAt,
    'lastActivated': lastActivated,
    'pushToken': pushToken,
    'online':online,
    'my_users':myUsers,
  };
}

}
