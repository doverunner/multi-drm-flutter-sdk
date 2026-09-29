import 'package:advanced/features/advanced/domain/entities/download_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';

part 'drm_movie_model.g.dart';

@JsonSerializable()
class DrmMovieModel extends DrmMovie {
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'content_type')
  final String contentType;
  @JsonKey(name: 'stream_format')
  final String streamFormat;
  @JsonKey(name: 'media_type')
  final String mediaType;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content_id')
  final String contentId;
  @JsonKey(name: 'video_codec')
  final String videoCodec;
  @JsonKey(name: 'video_profile')
  final String videoProfile;
  @JsonKey(name: 'maximum_resolution')
  final String maximumResolution;
  @JsonKey(name: 'frame_rate')
  final String frameRate;
  @JsonKey(name: 'container_format')
  final String containerFormat;
  @JsonKey(name: 'audio_codec')
  final String audioCodec;
  @JsonKey(name: 'audio_language')
  final String audioLanguage;
  final String? licenseServerUrl;
  final String? licenseCipherPath;
  final String? licenseCertUrl;
  final String? token;
  final Map<String, String>? contentHttpHeaders;
  final String? contentCookie;
  final Map<String, String>? licenseHttpHeaders;
  final String? licenseCookie;
  final DownloadStatus? downloadStatus;

  const DrmMovieModel({
    required this.url,
    required this.contentType,
    required this.streamFormat,
    required this.mediaType,
    required this.title,
    required this.contentId,
    required this.videoCodec,
    required this.videoProfile,
    required this.maximumResolution,
    required this.frameRate,
    required this.containerFormat,
    required this.audioCodec,
    required this.audioLanguage,
    this.licenseServerUrl,
    this.licenseCipherPath,
    this.licenseCertUrl,
    this.token,
    this.contentHttpHeaders,
    this.contentCookie,
    this.licenseHttpHeaders,
    this.licenseCookie,
    this.downloadStatus,
  }) : super(
          url: url,
          contentType: contentType,
          streamFormat: streamFormat,
          mediaType: mediaType,
          title: title,
          contentId: contentId,
          videoCodec: videoCodec,
          videoProfile: videoProfile,
          maximumResolution: maximumResolution,
          frameRate: frameRate,
          containerFormat: containerFormat,
          audioCodec: audioCodec,
          audioLanguage: audioLanguage,
          licenseServerUrl: licenseServerUrl,
          licenseCipherPath: licenseCipherPath,
          licenseCertUrl: licenseCertUrl,
          token: token,
          contentHttpHeaders: contentHttpHeaders,
          contentCookie: contentCookie,
          licenseHttpHeaders: licenseHttpHeaders,
          licenseCookie: licenseCookie,
          downloadStatus: downloadStatus,
        );

  factory DrmMovieModel.fromJson(Map<String, dynamic> json) =>
      _$DrmMovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrmMovieModelToJson(this);

  @override
  DrmMovieModel copyWith({
    String? url,
    String? contentType,
    String? streamFormat,
    String? mediaType,
    String? title,
    String? contentId,
    String? videoCodec,
    String? videoProfile,
    String? maximumResolution,
    String? frameRate,
    String? containerFormat,
    String? audioCodec,
    String? audioLanguage,
    String? licenseServerUrl,
    String? licenseCipherPath,
    String? licenseCertUrl,
    String? token,
    Map<String, String>? contentHttpHeaders,
    String? contentCookie,
    Map<String, String>? licenseHttpHeaders,
    String? licenseCookie,
    DownloadStatus? downloadStatus,
  }) {
    return DrmMovieModel(
      url: url ?? this.url,
      contentType: contentType ?? this.contentType,
      streamFormat: streamFormat ?? this.streamFormat,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      contentId: contentId ?? this.contentId,
      videoCodec: videoCodec ?? this.videoCodec,
      videoProfile: videoProfile ?? this.videoProfile,
      maximumResolution: maximumResolution ?? this.maximumResolution,
      frameRate: frameRate ?? this.frameRate,
      containerFormat: containerFormat ?? this.containerFormat,
      audioCodec: audioCodec ?? this.audioCodec,
      audioLanguage: audioLanguage ?? this.audioLanguage,
      licenseServerUrl: licenseServerUrl ?? this.licenseServerUrl,
      licenseCipherPath: licenseCipherPath ?? this.licenseCipherPath,
      licenseCertUrl: licenseCertUrl ?? this.licenseCertUrl,
      token: token ?? this.token,
      contentHttpHeaders: contentHttpHeaders ?? this.contentHttpHeaders,
      contentCookie: contentCookie ?? this.contentCookie,
      licenseHttpHeaders: licenseHttpHeaders ?? this.licenseHttpHeaders,
      licenseCookie: licenseCookie ?? this.licenseCookie,
      downloadStatus: downloadStatus ?? this.downloadStatus,
    );
  }
}
