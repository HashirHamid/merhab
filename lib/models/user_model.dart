import 'dart:convert';

class UserModel {
    String? userId;
    String? email;
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? passportNumber;
    String? nationality;
    String? gender;
    String? age;
    String? bloodType;
    String? emergencyContact;
    String? relative;

    UserModel({
        this.userId,
        this.email,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.passportNumber,
        this.nationality,
        this.gender,
        this.age,
        this.bloodType,
        this.emergencyContact,
        this.relative,
    });

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        passportNumber: json["passport_number"],
        nationality: json["nationality"],
        gender: json["gender"],
        age: json["age"],
        bloodType: json["blood_type"],
        emergencyContact: json["emergency_contact"],
        relative: json["relative"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "passport_number": passportNumber,
        "nationality": nationality,
        "gender": gender,
        "age": age,
        "blood_type": bloodType,
        "emergency_contact": emergencyContact,
        "relative": relative,
    };
}
