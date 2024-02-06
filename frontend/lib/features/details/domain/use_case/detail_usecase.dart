import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/detail_repository.dart';

final detailUseCaseProvider = Provider(
  (ref) {
    return DetailUseCase(
      ref.watch(detailRepositoryProvider),
    );
  },
);

class DetailUseCase {
  final IDetailRepository _detailRepository;

  DetailUseCase(this._detailRepository);

  Future<Either<Failure, List<DetailEntity>>> getAllDetails() async {
    return _detailRepository.getAllDetails();
  }

  Future<Either<Failure, bool>> addDetails(DetailEntity details) async {
    return _detailRepository.addDetails(details);
  }

  Future<Either<Failure, String>> uploadCoverPhoto(File file) async {
    return await _detailRepository.uploadCoverPhoto(file);
  }

  Future<Either<Failure, bool>> deleteDetails(String id) async {
    return await _detailRepository.deleteDetails(id);
  }
}
