// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfile {
  final String id;
  final int age;
  final double bmi;
  final String gender;
  final double height;
  final String userName;
  final double weight;

  UserProfile({
    required this.id,
    required this.age,
    required this.bmi,
    required this.gender,
    required this.height,
    required this.userName,
    required this.weight,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      age: json['age'],
      bmi: json['bmi'].toDouble(),
      gender: json['gender'],
      height: json['height'].toDouble(),
      userName: json['user_name'],
      weight: json['weight'].toDouble(),
    );
  }

  UserProfile copyWith({
    String? id,
    int? age,
    double? bmi,
    String? gender,
    double? height,
    String? userName,
    double? weight,
  }) {
    return UserProfile(
      id: id ?? this.id,
      age: age ?? this.age,
      bmi: bmi ?? this.bmi,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      userName: userName ?? this.userName,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'age': age,
      'bmi': bmi,
      'gender': gender,
      'height': height,
      'userName': userName,
      'weight': weight,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      age: map['age'] as int,
      bmi: map['bmi'] as double,
      gender: map['gender'] as String,
      height: map['height'] as double,
      userName: map['userName'] as String,
      weight: map['weight'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(id: $id, age: $age, bmi: $bmi, gender: $gender, height: $height, userName: $userName, weight: $weight)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.age == age &&
      other.bmi == bmi &&
      other.gender == gender &&
      other.height == height &&
      other.userName == userName &&
      other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      age.hashCode ^
      bmi.hashCode ^
      gender.hashCode ^
      height.hashCode ^
      userName.hashCode ^
      weight.hashCode;
  }
}
