// To parse this JSON data, do
//
//     final randomFace = randomFaceFromMap(jsonString);

import 'dart:convert';

class RandomFace {
  RandomFace({
    required this.age,
    required this.dateAdded,
    required this.filename,
    required this.gender,
    required this.imageUrl,
    required this.lastServed,
    required this.source,
  });

  final int age;
  final String dateAdded;
  final String filename;
  final String gender;
  final String imageUrl;
  final String lastServed;
  final String source;

  factory RandomFace.fromJson(String str) => RandomFace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RandomFace.fromMap(Map<String, dynamic> json) => RandomFace(
        age: json["age"],
        dateAdded: json["date_added"],
        filename: json["filename"],
        gender: json["gender"],
        imageUrl: json["image_url"],
        lastServed: json["last_served"],
        source: json["source"],
      );

  Map<String, dynamic> toMap() => {
        "age": age,
        "date_added": dateAdded,
        "filename": filename,
        "gender": gender,
        "image_url": imageUrl,
        "last_served": lastServed,
        "source": source,
      };
}
