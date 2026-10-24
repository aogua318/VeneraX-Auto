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

## 发布策略

正式发布走 GitHub Actions（tag 驱动）；本地构建只用于自测、装机验证和应急补包。原因：CI 能出全平台产物并自动校验/发布，且 Windows 本机无法构建 macOS/iOS/Linux 全平台。

### 正式发布（推荐）

1. 升级 `pubspec.yaml` 版本（例如 `2.3.4+247`）。
2. 新增 `release-notes/v2.3.4.en.md` 与 `release-notes/v2.3.4.zh-CN.md`，文件名必须与 tag 一致。
3. 提交并推送 `master`，然后创建并推送 tag（tag 必须严格等于 `v` + pubspec 版本）：

```bash
git tag v2.3.4
git push origin master
git push origin v2.3.4
```

4. “Build ALL” 由 tag 触发。tag 发布只构建 Android / Windows / Linux；macOS / iOS 仅手动 `workflow_dispatch` 构建。
5. Release 任务会校验版本、release notes 和资产完整性，并自动发布，不需要手动点 Publish。

已知坑点：

- **fork 仓库默认禁用 Actions**：需要在 Actions 页面手动启用，否则推 tag 不会产生任何运行。
- **重推同名 tag**：GitHub 只认 tag 创建事件；必须先删除远端 tag（`git push origin :refs/tags/vX.Y.Z`）再推。
- **已发布的 Release 会阻塞重跑**：Release 任务发现同 tag 已发布会报 “already published; refusing to rebuild”。重跑前删除该 Release（保留 tag），不要手动创建同名 Release。
- **Apple runner 不可靠**：iOS 经常因 macOS runner 容量不足被取消，macOS 构建本身也可能失败。tag 发布已排除 Apple，避免整个 Release 被阻塞；需要 Apple 产物时手动触发。
- **Android 签名**：未配置 `ANDROID_KEYSTORE_*` Secrets 时回退 runner 的临时 debug 签名。每次 CI 的 debug key 都不同，产物之间无法覆盖升级，正式分发前应配置固定 keystore（见下）。

### 固定签名（正式分发强烈建议）

- 在本地生成一次 release keystore，**不要提交到仓库**。
- 在仓库 Secrets 配置：`ANDROID_KEYSTORE_BASE64`、`ANDROID_KEYSTORE_PASSWORD`、`ANDROID_KEY_ALIAS`、`ANDROID_KEY_PASSWORD`。
- 本机 `android/key.properties` 指向同一个 keystore（该文件不入库）。
- 配置后 workflow 会自动安装 keystore，并执行签名连续性校验。
- 注意：已发布的 `v2.3.3` 是 CI 临时 debug 签名；启用固定 key 后，用户首次升级需要卸载一次旧包。

### 本地构建后手动传 Release（仅应急 / Android）

前提：本机已 `gh auth login`，且配置了固定 keystore。

```bash
cd /e/Demo/venera_build_src
"D:/demoapp/flutter-3.44.3/bin/flutter" build apk --release

# 覆盖现有 Release 中的同名资产
gh release upload v2.3.4 build/app/outputs/flutter-apk/app-release.apk --clobber

# 或新建 Release
gh release create v2.3.4 build/app/outputs/flutter-apk/app-release.apk \
  --title v2.3.4 --notes-file release-notes/v2.3.4.en.md
```

限制与风险：

- Windows 本机只能构建 Android / Windows；Linux 需要 WSL/虚拟机，macOS/iOS 必须有 Mac，**不存在“本地全平台”**。
- 手动上传不会更新 AltStore 清单，也没有 CI 的资产完整性与签名校验。
- 本机 debug 签名与 CI/上一次发布不一致时，APK 无法覆盖安装。

## 开发技能

本机技能库位于 `E:\Skills库`。本项目推荐使用的技能、适配场景以及不适用清单见 [doc/recommended_skills.md](doc/recommended_skills.md)。技能只辅助开发流程，构建与发布仍以本文件为准。

