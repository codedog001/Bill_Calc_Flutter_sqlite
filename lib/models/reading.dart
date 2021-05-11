import 'dart:convert';

Reading readingFromJson(String str) => Reading.fromJson(json.decode(str));
String readingToJson(Reading reading) => json.encode(reading.toJson());

class Reading {
  String id;
  String initial_reading;
  String final_reading;
  String billAmount;

  Reading({this.final_reading, this.id, this.initial_reading, this.billAmount});

  factory Reading.fromJson(Map<String, dynamic> readingJson) => Reading(
        final_reading: readingJson["final_reading"],
        id: readingJson['id'],
        initial_reading: readingJson['initial_reading'],
        billAmount: readingJson['rate'],
      );

  Map<String, dynamic> toJson() => {
        "initial_reading": initial_reading,
        "id": id,
        "final_reading": final_reading,
        "billAmount": billAmount,
      };
}
