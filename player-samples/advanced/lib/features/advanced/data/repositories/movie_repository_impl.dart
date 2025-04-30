import 'package:advanced/core/error/exceptions.dart';
import 'package:advanced/core/error/failures.dart';
import 'package:advanced/core/network/network_info.dart';
import 'package:advanced/features/advanced/data/datasources/dr_content_local_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/dr_content_remote_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/dr_content_user_data_source.dart';
import 'package:advanced/features/advanced/data/models/drm_content_model.dart';
import 'package:advanced/features/advanced/domain/repositories/movie_repository.dart';
import 'dart:io' show Platform;
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DrContentRemoteDataSource remoteDataSource;
  final DrContentLocalDataSource localDataSource;
  final DrContentUserDataSource userDataSource;

  MovieRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.userDataSource});

  @override
  Future<Either<Failure, DrmContentModel>> getDrmContent() async {
    String drmType = "";
    if (Platform.isAndroid) {
      drmType = "widevine";
    } else if (Platform.isIOS) {
      drmType = "fairplay";
    } else {
      return Left(PlatformFailure());
    }

    try {
      final drmContentModel = await userDataSource.getDrmContentModel();
      if (await NetworkInfo.isConnected) {
        final remoteContentModel = await remoteDataSource.getDrmContentModel();
        for (var i = 0; i < remoteContentModel.totalResults; i++) {
          final token = await remoteDataSource.getToken(
              drmType, remoteContentModel.contents[i].contentId);
          remoteContentModel.contents[i] =
              remoteContentModel.contents[i].copyWith(token: token.token);
        }
        localDataSource.cacheDrmContentModel(remoteContentModel);
        drmContentModel.totalResults += remoteContentModel.totalResults;
        drmContentModel.contents.addAll(remoteContentModel.contents);
      } else {
        final cacheContentModel = await localDataSource.getDrmContentModel();
        if (cacheContentModel.contents.isNotEmpty) {
          drmContentModel.totalResults += cacheContentModel.totalResults;
          drmContentModel.contents.addAll(cacheContentModel.contents);
        }
      }
      return Right(drmContentModel);
    } on ServerException {
      return Left(ServerFailure());
    } on FileReadException {
      return Left(AssetFailure());
    }
  }
}
