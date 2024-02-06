import 'package:json_annotation/json_annotation.dart';
import 'package:travel_log/features/details/data/model/detail_api_model.dart';

part 'get_all_details_dto.g.dart';

@JsonSerializable()
class GetAllDetailsDTO {
  final bool success;
  final int count;
  final List<DetailApiModel> data;

  GetAllDetailsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllDetailsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllDetailsDTOToJson(this);
}
