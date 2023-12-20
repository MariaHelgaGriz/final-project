class User {
  final int id;
  final String username;
  final String sessionId;
  final bool status;
  User({
    required this.id,
    required this.username,
    required this.sessionId,
    required this.status,
  });

  static User get init =>
      User(id: 0, username: '', sessionId: '', status: false);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userid': id,
      'username': username,
      'sessionid': sessionId,
      'status': status,
    };
  }

  factory User.fromJson(Map? json) {
    if (json == null) return User.init;
    return User(
      id: json['userid'],
      username: json['username'],
      sessionId: json['sessionid'],
      status: json['status'],
    );
  }
}
