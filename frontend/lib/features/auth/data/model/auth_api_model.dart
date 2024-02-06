import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    phone: '',
    email: '',
    username: '',
    password: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? studentId;
  final String? image;
  final String phone;
  final String email;
  final String username;
  final String? password;

  AuthApiModel({
    this.studentId,
    this.image,
    required this.email,
    required this.phone,
    required this.username,
    this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to UserEntity
  UserEntity toEntity() => UserEntity(
        id: studentId,
        image: image,
        email: email,
        phone: phone,
        username: username,
        password: password ?? '',
      );

  AuthApiModel fromEntity(UserEntity entity) => AuthApiModel(
      studentId: entity.id ?? '',
      image: entity.image ?? '',
      email: entity.email,
      phone: entity.phone,
      username: entity.username,
      password: entity.password);

  List<UserEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  // Convert AuthApiModel list to UserEntity list
  List<UserEntity> listFromJson(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel(id: $studentId,image: $image, phone: $phone, email:$email, username: $username, password: $password)';
  }
}
