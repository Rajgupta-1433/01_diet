// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserNewModel {
  final String userName;
  final int age;
  final double weight;
  final double height;
  final double bmi;
  final String gender;

  UserNewModel({
    required this.userName,
    required this.age,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.gender,
  });


  UserNewModel copyWith({
    String? userName,
    int? age,
    double? weight,
    double? height,
    double? bmi,
    String? gender,
  }) {
    return UserNewModel(
      userName: userName ?? this.userName,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'age': age,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'gender': gender,
    };
  }

  factory UserNewModel.fromMap(Map<String, dynamic> map) {
    return UserNewModel(
      userName: map['userName'] as String,
      age: map['age'] as int,
      weight: map['weight'] as double,
      height: map['height'] as double,
      bmi: map['bmi'] as double,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNewModel.fromJson(String source) => UserNewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserNewModel(userName: $userName, age: $age, weight: $weight, height: $height, bmi: $bmi, gender: $gender)';
  }

  @override
  bool operator ==(covariant UserNewModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName &&
      other.age == age &&
      other.weight == weight &&
      other.height == height &&
      other.bmi == bmi &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
      age.hashCode ^
      weight.hashCode ^
      height.hashCode ^
      bmi.hashCode ^
      gender.hashCode;
  }
}
