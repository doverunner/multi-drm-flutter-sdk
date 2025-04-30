class DrDownload {
  const DrDownload(
      {required this.url,
      required this.percent,
      required this.downloadedBytes});

  final String url;
  final double percent;
  final int downloadedBytes;

  static DrDownload fromMap(dynamic message) {
    final Map<dynamic, dynamic> drDownloadMap = message;

    if (!drDownloadMap.containsKey('url')) {
      throw ArgumentError.value(drDownloadMap, 'url',
          'The supplied map doesn\'t contain the mandatory key `url`.');
    }

    if (!drDownloadMap.containsKey('percent')) {
      throw ArgumentError.value(drDownloadMap, 'percent',
          'The supplied map doesn\'t contain the mandatory key `percent`.');
    }

    if (!drDownloadMap.containsKey('downloadedBytes')) {
      throw ArgumentError.value(drDownloadMap, 'downloadedBytes',
          'The supplied map doesn\'t contain the mandatory key `downloadedBytes`.');
    }

    return DrDownload(
        url: drDownloadMap['url'],
        percent: drDownloadMap['percent'],
        downloadedBytes: drDownloadMap['downloadedBytes']);
  }
}
