import 'dart:convert';

Reading readingFromJson(String str) => Reading.fromJson(json.decode(str));
String readingToJson(Reading reading) => json.encode(reading.toJson());

class Reading {
  String id;
  String date;
  String initial_reading;
  String final_reading;
  String billAmount;

  Reading(
      {this.final_reading,
      this.date,
      this.initial_reading,
      this.billAmount,
      this.id});

  factory Reading.fromJson(Map<String, dynamic> readingJson) => Reading(
        id: readingJson["id"],
        final_reading: readingJson["final_reading"],
        date: readingJson['date'],
        initial_reading: readingJson['initial_reading'],
        billAmount: readingJson['billAmount'],
      );

  Map<String, dynamic> toJson() => {
        "initial_reading": initial_reading,
        "date": date,
        "final_reading": final_reading,
        "billAmount": billAmount,
        "id": id,
      };
}
