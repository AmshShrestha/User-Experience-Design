// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailApiModel _$DetailApiModelFromJson(Map<String, dynamic> json) =>
    DetailApiModel(
      image: json['image'] as String?,
      tripId: json['_id'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$DetailApiModelToJson(DetailApiModel instance) =>
    <String, dynamic>{
      '_id': instance.tripId,
      'image': instance.image,
      'title': instance.title,
      'url': instance.url,
      'date': instance.date,
    };
