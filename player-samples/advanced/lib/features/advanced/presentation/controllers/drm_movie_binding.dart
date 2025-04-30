import 'package:advanced/features/advanced/data/datasources/dr_content_local_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/dr_content_remote_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/dr_content_user_data_source.dart';
import 'package:advanced/features/advanced/data/repositories/movie_repository_impl.dart';
import 'package:advanced/features/advanced/domain/usecases/get_drm_content_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'drm_movie_controller.dart';

class DrmMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(BaseOptions(
        baseUrl: 'https://testtokyo.pallycon.com/demo-app/api')));
    Get.lazyPut(() => DrContentRemoteDataSourceImpl(
        dio: Get.find()));
    Get.lazyPut(() => DrContentLocalDataSourceImpl());
    Get.lazyPut(() => DrContentUserDataSourceImpl());
    Get.lazyPut(() => MovieRepositoryImpl(
        remoteDataSource: Get.find<DrContentRemoteDataSourceImpl>(),
        localDataSource: Get.find<DrContentLocalDataSourceImpl>(),
        userDataSource: Get.find<DrContentUserDataSourceImpl>()
    ));
    Get.lazyPut(() => GetDrmContentUseCase(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => DrmMovieController(Get.find()));
  }
}
