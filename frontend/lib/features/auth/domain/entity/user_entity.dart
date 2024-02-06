class UserEntity {
  final String? id;
  final String? image;
  final String phone;
  final String email;
  final String username;
  final String password;

  UserEntity({
    this.id,
    this.image,
    required this.phone,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'],
        image: json['image'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "email": email,
        'username': username,
        'password': password,
        'phone': phone,
      };

  @override
  String toString() {
    return '$image, $phone $email $username $password ';
  }
}
