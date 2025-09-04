# basic

Basic Player for doverunner drm sdk

## packages
```
basic
  |
  ├─ android
  |   └─ android platform related files
  ├─ assets
  |   └─ DRM content files
  ├─ lib
  |   └─ basic project related files
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
- Add DoveRunner Multi Drm SDK package
- Add BetterPlayer for DoveRunner DRM package

    ```yaml
        # pubspec.yaml

        # Add DoveRunner Drm SDK package
        dr_multi_drm_sdk: ^1.2.X
        
        # Add BetterPlayer for DoveRunner DRM package
        better_player_plus:
        git:
          url: https://github.com/doverunner/better_player_plus_for_doverunner.git
          ref: 1.0.X
    ```
### Install package and run
- Connect Android or iOS device and install package.

    ```bsh
        player-samples$ cd basic
        // install package
        basic$ flutter pub get
        // if ios
        // basic$ cd ios
        // ios$ pod install
        // ios$ cd ..

        // run
        basic$ flutter run
    ```


[1]: https://docs.flutter.dev/get-started/codelab
[2]: https://docs.flutter.dev/cookbook
[3]: https://docs.flutter.dev/