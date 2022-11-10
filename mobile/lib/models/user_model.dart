class UserModel {
  final String name;
  final String avatar;
  final String email;
  final String id;

  UserModel({
    required this.name,
    required this.avatar,
    required this.email,
    required this.id,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
