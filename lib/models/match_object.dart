import 'package:equatable/equatable.dart';

class MatchObject extends Equatable {
  final int id;
  final int matchNumber;

  final int red1;
  final int red2;
  final int red3;

  final String redName1;
  final String redName2;
  final String redName3;

  final int blue1;
  final int blue2;
  final int blue3;

  final String blueName1;
  final String blueName2;
  final String blueName3;

  MatchObject({
    this.id,
    this.matchNumber,
    this.red1,
    this.red2,
    this.red3,
    this.redName1,
    this.redName2,
    this.redName3,
    this.blue1,
    this.blue2,
    this.blue3,
    this.blueName1,
    this.blueName2,
    this.blueName3,
  });

  List<Object> get props => [
        id,
        matchNumber,
        red1,
        red2,
        red3,
        redName1,
        redName2,
        redName3,
        blue1,
        blue2,
        blue3,
        blueName1,
        blueName2,
        blueName3,
      ];

  static MatchObject fromJson(dynamic match) {
    return MatchObject(
      id: match["id"],
      matchNumber: match["match_number"],
      red1: match["red1"],
      red2: match["red2"],
      red3: match["red3"],
      redName1: match["red_name_1"],
      redName2: match["red_name_2"],
      redName3: match["red_name_3"],
      blue1: match["blue1"],
      blue2: match["blue2"],
      blue3: match["blue3"],
      blueName1: match["blue_name_1"],
      blueName2: match["blue_name_2"],
      blueName3: match["blue_name_3"],
    );
  }
}
