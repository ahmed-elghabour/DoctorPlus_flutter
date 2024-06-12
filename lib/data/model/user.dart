abstract class SystemUser {
  String? id;
  late String fName, lName, email, password;

  SystemUser();

  SystemUser.login({required this.email, required this.password});

  SystemUser.register(
      {required this.fName,
      required this.lName,
      required this.email,
      required this.password});

  SystemUser.gen(
      {this.id,
      required this.fName,
      required this.lName,
      required this.email,
      required this.password});
}
