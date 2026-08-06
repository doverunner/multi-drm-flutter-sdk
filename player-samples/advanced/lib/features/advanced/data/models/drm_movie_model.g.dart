// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drm_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrmMovieModel _$DrmMovieModelFromJson(Map<String, dynamic> json) =>
    DrmMovieModel(
      url: json['url'] as String,
      contentType: json['content_type'] as String,
      streamFormat: json['stream_format'] as String,
      mediaType: json['media_type'] as String,
      title: json['title'] as String,
      contentId: json['content_id'] as String,
      videoCodec: json['video_codec'] as String,
      videoProfile: json['video_profile'] as String,
      maximumResolution: json['maximum_resolution'] as String,
      frameRate: json['frame_rate'] as String,
      containerFormat: json['container_format'] as String,
      audioCodec: json['audio_codec'] as String,
      audioLanguage: json['audio_language'] as String,
      licenseServerUrl: json['licenseServerUrl'] as String?,
      licenseCipherPath: json['licenseCipherPath'] as String?,
      licenseCertUrl: json['licenseCertUrl'] as String?,
      token: json['token'] as String?,
      contentHttpHeaders:
          (json['contentHttpHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      contentCookie: json['contentCookie'] as String?,
      licenseHttpHeaders:
          (json['licenseHttpHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      licenseCookie: json['licenseCookie'] as String?,
      downloadStatus:
          $enumDecodeNullable(_$DownloadStatusEnumMap, json['downloadStatus']),
    );

Map<String, dynamic> _$DrmMovieModelToJson(DrmMovieModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'content_type': instance.contentType,
      'stream_format': instance.streamFormat,
      'media_type': instance.mediaType,
      'title': instance.title,
      'content_id': instance.contentId,
      'video_codec': instance.videoCodec,
      'video_profile': instance.videoProfile,
      'maximum_resolution': instance.maximumResolution,
      'frame_rate': instance.frameRate,
      'container_format': instance.containerFormat,
      'audio_codec': instance.audioCodec,
      'audio_language': instance.audioLanguage,
      'licenseServerUrl': instance.licenseServerUrl,
      'licenseCipherPath': instance.licenseCipherPath,
      'licenseCertUrl': instance.licenseCertUrl,
      'token': instance.token,
      'contentHttpHeaders': instance.contentHttpHeaders,
      'contentCookie': instance.contentCookie,
      'licenseHttpHeaders': instance.licenseHttpHeaders,
      'licenseCookie': instance.licenseCookie,
      'downloadStatus': _$DownloadStatusEnumMap[instance.downloadStatus],
    };

const _$DownloadStatusEnumMap = {
  DownloadStatus.running: 'running',
  DownloadStatus.pending: 'pending',
  DownloadStatus.pause: 'pause',
  DownloadStatus.failed: 'failed',
  DownloadStatus.success: 'success',
};
