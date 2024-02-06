import 'package:json_annotation/json_annotation.dart';
import 'package:travel_log/features/auth/data/model/auth_api_model.dart';

part 'get_user_profile_dto.g.dart';

@JsonSerializable()
class GetUserProfileDTO {
  final bool success;
  final int count;
  final List<AuthApiModel> data;

  GetUserProfileDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetUserProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserProfileDTOToJson(this);
}
