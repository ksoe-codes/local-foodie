class User {
  //final int id;
  final String fName;
  final String email;
  final String password;

  const User(
      { //required this.id,
      required this.fName,
      required this.email,
      required this.password});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      //'id': id,
      'name': fName,
      'email': email,
      'password': password
    };

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        //id: map['id'],
        fName: map['fName'],
        email: map['email'],
        password: map['password']);
  }
}
