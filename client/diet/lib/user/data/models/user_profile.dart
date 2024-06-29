class UserProfile {
  final String name;
  final int age;
  final double weight;
  final double height;
  final String gender;

  UserProfile({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      age: json['age'],
      weight: json['weight'].toDouble(),
      height: json['height'].toDouble(),
      gender: json['gender'],
    );
  }
}
