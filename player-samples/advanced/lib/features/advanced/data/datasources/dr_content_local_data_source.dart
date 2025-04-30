import 'dart:convert';

import 'package:advanced/core/error/exceptions.dart';
import 'package:advanced/features/advanced/data/models/drm_content_model.dart';
import 'package:advanced/features/advanced/data/models/drm_movie_model.dart';
import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DrContentLocalDataSource {
  Future<void> cacheDrmContentModel(DrmContentModel content);

  Future<DrmContentModel> getDrmContentModel();
}

const CACHED_DRM_MOVIES = 'CACHED_DRM_MOVIES';

class DrContentLocalDataSourceImpl
    implements DrContentLocalDataSource {
  // late final SharedPreferences sharedPreferences;
  //
  // DrContentLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<DrmContentModel> getDrmContentModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(CACHED_DRM_MOVIES);
    if (jsonString != null) {
      return Future.value(DrmContentModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(DrmContentModel(totalResults: 0, contents: []));
    }
  }

  @override
  Future<void> cacheDrmContentModel(DrmContentModel content) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        CACHED_DRM_MOVIES, jsonEncode(content.toJson()));
  }
}
