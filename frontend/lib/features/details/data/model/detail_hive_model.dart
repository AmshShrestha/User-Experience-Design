import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_log/config/constants/hive_table_constant.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';
import 'package:uuid/uuid.dart';

part 'detail_hive_model.g.dart';

final detailHiveModelProvider = Provider(
  (ref) => DetailHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.detailTableId)
class DetailHiveModel {
  @HiveField(0)
  final String? tripId;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? url;

  @HiveField(3)
  final String? date;

  DetailHiveModel({
    String? tripId,
    this.title,
    this.url,
    this.date,
  }) : tripId = tripId ?? const Uuid().v4();

  DetailHiveModel.empty()
      : this(
          tripId: '',
          title: '',
          url: '',
          date: '',
        );

  DetailEntity toEntity() => DetailEntity(
        tripId: tripId,
        title: title,
        url: url,
        date: date,
      );

  DetailHiveModel toHiveModel(DetailEntity entity) => DetailHiveModel(
        // username: username,
        title: entity.title!,

        url: entity.url ?? '',
        date: entity.date!,
      );

  // List<DetailHiveModel> toHiveModelList(List<DetailEntity> details) =>
  //     details.map((entity) => toHiveModel(entity)).toList();

  List<DetailEntity> toEntityList(List<DetailHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return ' tripName: $title, description:$url, date:$date,';
  }
}
