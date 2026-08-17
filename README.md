# 知识内容系统

[![Verify](https://github.com/Tenlossiby/knowledge-content-system/actions/workflows/verify.yml/badge.svg)](https://github.com/Tenlossiby/knowledge-content-system/actions/workflows/verify.yml)

> 让资料、判断和复盘在下一次专业任务中真正派上用场。

**知识内容系统**是一个面向专业个人的通用 Skill。它不仅整理资料与案例，也帮助用户把日常工作中的判断、规则、方法和复盘，沉淀成**可见、可修改、可删除、可持续演进**的个人专业工作系统。

它不要求用户先学知识管理。用户照常处理自己的专业工作；当出现值得复用的经验时，Skill 再依据授权进入沉淀流程。

## 三条资产线

### 1. 资料与依据

文件、来源、模板、案例、数据与外部材料。

解决：**“我以前在哪里看过？”**

### 2. 判断与方法

规则、条件、优先级、工作流程、例外与专业边界。

解决：**“我以前遇到这种情况是怎么判断的？”**

### 3. 演进与复盘

候选方法、用户修正、方法变化、验证结果与边界调整。

解决：**“我的方法为什么变了？以后还能不能复用？”**

## 核心原则

知识内容系统严格区分：

```text
触发 ≠ 观察 ≠ 介入 ≠ 写入
```

- 默认是**即时协作**：先完成当前任务，不建立长期记忆。
- 未经授权，观察只存在于当前任务与当前对话，不跨会话累计。
- 长期记忆必须写入用户可见、可读、可编辑、可删除的位置。
- 对本 Skill 而言，用户删除对应可见文件后，Skill 不再读取或使用其中内容，也不会从隐藏副本恢复。
- 长期协作默认隔离到当前项目或用户指定工作空间，不自动混用不同客户、团队、身份或项目经验。
- 用户明确说“以后这样做”时，可进入快速规则通道，但会标注为“用户明确指定”，不会伪装成经过案例验证的方法。

> 宿主平台自身保存的聊天记录、账户数据或日志由平台自身的数据设置管理，不属于知识内容系统的可见工作空间。

## 三种协作模式

### 即时协作（默认）

完成当前任务，不保存长期内容，不创建工作空间。

### 辅助沉淀

完成任务后展示值得保存的资料、规则、案例或方法，由用户决定保存哪些。

### 长期协作

用户明确开启后，在可见工作空间中持续维护已授权的工作方法、规则、案例与复盘。默认仅限当前项目。

## 直接调用

安装后可以直接输入：

```text
知识内容系统
```

也可以：

```text
用知识内容系统整理这批资料。
```

```text
用知识内容系统复盘一下这次项目，整理我实际采用的步骤、判断依据和出现的例外。
```

```text
让知识内容系统记住：以后当前项目的所有方案都先检查资源限制。
```

```text
查看知识内容系统在当前项目中保存了什么。
```

```text
这次只做即时协作，不保存任何内容。
```

## 目录结构

```text
knowledge-content-system/
├── SKILL.md
├── skill.yaml
├── agents/
│   └── openai.yaml
├── references/
│   ├── collaboration-modes.md
│   ├── consent-protocol.md
│   ├── method-evolution.md
│   ├── observation-protocol.md
│   ├── platform-capability.md
│   ├── privacy-boundaries.md
│   ├── project-isolation.md
│   ├── rule-evolution.md
│   ├── visible-memory-protocol.md
│   └── write-receipt.md
├── templates/
├── examples/
├── tests/
├── README.md
├── CHANGELOG.md
├── NOTICE
└── LICENSE
```

`SKILL.md` 是核心入口；复杂协议放在 `references/`，可复用输出结构放在 `templates/`，行业示例只用于说明行为，不构成领域规则。

## 验证与测试

仓库提供两份等价的一致性与重命名验收脚本：

- [`tests/verify-knowledge-content-system.ps1`](./tests/verify-knowledge-content-system.ps1)：原始 PowerShell 验收脚本；
- [`tests/verify-knowledge-content-system.py`](./tests/verify-knowledge-content-system.py)：用于没有 PowerShell 环境时的跨平台 Python 版本。

两份脚本都扫描仓库中的 `.md` 与 `.yaml` 文件，并检查：

- `skill.yaml` 与 `agents/openai.yaml` 的“知识内容系统”显示名是否一致；
- 5 种明确调用词是否仍存在；
- 用户可见内容中是否意外出现旧版英文显示名；
- 默认“不创建长期记忆或工作空间”的保护语义是否存在；
- 旧工作区兼容说明是否仍保留。

本地使用 PowerShell：

```powershell
pwsh -NoProfile -File ./tests/verify-knowledge-content-system.ps1
```

没有 PowerShell 时，可使用 Python 3：

```bash
python ./tests/verify-knowledge-content-system.py
```

CI 运行：[`.github/workflows/verify.yml`](./.github/workflows/verify.yml) 在每次 `push` 和 `pull_request` 时使用 `windows-latest` 先执行原 PowerShell 脚本，再执行跨平台 Python 脚本；任何一项失败都会令工作流失败。两份脚本通过时均输出 `Knowledge Content System rename acceptance checks: PASS`。

当前实际结果：截至 2026-08-17，`main` 分支的仓库验收已在 GitHub Actions 中通过。页面顶部徽章与 GitHub Actions 运行记录用于显示后续提交的最新状态。本验收只检查仓库命名与关键边界的一致性，不代表已完成端到端平台兼容性、用户效果或大规模产品验证。

## 平台能力

知识内容系统按实际运行环境分级，而不泛称“完全兼容”：

| 等级 | 能力 | 行为 |
|---|---|---|
| Level 1：对话协作 | 读取用户提供的资料、输出方法文档 | 生成可复制内容，不声称已保存 |
| Level 2：可见知识空间 | 创建、读取、更新用户可见文件 | 经授权写入并给出回执 |
| Level 3：持续工作系统 | 长期维护、方法演进、复盘、版本管理 | 仅在实际具备对应能力时执行 |

IMA、WorkBuddy 等平台的具体等级应以实际运行测试为准。包格式适配不等于运行能力已经验证。

## IMA 与小红书分发

GitHub 仓库保存**完整源码版本**，包括 YAML 平台配置。

Release 建议同时提供：

- `knowledge-content-system-ima-v1.1.1.zip`：IMA 完整版。
- `知识内容系统-小红书分发版-v1.1.1.zip`：仅 Markdown 的分发版本，用于不允许 `.yaml` / Skill 文件格式的内容平台传播。

小红书分发版是兼容分发方案，不作为源码主版本。

## 安全与边界

- 不在未授权时建立长期文件、保存规则或跨会话累计信号。
- 不创建隐藏用户画像或不可见的长期记忆。
- 不自动混用不同项目、客户、团队或身份的经验。
- 不静默删除、覆盖或公开用户原始资料。
- 不把用户个人工作方式包装成行业通用规律。
- 高风险专业判断仍应由具备相应资质和责任边界的人完成。

更完整的规则见 `references/`。

## 版本

当前公开版本：**v1.1.1**。

早期开发版本曾使用内部标识 `professional-method-compiler`。自首次 GitHub 正式发布起，内部 Skill 标识统一为：

```text
knowledge-content-system
```

旧标识仅保留在迁移兼容说明或历史记录中。

## 作者与署名

本项目最初由 [Tenlossiby](https://github.com/Tenlossiby) 创建并维护。

采用 **Apache License 2.0** 开源。你可以使用、修改、商用和再分发，但需要遵守许可证要求，并在适用的再分发中保留版权、许可与 `NOTICE` 中的署名信息。

## License

Apache License 2.0 — Copyright 2026 Tenlossiby
