import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';

part 'detail_api_model.g.dart';

final detailApiModelProvider = Provider<DetailApiModel>(
  (ref) => DetailApiModel(
    tripId: '',
    title: '',
    url: '',
    date: '',
  ),
);

@JsonSerializable()
class DetailApiModel {
  @JsonKey(name: '_id')
  final String? tripId;
  final String? image;
  final String? title;
  final String? url;
  final String? date;

  DetailApiModel({
    this.image,
    this.tripId,
    this.title,
    this.url,
    this.date,
  });

  Map<String, dynamic> toJson() => _$DetailApiModelToJson(this);

  factory DetailApiModel.fromJson(Map<String, dynamic> json) =>
      _$DetailApiModelFromJson(json);

  DetailEntity toEntity() => DetailEntity(
        image: image,
        tripId: tripId,
        title: title ?? '',
        url: url,
        date: date ?? '',
      );

  DetailApiModel fromEntity(DetailEntity entity) => DetailApiModel(
        image: entity.image,
        tripId: entity.tripId ?? '',
        title: entity.title,
        url: entity.url ?? '',
        date: entity.date,
      );

  List<DetailEntity> toEntityList(List<DetailApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  List<DetailEntity> listFromJson(List<DetailApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
