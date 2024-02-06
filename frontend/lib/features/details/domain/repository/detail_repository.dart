import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/features/details/data/repository/detail_remote_repository.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';

import '../../../../core/failure/failure.dart';

final detailRepositoryProvider = Provider<IDetailRepository>((ref) {
  return ref.watch(detailRemoteRepositoryProvider);
});

abstract class IDetailRepository {
  Future<Either<Failure, List<DetailEntity>>> getAllDetails();
  Future<Either<Failure, String>> uploadCoverPhoto(File file);
  Future<Either<Failure, bool>> addDetails(DetailEntity details);
  Future<Either<Failure, bool>> deleteDetails(String id);
}
