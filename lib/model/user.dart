class User {
  final String username;
  final String password;
  final String key;
  final String value;

  User({
    this.username,
    this.password,
    this.key,
    this.value,
  });

  factory User.fromJson(Map<String, dynamic> userSettings) {
    return User(
      key: userSettings['name'],
      value: userSettings['value'],
    );
  }
}
