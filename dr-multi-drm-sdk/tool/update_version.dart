import 'dart:io';

void main() {
  updateReadmeFiles(Directory.current);
}

void updateReadmeFiles(Directory dir) {
  try {
    for (var entity in dir.listSync(recursive: false, followLinks: false)) {
      if (entity is Directory) {
        // 하위 디렉토리 재귀 탐색
        updateReadmeFiles(entity);
      } else if (entity is File && entity.path.endsWith('README.md')) {
        // README.md가 있는 디렉토리에서 pubspec.yaml 찾기
        final readmeDir = File(entity.path).parent;
        final pubspecFile = File('${readmeDir.path}/pubspec.yaml');

        if (pubspecFile.existsSync()) {
          // pubspec.yaml이 존재하는 경우에만 처리
          final pubspec = pubspecFile.readAsStringSync();
          final versionMatch = RegExp(r'version:\s*(.+)').firstMatch(pubspec);
          final version = versionMatch?.group(1);

          if (version != null) {
            final content = entity.readAsStringSync();
            final updatedContent = content.replaceAll(
                RegExp(r'puv-.*?-orange'), 'puv-$version-orange');

            if (content != updatedContent) {
              print('Updating ${entity.path} with version $version');
              entity.writeAsStringSync(updatedContent);
            }
          }
        }
      }
    }
  } catch (e) {
    print('Error processing directory: ${dir.path}\nError: $e');
  }
}
