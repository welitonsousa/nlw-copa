import 'package:mobile/models/user_model.dart';

class PoolModel {
  final int count;
  final String id;
  final String code;
  final String title;
  final DateTime createdAt;
  final List<UserModel> participants;
  final UserModel? owner;

  PoolModel({
    required this.count,
    required this.id,
    required this.code,
    required this.title,
    required this.createdAt,
    required this.participants,
    this.owner,
  });

  factory PoolModel.fromMap(map) {
    return PoolModel(
      count: map['_count']?['participants']?.toInt() ?? 0,
      id: map['id'] ?? '',
      code: map['code'] ?? '',
      title: map['title'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      participants: map['participants'] != null
          ? List<UserModel>.from(
              map['participants']?.map((x) => UserModel.fromMap(x['user'])))
          : [],
      owner: map['owner'] != null ? UserModel.fromMap(map['owner']) : null,
    );
  }
}
