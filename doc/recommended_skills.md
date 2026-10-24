# 推荐技能清单（本机 Skills 库）

本项目（VeneraX Auto / Flutter 漫画阅读器）的日常开发、调试、测试和发布，可优先使用以下技能。技能库位置：`E:\Skills库`（大写 S），如需启用，把对应技能目录复制到 `%USERPROFILE%\.qoder-cn\skills\`。

## 最推荐

| 技能 | 技能库路径 | 适用场景 |
|---|---|---|
| `systematic-debugging` | `superpowers/skills/systematic-debugging` | 阅读器、连续章节、导入等隐蔽 bug：先定位根因，再改代码 |
| `verification-before-completion` | `superpowers/skills/verification-before-completion` | 交付前强制跑 `dart analyze`、测试和构建，避免“看起来好了” |
| `dart-add-unit-test` | `flutter-skills/dart-add-unit-test` | 书架排序、章节导航、导入计数等纯逻辑的回归测试 |
| `flutter-add-widget-test` | `flutter-skills/flutter-add-widget-test` | 排序弹窗、导入进度条、阅读器工具栏等 UI 交互测试 |
| `dart-run-static-analysis` | `flutter-skills/dart-run-static-analysis` | 规范执行 `dart analyze` / `dart fix`，提交前质量门禁 |
| `dart-resolve-package-conflicts` | `flutter-skills/dart-resolve-package-conflicts` | 项目锁定 Flutter 3.44.3，处理 `pub get` 版本冲突 |
| `flutter-apply-architecture-best-practices` | `flutter-skills/flutter-apply-architecture-best-practices` | 重构 `reader.dart`、`home_page.dart` 等超大文件时按 UI/Logic/Data 分层 |

## 可选补充

| 技能 | 技能库路径 | 适用场景 |
|---|---|---|
| `conventional-commit` | `conventional-commit` | 统一 commit message（仓库已在用 Conventional Commits） |
| `code-review` | `mattpocock-skills/engineering/code-review` | 提交/PR 前做 Standards + Spec 两轴审查 |
| `requesting-code-review` | `superpowers/skills/requesting-code-review` | 让子代理审查当前改动 |
| `writing-plans` / `executing-plans` | `superpowers/skills/` | 较大功能先出实施计划，再按计划执行 |
| `finishing-a-development-branch` | `superpowers/skills/finishing-a-development-branch` | 收尾、验证、合并/发布检查清单 |
| `design-doc-mermaid` | `design-doc-mermaid` | 阅读器章节流转、导入流程、发布流程画 Mermaid 图 |
| `archify` | `archify` | 需要一页式架构说明或可交互 HTML 图时使用 |
| `dart-write-documentation` | `flutter-skills/dart-write-documentation` | 补 `///` API 文档与注释规范 |
| `dart-use-pattern-matching` | `flutter-skills/dart-use-pattern-matching` | Dart 3 模式匹配，重构复杂 `switch`（如 `ReaderMode` 分支） |

## 不建议使用 / 不适配

| 技能 | 原因 |
|---|---|
| `android-jetpack`（已安装） | 原生 Android 技能；本项目是 Flutter |
| `flutter-setup-localization` | 项目使用自定义 `assets/translation.json` + `.tl`，不是 intl/ARB 流程 |
| `flutter-use-http-package` | 项目使用 dio / rhttp，不是 `package:http` |
| `flutter-setup-declarative-routing` | 项目使用自定义导航，不是 go_router |
| `flutter-implement-json-serialization` | 现有模型/序列化方式已固定，引入手写模板价值不大 |
| `dart-fix-runtime-errors` / `flutter-fix-layout-issues` / `flutter-add-integration-test` | 依赖 Flutter/Dart MCP 的 hot reload、LSP、MCP 动作；当前环境未配置这些 MCP，只能部分使用 |
| Rust / GraphQL / 游戏 / 逆向类 | 项目没有 Cargo 工程和 GraphQL 业务；与漫画阅读器无关 |

## 推荐使用顺序

1. **修 bug**：`systematic-debugging` → `dart-add-unit-test` / `flutter-add-widget-test` 补回归 → `verification-before-completion`
2. **新功能**：`writing-plans` → `executing-plans` → 对应 Flutter/Dart 技能 → `code-review`
3. **重构**：`flutter-apply-architecture-best-practices` + `dart-use-pattern-matching`
4. **发布**：`verification-before-completion` → 按 [AGENTS.md](../AGENTS.md) 的 tag 驱动 CI 流程执行
5. **文档/说明**：`design-doc-mermaid` 或 `archify`

> 注意：技能是辅助流程，不改变本项目的构建/发布规范；构建与发布仍以 [AGENTS.md](../AGENTS.md) 为准。
