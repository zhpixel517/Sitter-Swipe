/// Representation of a child. Only used in resgistration.
class Child {
  final String? name;
  final String? age;
  final String? hobbies;

  bool get isComplete => name != "" && age != "" && hobbies != "";

  const Child({required this.name, required this.age, required this.hobbies});
}
