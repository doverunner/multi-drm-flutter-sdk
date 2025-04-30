import 'dart:convert';

import 'package:advanced/core/error/exceptions.dart';
import 'package:advanced/features/advanced/data/models/drm_content_model.dart';
import 'package:advanced/features/advanced/data/models/drm_movie_model.dart';
import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DrContentUserDataSource {
  Future<DrmContentModel> getDrmContentModel();
}

class DrContentUserDataSourceImpl
    implements DrContentUserDataSource {
  // late final SharedPreferences sharedPreferences;
  //
  DrContentUserDataSourceImpl();

  @override
  Future<DrmContentModel> getDrmContentModel() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final jsonString = sharedPreferences.getString(CACHED_DRM_MOVIES);
    final String jsonString = await rootBundle.loadString('assets/user_content.json');
    if (jsonString.isNotEmpty) {
      return Future.value(DrmContentModel.fromJson(json.decode(jsonString)));
    } else {
      throw FileReadException();
    }
  }
}
