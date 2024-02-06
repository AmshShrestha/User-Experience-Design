// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfileDTO _$GetUserProfileDTOFromJson(Map<String, dynamic> json) =>
    GetUserProfileDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserProfileDTOToJson(GetUserProfileDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
