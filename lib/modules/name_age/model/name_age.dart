// ignore: constant_identifier_names
const NAME_MIN_LENGTH = 1;
// ignore: constant_identifier_names
const NAME_MAX_LENGTH = 30;

class NameAge {
  final int age;
  final String name;

  const NameAge({
    required this.age,
    required this.name,
  });

  factory NameAge.fromJson(Map<String, dynamic> json) {
    return NameAge(
      age: json['age'],
      name: json['name'],
    );
  }
}
