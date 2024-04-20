class UserModel {
  final String name;
  final String image;
  final String dob;
  final String email;
  final String password;

  UserModel(
      {required this.name,
      required this.image,
      required this.dob,
      required this.email,
      required this.password});
  toMap() {
    return {
      'name': name,
      'image': image,
      'dob': dob,
      'email': email,
      'password': password
    };
  }

 static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        image: map['image'],
        dob: map['dob'],
        email: map['email'],
        password: map['password']);
  }
}
