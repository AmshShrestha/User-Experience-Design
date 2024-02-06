// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllDetailsDTO _$GetAllDetailsDTOFromJson(Map<String, dynamic> json) =>
    GetAllDetailsDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => DetailApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllDetailsDTOToJson(GetAllDetailsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
