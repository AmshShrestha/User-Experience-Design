import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/detail_entity.dart';
import '../dto/get_all_details_dto.dart';
import '../model/detail_api_model.dart';

final detailRemoteDataSourceProvider = Provider(
  (ref) => DetailRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedProvider),
    detailApiModel: ref.read(detailApiModelProvider),
  ),
);

class DetailRemoteDataSource {
  final Dio dio;
  final DetailApiModel detailApiModel;
  final UserSharedPrefs userSharedPrefs;

  DetailRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.detailApiModel,
  });

  Future<Either<Failure, bool>> addDetails(DetailEntity details) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      if (token == null) {
        return Left(
            Failure(error: 'User not authenticated', statusCode: '401'));
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        ApiEndpoints.createDetails,
        data: {
          "image": details.image,
          "title": details.title,
          "url": details.url,
          "date": details.date,
        },
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadCoverPhoto(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadCoverPhoto,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<DetailEntity>>> getAllDetails() async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      if (token == null) {
        return Left(
            Failure(error: 'User not authenticated', statusCode: '401'));
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get(ApiEndpoints.getAllDetails);

      if (response.statusCode == 200) {
        List<DetailEntity> details = [];
        GetAllDetailsDTO getAllDetailsDTO =
            GetAllDetailsDTO.fromJson(response.data);

        details = detailApiModel.toEntityList(getAllDetailsDTO.data);
        return Right(details);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteDetails(String tripId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteDetails + tripId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
