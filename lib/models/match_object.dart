import 'package:equatable/equatable.dart';

class MatchObject extends Equatable {
  final int id;
  final int matchNumber;

  final int red1;
  final int red2;
  final int red3;

  final int blue1;
  final int blue2;
  final int blue3;

  MatchObject(
      {this.id,
      this.matchNumber,
      this.red1,
      this.red2,
      this.red3,
      this.blue1,
      this.blue2,
      this.blue3});

  List<Object> get props =>
      [id, matchNumber, red1, red2, red3, blue1, blue2, blue3];

  static MatchObject fromJson(dynamic match) {
    return MatchObject(
      id: match["id"],
      matchNumber: match["match_number"],
      red1: match["red1"],
      red2: match["red2"],
      red3: match["red3"],
      blue1: match["blue1"],
      blue2: match["blue2"],
      blue3: match["blue3"],
    );
  }
}
