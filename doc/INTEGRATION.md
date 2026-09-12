# 整合说明（venera-copy → VeneraX）

本项目以 **VeneraX 2.3.2** 为底座，移植了 [venera-copy](https://github.com/aogua318/venera-copy)（基于原版 venera 1.6.3 的改版）的核心阅读与书架功能。功能重复的部分一律以 VeneraX 为准。

## 第二批移植（书架 + 翻页增强）

### 1. 下一页行为设置（连续阅读模式）

新增设置"下一页行为"（`continuousNextPageMode`）：
- `page`（默认）：整页跳转，页首对齐——**屏幕点按、音量键、手柄按键、定时翻页共用同一逻辑**（修复了原先手柄翻页是"固定滚一屏"与屏幕点按不一致的问题）
- `distance`：固定距离滚动，距离由"下一页滚动距离 (%)"（`continuousScrollDistance`，10–100% 屏高）设定

### 2. 按键映射新增调速动作

映射列表新增"加快自动滚动（-100ms）"与"减慢自动滚动（+100ms）"，每次按键调整
`autoScrollMsPerScreen` ±100ms（范围 100–600000），滚动进行中即时生效，并有 Toast 提示。

### 3. 书架（Bookshelf）

- 主界面新增"书架"标签页（Home 之后），支持本地 + 在线漫画
- 三种视图：列表 / 网格 / 瀑布流（`bookshelfViewMode`），选择后对话框自动关闭
- 排序：加入时间 / 名称 / 最近阅读 + 升降序（`bookshelfSortMode/Desc`），手动添加顺序不被排序破坏
- 多选（长按进入）：全选/反选/取消、删除、移出书架、**合并漫画**
- 本地漫画页多选菜单新增"加入书架"
- 数据存储于 `bookshelf.json`（App 数据目录），与 VeneraX 数据库体系互不影响

### 4. 漫画合并

书架多选 ≥2 本本地漫画 → 拖拽排序合并为一本：每本源漫画成为新漫画的一个章节，
文件直接移动（不占双倍空间），合并后删除源漫画，带文件级进度与屏幕常亮。

### 5. 导入新增三个选项（导入漫画对话框）

- **导入单个归档文件**：选择一个 cbz/zip/7z/cb7，归档内嵌套文件夹自动成为章节
- **导入多个归档文件**：选择一个包含多个归档的文件夹，每个归档导入为一部漫画
- **导入文件夹（包括小章节）**：选择一个文件夹，每个子文件夹作为一部漫画的章节
  （复用 VeneraX 现有的结构化扫描，不改变原有 4 个导入选项的行为）

### 6. 章末/翻章回退到"下一本"

按键翻章、音量键翻页、悬浮按钮、首/末页按钮、自动滚动章末——没有上/下一章时
自动切换到书架中的上/下一本漫画（`toNeighborComic`）。

## 第一批移植（阅读核心）

### 平滑自动滚动（连续阅读模式）

连续模式下的恒速平滑滚动，替代/并列于原版的"定时整屏翻页"。速度定义为
"每滚一屏高度所需毫秒数"，逐帧按真实时间差补偿，掉帧不改变速度。

- 引擎：`lib/pages/reader/auto_scroll.dart`（`AutoScrollEngine`，来自 venera-copy，原样移植）
- 挂接：`lib/pages/reader/images.dart` 的 `_ContinuousModeState`
  - 触摸屏幕自动暂停，抬起后按设置决定是否恢复
  - 滚动到末尾时按 `autoScrollOnChapterEnd` 设置停止或切换下一章后续滚
    （无缝跨章阅读模式下原地续滚；非无缝模式挂起待新章节装载后续滚）
  - `pageForward()` / `pageBackward()`：按屏翻页，供手柄按键动作调用
- 分发：`lib/pages/reader/reader.dart` 的 `toggleAutoPlay()`，按 `autoPlayMode`
  设置在"平滑滚动"与 VeneraX 自带的"定时翻页"之间二选一
- 工具栏：`lib/pages/reader/scaffold.dart` 的自动播放按钮改为播放/暂停图标，
  按当前阅读模式与设置显示 "Auto Scroll" / "Auto Page Turning"

自动播放期间（平滑滚动或定时翻页）调用原生 `setScreenOn` 保持屏幕常亮。

### 2. 外设按键映射（Android）

手柄 / DPAD / 键盘 / 媒体键（蓝牙耳机线控等）映射为阅读动作。
默认绑定：A/B/L1/R1 翻页，L2/R2 翻章，Y 与媒体播放键开/关自动滚动，DPAD 翻页。

- 通道：`android/.../MainActivity.kt` 新增 `EventChannel("venera/keys")` +
  `dispatchKeyEvent` 拦截（避免手柄按键触发焦点导航；BACK/MENU 不拦截）
- 监听：`lib/utils/hardware_keys.dart`（来自 venera-copy，原样移植），
  引用计数共享通道，阅读器替换时通道不中断
- 分发：`lib/pages/reader/reader.dart` —— `handleHardwareKey`（原生通道事件）
  与 `onKeyEvent`（键盘事件）共用一张映射表
- 映射 UI：设置 → 阅读 → "硬件按键映射"（Android），按任意键绑定，点击已绑定
  按键解除绑定，右上角恢复默认

## 新增设置项（支持 per-comic / per-device 覆盖，标 ✦）

| 键 | 默认 | 说明 |
|---|---|---|
| `autoPlayMode` ✦ | `smoothScroll` | 自动播放模式：平滑滚动 / 定时翻页 |
| `autoScrollMsPerScreen` ✦ | `5000` | 每屏滚动毫秒数（滑条 1000–60000，点数值可输入 100–600000） |
| `autoScrollOnChapterEnd` ✦ | `stop` | 滚动到章节末尾：停止 / 继续下一章 |
| `autoScrollResumeAfterTouch` ✦ | `false` | 触摸中断后抬起是否恢复滚动 |
| `inputKeyMap` | `{}` | 按键映射表，空时回退内置默认绑定 |

设置项位于 appdata 默认表（`lib/foundation/appdata.dart`），UI 在
`lib/pages/settings/reader.dart`（仅连续阅读模式下显示自动滚动相关项）。

## 与 venera-copy 原实现的差异

- 未移植书架（Bookshelf）及"章节读完切换书架下一本"（`toNeighborComic`）——
  书架是 copy 的独立功能，不属于本次两项核心范围；章末行为止于"下一章"
- 章末续滚适配了 VeneraX 的**无缝跨章阅读**（`ContinuousPageTurnCoordinator`）：
  无缝模式在章节原地跳转后直接续滚；copy 原实现基于其书架逻辑，无此路径
- VeneraX 的 `autoPageTurning` 已支持跨章续播，本整合在其上叠加屏幕常亮

## 验证状态

- `dart analyze lib`：无新增告警（仅上游遗留的 1 处 error / 若干 info）
- `flutter build apk --debug`：**构建成功**（147MB，含全部 ABI 分包），
  Dart 与 Kotlin（MainActivity.kt 按键拦截）均通过编译
- 翻译：`assets/translation.json` 新增 18 键 × 简繁双语（取自 venera-copy）
- 未做真机功能回归（手柄/线控行为需实机验证）

## 构建环境说明（相对上游 VeneraX 的构建适配）

本项目严格锁定上游工具链（Flutter 3.44.3 / Gradle 8.13 / Kotlin 2.1.0），
仅做了以下 Windows 本机构建适配：

- `pubspec.yaml`：保持上游锁定的 `flutter: 3.44.3`。本机需安装该版本
  （本机已装于 `D:\demoapp\flutter-3.44.3`，另有 3.47.2 共存——
  3.47.2 会因 Gradle/Kotlin/插件行为差异无法构建此项目）
- `android/gradle.properties`：
  - `android.overridePathCheck=true`：项目路径含中文
  - `kotlin.incremental=false`：pub 缓存（C 盘）与项目（E 盘）跨盘符时
    Kotlin 增量编译缓存损坏，导致 file_selector_android 编译失败
- `android/app/build.gradle`：缺少 `android/key.properties` 时回退默认
  debug 签名（上游要求正式签名，本地开发无法构建）；存在该文件时行为不变
- 首次构建若遇 gradle zip 损坏（`zip END header not found`），删除
  `GRADLE_USER_HOME\wrapper\dists\gradle-8.13-all` 下对应目录重试
