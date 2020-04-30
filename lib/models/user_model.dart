// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  List<Datum> data;
  final int page;
  final int row;
  final int totalRow;

  UserModel({
    this.data,
    this.page,
    this.row,
    this.totalRow,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        page: json["page"] == null ? null : json["page"],
        row: json["row"] == null ? null : json["row"],
        totalRow: json["total_row"] == null ? null : json["total_row"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data.map((x) => x.toMap())),
        "page": page == null ? null : page,
        "row": row == null ? null : row,
        "total_row": totalRow == null ? null : totalRow,
      };
}

class Datum {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String phoneNo;
  bool isFavourite = false;

  Datum({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.phoneNo,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        dateOfBirth:
            json["date_of_birth"] == null ? null : json["date_of_birth"],
        phoneNo: json["phone_no"] == null ? null : json["phone_no"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
        "phone_no": phoneNo == null ? null : phoneNo,
      };
}

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
