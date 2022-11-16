import 'package:country_list/country_list.dart';
import 'package:intl/intl.dart';

class GameModel {
  final String id;
  final DateTime date;
  final String firstTeamCode;
  final String secondTeamCode;
  final GuessModel? guess;
  GameModel({
    required this.id,
    required this.date,
    required this.firstTeamCode,
    required this.secondTeamCode,
    this.guess,
  });

  factory GameModel.fromMap(map) {
    return GameModel(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      firstTeamCode: map['firstTeamCode'] ?? '',
      secondTeamCode: map['secondTeamCode'] ?? '',
      guess: map['guess'] != null ? GuessModel.fromMap(map['guess']) : null,
    );
  }
  String get dateFormatted {
    final DateFormat formatter =
        DateFormat("dd 'de' MMMM 'de' yyyy 'às' hh:mm'h'");
    final String formatted = formatter.format(date);
    return formatted;
  }

  String get firstTeamName {
    final res = Countries.list.singleWhere((e) => e.isoCode == firstTeamCode);
    return res.name;
  }

  String get secondTeamName {
    final res = Countries.list.singleWhere((e) => e.isoCode == secondTeamCode);
    return res.name;
  }
}

class GuessModel {
  final String id;
  final int? firstTeamPoints;
  final int? secondTeamPoints;
  final DateTime createdAt;
  final String gameId;
  final String participantId;

  GuessModel({
    required this.id,
    this.firstTeamPoints,
    this.secondTeamPoints,
    required this.createdAt,
    required this.gameId,
    required this.participantId,
  });

  factory GuessModel.fromMap(map) {
    return GuessModel(
      id: map['id'] ?? '',
      firstTeamPoints: map['firstTeamPoints']?.toInt(),
      secondTeamPoints: map['secondTeamPoints']?.toInt(),
      createdAt: DateTime.parse(map['createdAt']),
      gameId: map['gameId'] ?? '',
      participantId: map['participantId'] ?? '',
    );
  }
}
