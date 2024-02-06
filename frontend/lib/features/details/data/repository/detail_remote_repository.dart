import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/detail_entity.dart';
import '../../domain/repository/detail_repository.dart';
import '../data_source/detail_remote_data_source.dart';

final detailRemoteRepositoryProvider = Provider<IDetailRepository>(
  (ref) => DetailRemoteRepositoryImpl(
    ref.watch(
      detailRemoteDataSourceProvider,
    ),
  ),
);

class DetailRemoteRepositoryImpl implements IDetailRepository {
  final DetailRemoteDataSource _detailRemoteDataSource;
  DetailRemoteRepositoryImpl(this._detailRemoteDataSource);

  // DetailRemoteRepositoryImpl({required this.detailRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addDetails(DetailEntity details) {
    return _detailRemoteDataSource.addDetails(details);
  }

  @override
  Future<Either<Failure, String>> uploadCoverPhoto(File file) {
    return _detailRemoteDataSource.uploadCoverPhoto(file);
  }

  @override
  Future<Either<Failure, List<DetailEntity>>> getAllDetails() {
    return _detailRemoteDataSource.getAllDetails();
  }

  @override
  Future<Either<Failure, bool>> deleteDetails(String id) {
    return _detailRemoteDataSource.deleteDetails(id);
  }
}
