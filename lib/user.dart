class NewUser {
  String name;
  String email;
  String password;
  bool auth;

  NewUser(
    this.name,
    this.email,
    this.password,
    this.auth,
  );

  static NewUser fromJson(Map<String, dynamic> json) =>
      NewUser(json['name'], json['email'], json['password'], json['auth']);
}
