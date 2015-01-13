GQURLDispatcher
===============

[![Travis-ci](https://travis-ci.org/gonefish/GQURLDispatcher.png)](https://travis-ci.org/gonefish/GQURLDispatcher)

GQURLDispatcher是一个简单且灵活的，基于URL的动作分发框架。通过URL和正则表达式来进行响应者Responder的匹配及调用，响应者Responder通常是View Controller的操作或者某个特定的方法，但不限于此。

Architecture
------------

### Core

* GQURLDispatcher
* GQURLDispatcherDelegate
* GQURLResponder

### Responder 

处理特定动作的实体，需要实现GQURLResponder协议。

1. GQSimpleResponder
1. GQNavigationResponder 
1. GQTabBarResponder
1. GQApplicationURLResponder
1. GQPresentResponder

### Other

* GQURLUtilities
* GQURLViewController GQURLViewController协议定义了更新URL和Object的方法，用于将这2个参数传递给UIViewController。GQURLViewController类继承了UIViewController，并实现了该协议。
* GQCompletionWrapper Block参数的对象包装。

### 分发流程

黄色的背景表示GQURLDispatcherDelegate交互的部分，绿色的背景表示GQURLResponder交互的部分。

![Dispatch Flow](https://raw.githubusercontent.com/gonefish/GQURLDispatcher/master/Dispatch%20Flow.png)

安装
------

CocoaPods

```ruby
pod 'GQURLDispatcher', '~> 0.3'
```

开始使用
------

### Responder

不同的Responder提供不同的响应行为，除了自带的Responder之外，还可以自定义Responder。

####GQNavigationResponder

提供UINavigationController的pushViewController:animated:处理。如果需要响应某个URL时，会根据事先配置的类名创建实例，然后进行pushViewController:animated:

```objc

// 需要传入UINavigationController的实例
GQNavigationResponder *responder = [[GQNavigationResponder alloc] initWithContainerViewController:navViewController alias:@"nav1"];

// 类名映射字典，Key是URL字符串，Value是类名
responder.classNameMap = @{@"gqurl://firstViewController": @"GQURLViewController"};

```

####GQTabBarResponder

提供UITabBarController的selectedIndex处理。响应tab://example/?selectedIndex=1时，会选中第2个Tab.

```objc

// 需要传入UITabBarController的实例
GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:tabBarController URL:[NSURL URLWithString:@"tab://example/"]];

```

####GQApplicationURLResponder

提供UIApplication的openURL的处理。默认初始化了responseURLStringRegularExpression的值为匹配所有字符串。当responseURLStringRegularExpression不为空时优先使用正则表式式进行匹配。

```objc

GQApplicationURLResponder *responder = [[GQApplicationURLResponder alloc] init];

```

####GQPresentResponder

提供UIViewController的presentViewController:animated:completion:的处理。如果需要响应某个URL时，会根据事先配置的类名创建实例，然后进行presentViewController:animated:completion:。completion中的block需要使用GQCompletionWrapper进行包装，然后通过自定义的参数传递。

```objc

GQPresentResponder *responder = [[GQPresentResponder alloc] initWithContainerViewController:viewController alias:nil];

```

使用时

```objc
GQCompletionWrapper *blockObj = [GQCompletionWrapper completionBlock:^{
    // Block的内容
}];

[GQURLDispatcher dispatchURL:aURL withObject:blockObj];

```

### 管理Responder

```objc
// 注册响应者
[[GQURLDispatcher sharedInstance] registerResponder:responder];

// 取消注册响应者
[[GQURLDispatcher sharedInstance] unregisterResponder:responder];

// 返回所有的响应者
[[GQURLDispatcher sharedInstance] responders];

// 通过别名快速查找响应者
[[GQURLDispatcher sharedInstance] responderForAlias:@"Foo"];

```

### 分发

```objc
NSURL *actionURL = [NSURL URLWithString:@"gqurl://firstViewController"];

// 分发actionURL
[[GQURLDispatcher sharedInstance] dispatchURL:actionURL];

// 与上面效果一样
[GQURLDispatcher dispatchURL:actionURL];

// 带自定义参数的分发
id anObject = @"Any object";

[[GQURLDispatcher sharedInstance] dispatchURL:actionURL withObject:anObject];

// 与上面效果一样
[GQURLDispatcher dispatchURL:actionURL withObject:anObject];

```

详细例子可查看Example工程。

自定义GQURLResponder
---------------

自定义Responder需要实现GQURLResponder协议中2个必须的方法：

```objc
/**
 *  需要响应的URL地址
 *
 *  @return 包含NSURL的数组
 */
- (NSArray *)responseURLs;

/**
 *  处理动作的方法
 *
 *  @param aURL     分发的URL
 *  @param anObject 额外的对象
 *
 *  @return 是否成功的处理URL
 */
- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject;
```

GQSimpleResponder实现了GQURLResponder协议中的大部分方法，通过继承该类可以快速地实现自定义的Responder。除此之外，还提供了通过URL创建UIViewController实例的功能，在创建时会判断是否为GQURLViewController类，如果是会通过initWithURL:object:来创建实例；如果不是则使用init创建实例，然后检测是否实现了GQURLViewController协议，如果是会调用updateWithURL:object:。

Contact
-------

[Q.GuoQiang](https://github.com/gonefish)

License
-------

GQURLDispatcher is available under the MIT license. See the LICENSE file for more info.
