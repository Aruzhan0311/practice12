class User {
  final String name;
  final String email;
  final String age; 

  User({required this.name, required this.email, required this.age});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
    };
  }
}