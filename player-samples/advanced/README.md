# DoveRunner Multi-DRM SDK advanced sample

The DoveRunner Multi-DRM SDK advanced sample is a sample project that provides DRM content download and streaming playback.

## packages
```
advanced
  |
  ├─ android
  |   └─ android platform related files
  ├─ assets
  |   └─ DRM content files
  ├─ lib
  |   └─ advanced project related files
  ├─ ios
  |   └─ ios platform related files
  ├─ analysis_options.yaml
  ├─ pubspec.yaml // package configuration file
  └─ README.md
```

## Getting Started

- This project is a starting point for a Flutter application.
- A few resources to get you started if this is your first Flutter project:
  - [Lab: Write your first Flutter app][1]
  - [Cookbook: Useful Flutter samples][2]

> For help getting started with Flutter development, view the [online documentation][3], which offers tutorials, samples, guidance on mobile development, and a full API reference.

### Add package to `pubspec.yaml`
- Add Multi-DRM SDK package
- Add BetterPlayer for Multi-DRM package

    ```yaml
        # pubspec.yaml

        # Add Multi-DRM SDK package
        dr_multi_drm_sdk: ^1.2.0
        
        # Add BetterPlayer for Multi-DRM package  
        better_player:
        git:
          url: https://github.com/doverunner/betterplayer.git
          ref: master
    ```
### Install package and run
- Connect Android or iOS device and install package.

    ```bsh
        player-samples$ cd advanced
        // install package
        advanced$ flutter pub get
        // if ios
        // advanced$ cd ios
        // ios$ pod install
        // ios$ cd ..

        // run
        advanced$ flutter run
    ```

[1]: https://docs.flutter.dev/get-started/codelab
[2]: https://docs.flutter.dev/cookbook
[3]: https://docs.flutter.dev/