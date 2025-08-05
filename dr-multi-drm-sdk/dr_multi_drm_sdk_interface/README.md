# dr_multi_drm_sdk_interface

[![pub package](https://img.shields.io/badge/puv-1.1.3-orange)](https://pub.dartlang.org/packages/pallycondrmsdk)

A common platform interface for the [`dr_multi_drm_sdk`][1] plugin.

This interface allows platform-specific implementations of the `dr_multi_drm_sdk`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface. Have a look at the [Federated plugins][2]
section of the official [Developing packages & plugins][3]
documentation for more information regarding the federated architecture concept.

## Usage

To create a new platform-specific implementation for the `dr_multi_drm_sdk` plugin, you can create a new class that extends the [`dr_multi_drm_sdk`][4] package, and implements the platform-specific behavior. When you register your plugin, you can set it as the default implementation by assigning it to `DrMultiDrmSdk.instance` like so: `DrMultiDrmSdk.instance = MyPlatformDrMultiDrmSdk().`"

## Issues

If you encounter any issues, bugs, or have any feature requests, please file them as an issue on the [GitHub][5] page. We also offer commercial support and can be reached at [DoveRunner Site][6].

## Author

This DrMultiDrmSdk plugin for Flutter is developed by [DoveRunner](https://www.doverunner.com).

[1]: ../dr_multi_drm_sdk
[2]: https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins
[3]: https://flutter.dev/docs/development/packages-and-plugins/developing-packages
[4]: ./lib/dr_multi_drm_sdk_interface.dart
[5]: https://github.com/doverunner/multi-drm-flutter-sdk/issues
[6]: https://www.doverunner.com
