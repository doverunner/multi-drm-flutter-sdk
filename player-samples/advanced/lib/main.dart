import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'features/advanced/presentation/app_pages.dart';
import 'features/advanced/presentation/controllers/drm_movie_binding.dart';
import 'features/advanced/presentation/pages/drm_content_page.dart';
// import 'injection_container.dart' as di;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoveRunner DRM SDK',
      home: const DrmContentPage(),
      initialBinding: DrmMovieBinding(),
      getPages: AppPages.pages,
    );
  }
}
