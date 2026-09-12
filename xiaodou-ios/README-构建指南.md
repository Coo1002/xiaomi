# 小咪 iOS App —— 构建与安装指南

把小咪装成**真正的 iPhone App**，并让她住进**灵动岛**。本工程是完整源码，在 Mac 上按下面步骤编译即可。

## 你需要

| 项目 | 要求 |
|---|---|
| 电脑 | 一台 **Mac**（Intel 或 Apple Silicon 均可） |
| 软件 | **Xcode 15+**（App Store 免费下载），以及命令行工具 |
| 手机 | **iPhone 14 Pro / 14 Pro Max / 15 Pro / 16 系列等带灵动岛的机型**（灵动岛硬件必需；锁屏横幅则所有机型可用） |
| 系统 | iPhone 系统 iOS 17.0 以上 |
| 账号 | 免费 Apple ID 即可（可装 7 天）；想长期使用需付费开发者账号（¥688/年） |

> 没有 Mac 就无法编译 iOS App（Apple 硬性限制，任何在线服务都代编译不了、也装不到你手机）。如果暂时没有 Mac，先用手机版 H5（主屏幕图标）过渡，工程留着以后用。

---

## 没有 Mac ？用 Windows 也能装真 App（免费）

iPhone 上没法直接"制作安装"原生 App，但你有 **Windows 电脑**就能做到：**GitHub 云打包 → Windows 免费侧载**。7 天有效，到期重装一次即可（想长期不用重装：付费开发者账号 ¥688/年）。

### 第 0 步：准备

| 项目 | 要求 |
|---|---|
| 电脑 | 任何 **Windows** 电脑（10/11） |
| 手机 | 带灵动岛的 iPhone（14 Pro 起），系统 iOS 17+ |
| 账号 | 免费 Apple ID（一个即可）；GitHub 账号（免费注册 github.com） |

### 第 1 步：让 GitHub 帮你打包 .ipa（约 5 分钟，只需做一次）

1. 注册 GitHub → 新建仓库（New repository，名字随意，如 `xiaomi-ios`，选 Private）
2. **把整个 `xiaodou-ios` 文件夹直接拖进 GitHub 的上传页**（Add file → Upload files 的拖拽区，GitHub 会自动递归上传所有文件，**包括隐藏的 `.github` 文件夹**）
   > 注意：**不要传 zip 压缩包**——GitHub 网页不会自动解压 zip，传了 Actions 会找不到配置。
3. 进仓库页面 → **Actions** 标签 → 左侧点 **build-ipa** → 右侧 **Run workflow** → 绿色按钮
4. 等 3~8 分钟，跑完显示绿色 ✓ → 点进这次运行 → 底部 **Artifacts** 里下载 **xiaomi-ipa.zip**
5. 解压得到 **小咪.ipa**（大约 1MB 多）

### 第 2 步：Windows 签名安装（每次 7 天，重装只需这一步）

1. Windows 浏览器打开 **https://sideloadly.io** 下载并安装 Sideloadly
   （它要求先装 Apple 官方驱动：安装时按提示装 iTunes 或 "Apple Devices"）
2. iPhone 数据线连 Windows，手机解锁并点「信任此电脑」
3. 打开 Sideloadly → 顶部选你的 iPhone → 把 **小咪.ipa** 拖进窗口
4. 输入你的 **Apple ID** 和 **App 专用密码**（在 appleid.apple.com → 登录与安全 → App 专用密码 里生成一个，别用账号主密码）
5. 点 **Start**，等待完成（第一次会要求手机确认安装，输一次手机锁屏密码）
6. iPhone 上：设置 → 通用 → **VPN与设备管理** → 点你的 Apple ID → **信任**
7. 打开小咪 —— 她就住进灵动岛了

### 第 3 步：7 天后续装

手机上的小咪提示"无法验证"或打不开时：再连 Windows，用 Sideloadly 重新拖一次 .ipa 点 Start 即可（30 秒）。

> 用 AltStore 代替 Sideloadly 也可以（altstore.io，同样免费，还有自动续签功能）。
> 想彻底免重装：升级付费开发者账号（¥688/年），我帮你配置正式签名。

---

## 三步编译安装（有 Mac 时）

### 第 1 步：生成 Xcode 工程

在 Mac 上打开「终端」，进入本目录：

```bash
cd ~/Downloads/xiaodou-ios        # 换成你存放本工程的路径

# 安装工程生成器 XcodeGen（只装一次）
brew install xcodegen

# 生成 小咪.xcodeproj
xcodegen generate
```

> 不想装 XcodeGen 的话：直接用 Xcode「File → New → Workspace」手动新建两个 target（App + Widget Extension）也行，但步骤繁琐，推荐 XcodeGen。

### 第 2 步：配置签名

1. 用 Xcode 打开生成的 `小咪.xcodeproj`
2. 选中左侧工程，点 target「小咪」（App）
3. **Signing & Capabilities** → Team 选择你自己的 Apple ID（首次会提示创建免费开发者证书，照做）
4. 如果提示 bundle id 冲突，把两个 target 的 `com.yourname.xiaomi.*` 改成你自己的（如 `com.liming.xiaomi.app`）
5. 同样给「小咪LiveActivity」target 选同一个 Team

### 第 3 步：安装到手机

1. iPhone 用数据线连 Mac，解锁并信任这台电脑
2. Xcode 顶部设备栏选择你的 iPhone
3. 按 **⌘R** 运行

首次运行后到手机「设置 → 通用 → VPN与设备管理 → 开发者 App」里**信任**你的证书，然后就能打开小咪了。

> 免费账号装的应用 **7 天过期**，到期重新 ⌘R 装一次即可；付费账号（¥688/年）可长期使用并可上架 App Store。

## 灵动岛怎么用

打开小咪 App 后，她会在灵动岛上"住"下来：

- **胶囊态**：左边是她的小头像，右边是能量百分比
- **长按展开**：头像 + 名字 + 情绪 + 能量进度条
- **锁屏**：横幅显示头像、情绪和能量
- 在 App 里摸摸 / 喂食 / 聊天，岛上的数字和表情**实时更新**（每 3 秒同步一次）

### 常见问题

| 现象 | 处理 |
|---|---|
| 岛上没有她 | 确认机型带灵动岛（iPhone 14 Pro 起）；打开系统「设置 → 灵动岛与实时活动」；App 内多点几次让她动一下，触发上报 |
| 免费证书 7 天过期 | 重新连 Mac ⌘R 安装 |
| 编译报错 | 把错误贴给我，我帮你看；常见原因是 Xcode 版本低于 15 或系统版本低于 iOS 17 |
| 想在 App Store 上架 | 需要 ¥688/年开发者账号 + 隐私合规，我可以帮你准备材料 |

## 工程结构

```
xiaodou-ios/
├── project.yml                  # XcodeGen 工程定义（两个 target）
├── 小咪App/
│   ├── 小咪App.swift            # App 入口
│   ├── ContentView.swift        # WKWebView 承载小咪 H5
│   ├── PetLiveBridge.swift      # H5→原生桥，驱动灵动岛
│   ├── Shared/PetLiveAttributes.swift  # 灵动岛数据模型（双 target 共享）
│   ├── web/index.html           # 小咪完整 H5（含原生桥上报脚本）
│   └── Assets.xcassets/         # App 图标（像素猫）
└── 小咪LiveActivity/
    ├── 小咪LiveActivity.swift   # 灵动岛/锁屏 UI
    ├── 小咪LiveActivityBundle.swift
    └── Assets.xcassets/         # 小咪情绪像素帧
```

所有记忆数据（成长、对话、知识、软件档案）都内嵌在 `web/index.html` 里，装进 App 后**完整保留**，与手机版共用同一份成长档案。
