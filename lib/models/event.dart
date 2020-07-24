import 'package:equatable/equatable.dart';

class Event extends Equatable {
  String name;
  int id;
  String blueAllianceId;

  List<Object> get props => [
        name,
        id,
        blueAllianceId,
      ];

  Event.fromJson(event) {
    name = event["name"];
    id = event["id"];
    blueAllianceId = event["blue_alliance_id"];
  }
}
