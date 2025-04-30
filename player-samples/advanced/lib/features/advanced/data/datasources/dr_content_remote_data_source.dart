import 'dart:convert';

import 'package:advanced/core/error/exceptions.dart';
import 'package:advanced/features/advanced/data/models/drm_content_model.dart';
import 'package:advanced/features/advanced/data/models/drm_token_model.dart';
import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract class DrContentRemoteDataSource {
  Future<DrmContentModel> getDrmContentModel();

  Future<DrmTokenModel> getToken(String drmType, String contentId);
}

class DrContentRemoteDataSourceImpl implements DrContentRemoteDataSource {
  late final Dio dio;

  DrContentRemoteDataSourceImpl({required this.dio});

  @override
  Future<DrmContentModel> getDrmContentModel() async {
    final response = await dio.get('/contentList');
    if (response.statusCode == 200) {
      return DrmContentModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DrmTokenModel> getToken(String drmType, String contentId) async {
    final response = await dio.post('/licenseManager',
        data: {'drm_type': drmType, 'content_id': contentId});
    if (response.statusCode == 200) {
      return DrmTokenModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
