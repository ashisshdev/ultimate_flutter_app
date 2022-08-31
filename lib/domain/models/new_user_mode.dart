// To parse this JSON data, do
//
//     final userFull = userFullFromJson(jsonString);

// {
// "title" : "hehe",
// "firstName": "string(length: 2-50)",
// "lastName": "string(length: 2-50)",
// "gender": "male female other",
// "email": "string(email)",
// "dateOfBirth": "date to epoch",
// "phone": "string(phone number - any format)",
// "picture": "string(url)",
// "location": {
// "street": "string(length: 5-100)",
// "city": "string(length: 2-30)",
// "state": "string(length: 2-30)",
// "country": "string(length: 2-30)",
// "timezone": "string"
// }
// }

// To parse this JSON data, do
//
//     final userFullToServer = userFullToServerFromJson(jsonString);

import 'dart:convert';

class NewUserModel {
  NewUserModel({
    this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    this.dateOfBirth,
    required this.phone,
    required this.picture,
    this.location,
  });

  String? title;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  String? dateOfBirth;
  final String phone;
  final String picture;
  Location? location;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "phone": phone,
        "picture": picture,
        "location": location == null ? {} : location!.toJson(),
      };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  final String street;
  final String city;
  final String state;
  final String country;
  final String timezone;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "timezone": timezone,
      };
}
