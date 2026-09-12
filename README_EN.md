<div align="center">
  <img src="assets/new_logo.png" width="180" alt="VeneraX Auto" />
  <h1>VeneraX Auto</h1>

[![Flutter](https://img.shields.io/badge/flutter-3.44.3-blue)](https://flutter.dev/)
[![License](https://img.shields.io/github/license/Kyosee/VeneraX)](https://github.com/Kyosee/VeneraX/blob/master/LICENSE)
[![Upstream](https://img.shields.io/badge/fork%20of-Kyosee%2FVeneraX-6e47ff)](https://github.com/Kyosee/VeneraX)

  <h3><a href="README.md">中文</a> | English</h3>
</div>

VeneraX Auto is a free and open-source, multi-platform comic reader based on VeneraX. Its Android application ID is `io.github.kyosee.venera.auto`, so it can be installed alongside the official VeneraX without interference.

> **Original Project:** This project is forked from [Kyosee/VeneraX](https://github.com/Kyosee/VeneraX); VeneraX itself is based on [venera-app/venera](https://github.com/venera-app/venera). Following section 7 of the original disclaimer, this project is published under a distinguishable name (VeneraX Auto).

> [!IMPORTANT]
> **Before downloading, installing, or using this software, please read and fully understand the [User Agreement & Disclaimer](#user-agreement--disclaimer).** By downloading, installing, copying, modifying, or using this software, you are deemed to have read, understood, and accepted it in its entirety; if you do not agree, do not use the software and delete it immediately.

## Features Added on Top of VeneraX

- [x] Smooth auto scroll: constant-speed scrolling in continuous reading mode, speed defined as milliseconds per screen, with touch pause/resume, chapter-end stop or continue, and keep-screen-on
- [x] Hardware key mapping (Android): gamepad / DPAD / keyboard / media keys (headset controls) mapped to page turning, chapter switching, auto-scroll toggle and other reader actions, with custom bindings
- [x] Key-bound speed control: "increase / decrease auto scroll speed" actions, ±100 ms per press, effective immediately
- [x] Next-page behavior setting: page-aligned jump (tap / volume keys / hardware keys / timed turning all share one logic) or fixed-distance scroll (10%–100% of the viewport, configurable)
- [x] Standalone bookshelf: a comic list alongside favorites, with list / grid / waterfall views and added-time / name / last-read sorting
- [x] Comic merge: multi-select local comics in the bookshelf, drag to reorder and merge into one; each source comic becomes a chapter, files are moved directly without doubling disk usage
- [x] Chapter-end auto switching: when there is no next/previous chapter, page turning, volume keys, floating buttons, first/last page buttons and auto scroll fall back to the next/previous comic in the bookshelf
- [x] Import enhancements: three new options — "Import single archive file", "Import multiple archive files" and "Import folder (including sub-chapters)"; nested directories inside archives/folders are detected as chapters automatically
- [x] "Add to bookshelf" entry in the local comics multi-select menu

All VeneraX features (AI translation, cross-source aggregation, background tasks, WebDAV, etc.) are preserved; see the [upstream VeneraX README](https://github.com/Kyosee/VeneraX).

## Guide

Setup steps and interactions for each feature are documented in the **[guide](doc/guide.en.md)**. It is also available in the app under Settings → About → Guide.

> [!NOTE]
> In-app update checking is **disabled** in this project: the app only ships the version it was built from, and never checks for, announces, or downloads updates. For upstream VeneraX news, visit its [GitHub repository](https://github.com/Kyosee/VeneraX) (the "Repository" entry on the About page also opens it).

## Building

<details>
<summary><b>Local build</b></summary>

1. Install **Flutter 3.44.3** (this project pins that version; other versions may fail due to different Gradle/Kotlin plugin requirements)
2. Clone the repository and run `flutter pub get`
3. Build for your platform:

```bash
flutter build apk        # Android
flutter build windows    # Windows
flutter build linux      # Linux
flutter build macos      # macOS
```

**Android signing:** when `android/key.properties` is absent, the build script falls back to the debug keystore (installable, but signed differently from the official builds). For a proper signature, write your signing info into `android/key.properties` (not committed):

```properties
storeFile=/absolute/path/venera.jks
storePassword=your keystore password
keyAlias=venera
keyPassword=your key password
```

**Windows build notes:** if the pub cache (usually on C:) and the project directory are on different drive roots, Kotlin incremental compilation may fail; this project sets `kotlin.incremental=false` in `android/gradle.properties` to avoid it. `android.overridePathCheck=true` is set for non-ASCII project paths.

</details>

## Migration & Coexistence

- This project has a different application ID from the official VeneraX, so both can be installed side by side with isolated app data.
- To migrate data from VeneraX, use the in-app WebDAV backup/restore and choose a dedicated sync directory; do not share the directory with the official app.
- Export a local backup in the original app before migrating.

## User Agreement & Disclaimer

> [!NOTE]
> **Special Notice:** Please read and fully understand this statement before downloading, installing, or using this software. By downloading, installing, copying, modifying, or using this software, you are deemed to have read, understood, and accepted all of its terms.

**1. Nature of the Software**

1. This software is a user-configurable, local content reading tool that only provides technical capabilities such as network access, content parsing, reading layout, and local data management. The code is provided "AS IS", without warranty of any kind, express or implied; the maintainers do not guarantee its accuracy, completeness, or fitness for any particular purpose, and you use it at your own risk.
2. By default, this software does not pre-configure, bundle, or provide any third-party website content, data resources, or parsing extensions; the maintainers do not provide any content operation, storage, publishing, or distribution services, nor do they recommend or endorse any third-party content.
3. This project is for personal learning and research only, and its feature development and maintenance are AI-driven. It is a non-profit open-source project: the maintainers conduct no commercial operations and have not authorized any individual or organization to carry out paid distribution, resale, paid installation, traffic diversion, paid communities, or any other commercial activity in this project's name; any third-party commercial activity is unrelated to this project and undertaken at that party's own risk. The project may be suspended, changed, or discontinued at any time without notice.

**2. Extensions and User Conduct**

1. The software's online reading capability is implemented as a JavaScript-extension-compatible API. Users may create and edit extension scripts themselves, or import extension scripts shared by third parties; whether and which extensions are loaded is entirely up to the user to configure lawfully, and the user shall independently judge and bear full responsibility for their origin, legality, accuracy, and applicability.
2. When a user accesses third-party websites through extensions, the network requests are initiated directly from the user's device to the target websites. This software only provides local parsing, layout, and display capabilities, and does not publicly disseminate or redistribute any third-party content. Search results, chapter loading, image availability, and content copyright all depend on the respective websites and extensions, and are unrelated to this project.
3. Users must comply with the laws and regulations of their jurisdiction, network security requirements, and the terms of service and copyright policies of the relevant websites. Users must not use this software to infringe intellectual property rights, obtain data without authorization, distribute unlawful content or malware, disrupt any network service, or harm the lawful rights and interests of any company or individual.

**3. Third-Party Platforms and Communities**

Any extension-sharing platform, website, forum, or chat group established or maintained by third parties is an independently operated third party with no affiliation to this project. This project does not participate in the creation, publication, operation, maintenance, or distribution of such third-party extensions or communities, and assumes no obligation of proactive review; all risks and liabilities arising from using third-party extensions or accessing third-party websites shall be borne by the responsible parties in accordance with the law.

This project has not established and does not operate any official community, group, or public account, nor has it authorized any third party to advertise, promote, or publish in its name.

**4. Privacy and Data**

1. All features of this software run on the user's local device. This project operates no server, does not collect or upload any user data (including reading content, extension lists, or browsing history) to the maintainers, and integrates no analytics, crash-reporting, or telemetry components. Optional features that the user explicitly enables (such as AI translation) may send data to third-party services the user configures; see item 3 below.
2. Network and storage permissions are used only to implement the software's features such as online reading, local backup import/export, WebDAV sync, app update checks, AI translation, and translation model downloads, and for no other purpose; WebDAV sync transmits data only to a server configured by the user, and the maintainers cannot access, obtain, or control that server or any data stored on it.
3. AI translation is an optional feature that is disabled by default and ships with no preset provider, endpoint, or key. When the user enables it, recognized text is sent only to the third-party model service the user configures themselves; whether to use it, and which provider to use, is the user's own decision, and the user shall comply with that provider's terms — the maintainers neither access nor control such requests or data. The optional offline translation engine downloads publicly released, permissively licensed model files from a user-configurable public repository (such as HuggingFace or a mirror).

**5. Intellectual Property**

1. This project respects intellectual property rights. If a rights holder believes that the code or files directly contained in this repository infringe their lawful rights, they may submit a valid notice with identity proof, ownership proof, and specific details to the maintainers, who will handle it within their reasonable technical capabilities.
2. This project neither hosts nor controls any third-party extension or the third-party content parsed or presented by extensions, and is therefore unable to take removal, blocking, or other measures against them; rights holders should assert their rights against the publisher of the relevant extension or the party actually hosting the content.
3. This project does not accept issues or technical-support requests concerning third-party website content, extension configuration, the availability of specific works, or copyright ownership.

**6. Limitation of Liability**

1. To the maximum extent permitted by applicable law, this project and its maintainers shall not be liable for any direct, indirect, incidental, special, punitive, or consequential losses arising from the use of or inability to use this software, or from third-party extensions, third-party websites, network conditions, data loss, device failure, account issues, copyright disputes, or similar causes. Users shall evaluate and bear all risks of using this software.
2. This project does not guarantee compatibility with any third-party website, extension, or service, nor the continued availability of any feature.

**7. Derivative Work and Redistribution**

1. This project is a modified version of Venera, independently developed and published by this project's maintainers; the upstream project and its maintainers bear no responsibility for this project's code, builds, or conduct. The allocation of responsibility in this section runs both ways and applies equally to any version derived from this project.
2. Any version modified, built, or distributed from this project's source code (including forks, private builds, and self-signed installers) is the sole responsibility of whoever publishes that version. This project's maintainers do not review, endorse, or support such versions, and bear no responsibility for their code, builds, conduct, or any consequences thereof.
3. A modified version should be published under a distinguishable name and state prominently that it is a modified version of this project; it must not claim authorization or endorsement from this project, or any affiliation with it.
4. Only the builds provided on this repository's Release page are published by this project. Installers obtained through other channels, and any build that ships preset extension scripts, extension repository addresses, or content-source lists, are unrelated to this project; their integrity, security, and compliance are the responsibility of whoever provides them.
5. Whoever publishes a modified version shall fulfill the obligations in the LICENSE themselves and comply with the laws and regulations of their own jurisdiction, bearing the resulting responsibility.

**8. Miscellaneous**

1. Do not promote or advertise this project on any public or official platforms or official account areas (including but not limited to Weibo, WeChat Official Accounts, X, etc.).
2. This software is licensed and distributed under the license set out in the LICENSE file at the root of the repository; this disclaimer does not modify or limit the rights granted by that license, and the license prevails in case of conflict.
3. By downloading, copying, modifying, or using this project, you are deemed to have read and accepted this disclaimer in its entirety. The maintainers reserve the right to modify or supplement this disclaimer at any time, effective upon publication.
