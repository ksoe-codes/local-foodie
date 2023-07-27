class User {
  //final int id;
  final String fName;
  final String lName;
  final String email;
  final String password;

  const User(
      { //required this.id,
      required this.fName,
      required this.lName,
      required this.email,
      required this.password});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      //'id': id,
      'fname': fName,
      'lname': lName,
      'email': email,
      'password': password
    };

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        //id: map['id'],
        fName: map['fName'],
        lName: map['lName'],
        email: map['email'],
        password: map['password']);
  }
}
