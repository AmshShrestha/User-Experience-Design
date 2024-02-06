// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../core/failure/failure.dart';
// import '../../domain/entity/detail_entity.dart';
// import '../../domain/repository/detail_repository.dart';
// import '../data_source/detail_local_data_source.dart';

// final detailLocalRepositoryProvider = Provider<IDetailRepository>((ref) {
//   return DetailLocalRepository(
//     ref.read(detailLocalDataSourceProvider),
//   );
// });

// class DetailLocalRepository implements IDetailRepository {
//   final DetailLocalDataSource _detailLocalDataSource;

//   DetailLocalRepository(this._detailLocalDataSource);

//   @override
//   Future<Either<Failure, bool>> addDetails(DetailEntity details) {
//     return _detailLocalDataSource.addDetails(details);
//   }

//   @override
//   Future<Either<Failure, List<DetailEntity>>> getAllDetails() {
//     return _detailLocalDataSource.getAllDetails();
//   }

//   @override
//   Future<Either<Failure, bool>> deleteDetails(String id) {
//     // TODO: implement deleteDetails
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, String>> uploadCoverPhoto(File file) {
//     // TODO: implement uploadCoverPhoto
//     throw UnimplementedError();
//   }
// }
