import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final int id;
  final String blueAllianceId;

  Event({this.name, this.id, this.blueAllianceId});

  List<Object> get props => [
        name,
        id,
        blueAllianceId,
      ];

  static Event fromJson(event) {
    return Event (
      name: event["name"],
      id: event["id"],
      blueAllianceId: event["blue_alliance_id"],
    );
  }
}
