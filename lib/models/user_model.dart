class UserModel {
  String id;
  String name;
  String email;
  bool isAdmin;
  String phoneNumber;
  String address;
  // String password;
  Map<String, String> socialMediaLinks;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    this.socialMediaLinks = const {},
    required this.address,
    // required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin ? 1 : 0,
      'phoneNumber': phoneNumber,
      'address': address,
      // 'password': password,
      'socialMediaLinks': socialMediaLinks,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      isAdmin: map['isAdmin'] == 1,
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      // password: map['password'],
      socialMediaLinks: Map<String, String>.from(map['socialMediaLinks']),
    );
  }
}
