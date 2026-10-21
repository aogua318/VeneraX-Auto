# 构建规范

## Android APK 构建（Windows 本机）

- 必须使用项目锁定的 **Flutter 3.44.3**：`D:\demoapp\flutter-3.44.3\bin\flutter`。系统默认的 3.47.2 会因 Gradle 版本校验和 pub 依赖约束导致构建失败。
- **不要在含中文的路径下执行 Flutter 构建**。`E:\Demo\github\venera综合\VeneraMerged` 会让 Dart AOT 快照器无法读取 `app.dill`（`Unable to read file ... app.dill`）；目录联接（junction）会被 Gradle 解析回真实中文路径，同样无效。
- 构建前把源码同步到纯 ASCII 目录 `E:\Demo\venera_build_src`（该目录是构建副本，源码以主工作区为准）：

```bash
cd "E:/Demo/github/venera综合/VeneraMerged"
tar --exclude=.git --exclude=build --exclude=.dart_tool --exclude=.gradle -cf - . | (cd /e/Demo/venera_build_src && tar -xf -)
cd /e/Demo/venera_build_src
"D:/demoapp/flutter-3.44.3/bin/flutter" pub get
"D:/demoapp/flutter-3.44.3/bin/flutter" build apk --release
adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

- `android/app/build.gradle` 的 `ndkVersion` 必须为 `28.2.13676358`（`jni` 等插件要求，本机已安装）。
- 未配置 `android/key.properties` 时使用 debug 签名；若手机上的同包名应用是正式签名，覆盖安装会失败，卸载会清除应用数据，必须先征得用户确认。
- 产物路径：
  - `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`
  - `build/app/outputs/flutter-apk/app-release.apk`（通用包）
- 安装后可用 `adb shell am start -W -n io.github.kyosee.venera.auto/io.github.kyosee.venera.IconDefault` 启动验证。
