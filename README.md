# Swift-Samples

Swift 学习实战案例及 iOS 技术调研示例集合

---

## 📋 项目概述

Swift-Samples 是一个综合性的 iOS 开发示例项目，包含了 Swift 语言学习案例和多种 iOS 技术的实际应用示例。项目采用 Swift 语言开发，涵盖了 iOS Extensions、通知系统、UI 组件、数据库操作等多个技术领域。

---

## 🗂️ 模块列表

### 主应用模块

#### 1. **Swift-Samples**（主应用）

**功能描述**：
- 主应用入口，提供两个 Tab 页面：Swift 示例和先锋 Demo 示例
- 实现了 Swift 语言基础特性演示（枚举、结构体、属性观察器等）
- 集成了本地通知和远程推送功能
- 支持 App Search 功能

**关键技术点**：
- Swift 语言特性：枚举（原始值、相关值、递归枚举）、结构体（OptionSet）、属性观察器（willSet/didSet）、KVO
- UI 组件：UIProgressView、UISlider、UITextField
- 通知系统：本地通知、远程推送、信鸽推送 SDK 集成
- CoreSpotlight（App Search）

**技术要点**：
- 使用 `indirect` 关键字实现递归枚举 CompareExpression
- OptionSet 实现 CompareResult 结构体，支持组合选项
- TabBar 动画：使用 CATransition 实现淡入淡出效果

---

### UI 组件模块

#### 2. **ALTableView** - 自适应高度 TableView

**功能描述**：
- 支持动态高度的 UITableView 实现
- 展示 iOS 7 和 iOS 8+ 两种自适应高度方案
- 实现带部分圆角的 TableViewCell

**关键技术点**：
- 自适应 Cell 高度：iOS 8+ 使用 UITableViewAutomaticDimension，iOS 7 手动计算
- 自定义圆角视图：使用 Core Graphics 绘制部分圆角
- Auto Layout：preferredMaxLayoutWidth 动态计算

**技术要点**：
- **ACEPartRoundedCornerView**：重写 drawRect 实现部分圆角，支持四个角的任意组合
- **版本兼容**：通过 NSFoundationVersionNumber 判断 iOS 版本
- **Cell 位置判断**：ACETableViewCellPositionType 枚举标识 Cell 位置

---

#### 3. **Third-Libs** - 第三方库封装

**功能描述**：
- 创建自定义 View 组件，作为第三方库供主项目使用
- 演示如何创建可复用的 UI 组件

**关键技术点**：
- 自定义 View：程序化创建视图、便利构造器、layoutSubviews 重写
- Framework 封装：open 访问控制、组件化设计

**技术要点**：
- **TestView**：完全代码创建的自定义视图
- 使用 `open` 关键字允许外部模块继承和重写
- 在 layoutSubviews 中根据父视图 frame 动态调整

---

#### 4. **LWPickerLabel** - 四级地址选择器

**功能描述**：
- 实现完整的四级地址选择器（省-市-区-镇）
- 支持 SQLite 数据库查询、自定义 InputView、级联选择

**关键技术点**：
- 自定义输入视图：重写 UILabel 的 inputView 属性、实现 UIResponder 协议
- SQLite 数据库：C API 封装、SQL 查询和数据绑定、错误处理
- 级联选择：四级联动、UIPickerView 和 UITableView 两种实现

**技术要点**：
- **LWPickerLabel**：继承 UILabel，通过 becomeFirstResponder 触发自定义输入视图
- **LWAddressService**：封装 SQLite C API，提供类型安全的 Swift 接口
- 使用 AddrFiled 枚举管理当前显示的字段
- 数据库设计：分表存储（address_province、address_city、address_area、address_town）

---

### 通知系统模块

#### 5. **iOS10Notification** - iOS 10 通知框架完整示例

**功能描述**：
- 完整展示 iOS 10+ UserNotifications 框架的各种功能
- 包括本地通知、远程通知、自定义 UI、文本输入、通知扩展等

**关键技术点**：
- UserNotifications 框架：通知授权请求、本地通知触发、远程推送注册、通知 Category 和 Action
- NotificationService Extension：远程通知内容修改、图片下载和附件添加、MD5 加密
- NotificationContent Extension：自定义通知 UI、通知交互、多图片轮播

**技术要点**：
- 通知授权：requestAuthorization 请求 alert、sound、badge 权限
- **UNTextInputNotificationAction**：支持文本输入的通知操作
- NotificationService Extension 后台下载图片并添加到通知附件
- NotificationContent Extension 自定义通知 UI，支持 switch、open、dismiss 三种操作
- Device Token 处理：将 Data 转换为十六进制字符串

---

#### 6. **MyNotificationService** - 通知服务扩展

**功能描述**：
- 独立的 Notification Service Extension
- 用于在接收远程通知时修改通知内容

**关键技术点**：
- 内容修改：修改 title 和 body、下载远程图片、添加附件
- 文件管理：图片下载和缓存、MD5 文件名生成、安全存储

**技术要点**：
- serviceExtensionTimeWillExpire 回调处理超时情况
- URLSession 异步下载远程图片
- 将图片保存到 Caches 目录，使用 MD5 作为文件名

---

#### 7. **MyNotificationContent** - 通知内容扩展

**功能描述**：
- 简单的 Notification Content Extension 示例
- 展示如何自定义通知的展示内容

**关键技术点**：
- UNNotificationContentExtension 协议：didReceive 通知回调、自定义 UI 展示

**技术要点**：
- 最小化实现：仅展示通知 body 内容
- 参考 onevcat/UserNotificationDemo 项目

---

### Extension 模块

#### 8. **MyBroadCastUpload** - ReplayKit 广播上传扩展

**功能描述**：
- ReplayKit 框架的 Broadcast Upload Extension
- 用于处理屏幕录制的音视频流数据

**关键技术点**：
- ReplayKit 框架：RPBroadcastSampleHandler 子类化、音视频样本缓冲区处理、广播生命周期管理
- 样本处理：Video 样本、App Audio 样本、Mic Audio 样本

**技术要点**：
- **SampleHandler**：处理三种类型的样本缓冲区（video、audioApp、audioMic）
- 广播状态：broadcastStarted、broadcastPaused、broadcastResumed、broadcastFinished
- 需要在 Info.plist 中设置 RPBroadcastProcessMode

---

#### 9. **MyBroadCastUploadUI** - ReplayKit 广播 UI 扩展

**功能描述**：
- ReplayKit 的 Broadcast Setup UI Extension
- 提供广播配置界面

**关键技术点**：
- 广播配置：RPBroadcastConfiguration 设置、clipDuration 配置、setupInfo 传递
- 用户交互：完成设置流程、取消设置流程

**技术要点**：
- extensionContext 使用 completeRequest 传递广播 URL 和配置信息
- setupInfo 包含 userID 和 endpointURL 等服务器信息
- 用户取消时通过 cancelRequest 返回错误

---

#### 10. **MyPhotoEditing** - 照片编辑扩展

**功能描述**：
- Photo Editing Extension 框架示例
- 允许在系统照片应用中直接编辑图片

**关键技术点**：
- PHContentEditingController 协议：canHandle 判断是否支持、startContentEditing 开始编辑、finishContentEditing 完成编辑、cancelContentEditing 取消编辑
- 调整数据：PHAdjustmentData 处理、PHContentEditingInput 输入、PHContentEditingOutput 输出

**技术要点**：
- 异步处理：在后台队列渲染输出
- 编辑历史：通过 adjustmentData 保存编辑信息
- shouldShowCancelConfirmation 控制是否显示取消确认

---

#### 11. **MyShare** - 分享扩展

**功能描述**：
- Share Extension 示例
- 允许从其他应用分享内容到本应用

**关键技术点**：
- SLComposeServiceViewController：分享界面定制、输入验证、配置项添加
- 数据接收：NSExtensionItem 处理、NSItemProvider 数据提取、URL 类型判断

**技术要点**：
- isContentValid 验证分享内容的有效性
- configurationItems 添加自定义配置选项
- 通过 extensionContext.completeRequest 返回处理结果
- pushConfigurationViewController 展示配置界面

---

#### 12. **MyShareLinks** - Safari 共享链接扩展

**功能描述**：
- Shared Links Extension
- 在 Safari 的共享链接中显示自定义内容

**关键技术点**：
- NSExtensionRequestHandling 协议：beginRequest 处理请求、NSExtensionItem 数据构建
- 元数据设置：uniqueIdentifier、urlString、date、attributedTitle、attributedContentText

**技术要点**：
- 提供 URL、标题、描述和缩略图
- 使用内容发布日期
- 通过 NSItemProvider 添加缩略图

---

#### 13. **MySpotLightIndex** - Spotlight 索引扩展

**功能描述**：
- Spotlight Index Extension
- 维护应用在系统 Spotlight 搜索中的索引

**关键技术点**：
- CSIndexExtensionRequestHandler：reindexAllSearchableItems 全量重建索引、reindexSearchableItemsWithIdentifiers 增量更新
- 索引管理：CSSearchableItemAttributeSet 创建、CSSearchableItem 索引项、关键词和描述设置

**技术要点**：
- 搜索属性：title、contentDescription、thumbnailData、keywords 等
- 联系信息：phoneNumbers、emailAddresses 支持直接拨号和发邮件
- uniqueIdentifier 和 domainIdentifier 区分索引项
- 必须调用 acknowledgementHandler 以确认完成

---

### 学习示例模块

#### 14. **Swift-Samples/Swift-Learn** - Swift 类型转换示例

**功能描述**：
- 演示 Swift 的类型检查和类型转换特性
- 包括向下转型、Any 和 AnyObject 的使用

**关键技术点**：
- 类型检查（Type Checking）：is 操作符判断类型
- 向下转型（Downcasting）：as? 条件转换、as! 强制转换
- Any 和 AnyObject：AnyObject 存储类实例、Any 存储任意类型

**技术要点**：
- MediaItem 继承体系：Movie 和 Song 继承自 MediaItem
- 类型检查统计：遍历数组统计不同类型的数量
- Switch 模式匹配：在 switch 中使用 as 进行类型转换
- 闭包类型：Any 可以存储闭包类型

---

#### 15. **Swift-Samples/AppSearch** - 应用搜索功能

**功能描述**：
- 完整的 App Search 实现
- 包括 NSUserActivity 和 CoreSpotlight 两种索引方式

**关键技术点**：
- NSUserActivity：activityType 定义、用户信息字典、eligibleForSearch 和 eligibleForPublicIndexing
- CoreSpotlight：CSSearchableItemAttributeSet、CSSearchableItem、CSSearchableIndex

**技术要点**：
- 双重索引：同时使用 NSUserActivity 和 CoreSpotlight
- 搜索属性：支持电话、邮箱、关键词等多种属性
- updateUserActivityState 动态更新 activity 信息
- 使用 JPEG 压缩的图片数据作为缩略图

---

#### 16. **Swift-Samples/Swift-Explore** - 技术探索示例

**功能描述**：
- 包含多个技术探索示例
- MutiScroll（多滚动视图）和 TestView（GIF 动画测试）

**关键技术点**：
- 第三方库集成：FLAnimatedImage（GIF 播放）、MyThirdLibs（自定义组件）
- CocoaPods 依赖：Podfile 配置、use_frameworks!

**技术要点**：
- GIF 播放：使用 FLAnimatedImage 库播放动态 GIF
- 资源加载：从 Bundle 加载 GIF 文件
- 视图组合：TestView + FLAnimatedImageView

---

#### 17. **MyPlayground.playground** - Swift Playground 测试

**功能描述**：
- 用于快速测试 Swift 代码和 UI 的 Playground
- 包含 ViewTest 和 ImageTest 两个页面

**关键技术点**：
- Playground 特性：实时代码预览、Markdown 注释、资源引用

**技术要点**：
- 极简示例：用于快速验证想法
- 图片测试：展示如何在 Playground 中加载图片资源

---

## 🏗️ 项目整体技术架构

### 依赖管理
- **CocoaPods**：管理第三方库
  - FLAnimatedImage：GIF 动画支持
  - xg_ios_push：信鸽推送 SDK

### Extension 使用
项目大量使用 iOS Extension 机制：
1. **Notification Service Extension**：修改远程通知内容
2. **Notification Content Extension**：自定义通知 UI
3. **Share Extension**：分享功能
4. **Shared Links Extension**：Safari 共享链接
5. **Spotlight Index Extension**：Spotlight 索引维护
6. **Photo Editing Extension**：照片编辑
7. **Broadcast Upload Extension**：屏幕录制广播

### Swift 版本
基于 Swift 2.x/3.x 语法（部分代码需要迁移到最新 Swift 版本）

### 数据存储
- SQLite 数据库（地址数据）
- UserDefaults（配置信息）
- FileManager（文件缓存）

### 设计模式
- **Delegation**：UITableViewDelegate、UIPickerViewDelegate 等
- **Observer**：KVO、NotificationCenter
- **Extension**：大量使用 Swift Extension 扩展功能
- **Protocol-Oriented**：自定义协议和扩展

---

## ✨ 技术亮点总结

1. ✅ **iOS 10 新特性全面覆盖**：UserNotifications 框架的完整应用
2. ✅ **Extension 生态系统**：7 种不同类型的 Extension 示例
3. ✅ **Swift 语言特性**：枚举、泛型、协议、属性观察器等
4. ✅ **数据库封装**：SQLite C API 的 Swift 封装
5. ✅ **自定义 UI 组件**：部分圆角、自适应高度 Cell、自定义 InputView
6. ✅ **App Search**：双重索引（NSUserActivity + CoreSpotlight）
7. ✅ **版本兼容**：iOS 7/8/10 的兼容性处理

---

## 📝 使用的主要框架

| 框架 | 用途 |
|------|------|
| UIKit | 基础 UI 组件 |
| Foundation | 基础数据类型和工具 |
| UserNotifications | iOS 10+ 通知框架 |
| UserNotificationsUI | 通知 UI 扩展 |
| CoreSpotlight | Spotlight 搜索索引 |
| MobileCoreServices | 统一类型标识符 |
| ReplayKit | 屏幕录制和广播 |
| Photos/PhotosUI | 照片编辑扩展 |
| Social | 分享扩展 |
| SQLite3 | 本地数据库 |
| CoreGraphics | 图形绘制 |
| AVFoundation | 音视频处理 |

---

## 🚀 快速开始

### 环境要求
- Xcode 8.0+
- iOS 10.0+
- Swift 2.x/3.x
- CocoaPods

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/yourusername/Swift-Samples.git
cd Swift-Samples
```

2. **安装依赖**
```bash
pod install
```

3. **打开工作空间**
```bash
open Swift-Samples.xcworkspace
```

4. **运行项目**
- 选择 Swift-Samples scheme
- 选择模拟器或真机
- 点击 Run 按钮

---

## 📂 项目结构

```
Swift-Samples/
├── Swift-Samples/              # 主应用
│   ├── Swift-Learn/           # Swift 语言特性学习
│   ├── AppSearch/             # App Search 示例
│   └── Swift-Explore/         # 技术探索示例
├── ALTableView/               # 自适应 TableView
├── Third-Libs/                # 第三方库封装
├── LWPickerLabel/             # 四级地址选择器
├── iOS10Notification/         # iOS 10 通知完整示例
├── MyNotificationService/     # 通知服务扩展
├── MyNotificationContent/     # 通知内容扩展
├── MyBroadCastUpload/         # ReplayKit 上传扩展
├── MyBroadCastUploadUI/       # ReplayKit UI 扩展
├── MyPhotoEditing/            # 照片编辑扩展
├── MyShare/                   # 分享扩展
├── MyShareLinks/              # Safari 共享链接扩展
├── MySpotLightIndex/          # Spotlight 索引扩展
├── MyPlayground.playground/   # Swift Playground 测试
└── Pods/                      # CocoaPods 依赖
```

---

## 🛠️ 建议改进方向

1. **Swift 版本升级**：代码使用了较旧的 Swift 语法，建议升级到 Swift 5+
2. **架构优化**：可以考虑引入 MVVM 或 VIPER 架构
3. **依赖管理**：考虑迁移到 Swift Package Manager
4. **单元测试**：增加单元测试覆盖率
5. **文档完善**：增加详细的 API 文档和使用说明
6. **代码规范**：统一代码风格，使用 SwiftLint 等工具

---

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

---

## 👨‍💻 作者

- **作者名称**：[Your Name]
- **GitHub**：[Your GitHub Profile]

---

## 🙏 致谢

- FLAnimatedImage 库提供的 GIF 动画支持
- 信鸽推送 SDK
- onevcat/UserNotificationDemo 项目的参考

---

**最后更新时间**：2025-10-05
