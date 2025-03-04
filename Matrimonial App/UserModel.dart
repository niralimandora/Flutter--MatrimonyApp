class User {
  String fullName;
  String email;
  String phone;
  String dateOfBirth;
  String city;
  int gender;
  List<String> hobbies;
  String password;

  User({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.city,
    required this.gender,
    required this.hobbies,
    required this.password,
  });
}
