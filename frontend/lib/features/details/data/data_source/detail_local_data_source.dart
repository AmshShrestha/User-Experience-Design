import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/detail_entity.dart';
import '../model/detail_hive_model.dart';

final detailLocalDataSourceProvider = Provider(
  (ref) => DetailLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(detailHiveModelProvider),
  ),
);

class DetailLocalDataSource {
  final HiveService _hiveService;
  final DetailHiveModel _detailHiveModel;

  DetailLocalDataSource(this._hiveService, this._detailHiveModel);

  Future<Either<Failure, bool>> addDetails(DetailEntity details) async {
    try {
      await _hiveService.addDetails(_detailHiveModel.toHiveModel(details));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<DetailEntity>>> getAllDetails() async {
    try {
      // Get all batches from Hive
      final details = await _hiveService.getAllDetails();
      // Convert Hive Object to Entity
      final batchEntities = _detailHiveModel.toEntityList(details);
      return Right(batchEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
