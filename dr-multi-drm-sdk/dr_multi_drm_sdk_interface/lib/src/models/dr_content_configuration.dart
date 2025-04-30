import '../enums/drm_type.dart';

class DrContentConfiguration {
  final String contentId;
  final String contentUrl;
  final DRMType? drmType;
  final String? token;
  final String? customData;
  final String? contentCookie;
  final Map<String, String>? contentHttpHeaders;
  final String? licenseCookie;
  final Map<String, String>? licenseHttpHeaders;
  final String licenseUrl;
  final String certificateUrl;
  final String? licenseCipherTablePath;

  DrContentConfiguration(this.contentId, this.contentUrl,
      {this.drmType,
      this.token,
      this.customData,
      this.contentCookie,
      this.contentHttpHeaders,
      this.licenseCookie,
      this.licenseHttpHeaders,
      this.licenseUrl =
          "https://drm-license.doverunner.com/ri/licenseManager.do",
      this.certificateUrl = "",
      this.licenseCipherTablePath});
}
