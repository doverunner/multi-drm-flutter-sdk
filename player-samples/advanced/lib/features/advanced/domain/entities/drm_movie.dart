import 'package:equatable/equatable.dart';
import 'download_status.dart';

class DrmMovie extends Equatable {
  final String url;
  final String contentType;
  final String streamFormat;
  final String mediaType;
  final String title;
  final String contentId;
  final String videoCodec;
  final String videoProfile;
  final String maximumResolution;
  final String frameRate;
  final String containerFormat;
  final String audioCodec;
  final String audioLanguage;
  final String? licenseServerUrl;
  final String? licenseCipherPath;
  final String? licenseCertUrl;
  final String? token;
  final DownloadStatus? downloadStatus;

  const DrmMovie(
      {required this.url,
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
      this.token,
      this.licenseServerUrl,
      this.licenseCipherPath,
      this.licenseCertUrl,
      this.downloadStatus});

  @override
  List<Object> get props => [
        url,
        contentType,
        streamFormat,
        mediaType,
        title,
        contentId,
        videoCodec,
        videoProfile,
        maximumResolution,
        frameRate,
        containerFormat,
        audioCodec,
        audioLanguage,
        licenseServerUrl ??
            "https://drm-license.doverunner.com/ri/licenseManager.do/",
        licenseCipherPath ?? "",
        licenseCertUrl ?? "",
        token ?? "",
        downloadStatus ?? DownloadStatus.pending
      ];

  DrmMovie copyWith({
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
    DownloadStatus? downloadStatus,
  }) {
    return DrmMovie(
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
      downloadStatus: downloadStatus ?? this.downloadStatus,
    );
  }
}
