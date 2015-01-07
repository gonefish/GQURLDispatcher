GQURLDispatcher
===============

[![Travis-ci](https://travis-ci.org/gonefish/GQURLDispatcher.png)](https://travis-ci.org/gonefish/GQURLDispatcher)

GQURLDispatcher是一个简单且灵活的，基于URL的动作分发框架。通过URL和正则表达式来进行响应者Responer的匹配及调用，响应者Responer通常是View Controller的操作或者某个特定的方法，但不限于此。

Architecture
------------

### Core

* GQURLDispatcher
* GQURLDispatcherDelegate
* GQURLResponder

### Responder 处理特定动作的实体，需要实现GQURLResponder协议

1. **GQSimpleResponder**  实现了GQURLResponder协议的部分方法，通过继承该类可以快速的实现自定义的Responder。除此之外，还提供了通过URL创建UIViewController实例的功能，在创建时会判断是否为GQURLViewController类，如果是会通过initWithURL:object:来创建实例；如果不是则使用init创建实例，然后检测是否实现了GQURLViewController协议，如果是会调用updateWithURL:object:。
1. **GQNavigationResponder** UINavigationController的pushViewController:animated:动作的处理。
1. **GQTabBarResponder** UITabBarController的selectedIndex动作处理。
1. **GQApplicationURLResponder** UIApplication的openURL动作处理。
1. **GQPresentResponder** UIViewController的presentViewController:animated:completion:的动作处理。

### Other

* GQURLUtilities
* GQURLViewController GQURLViewController协议定义了更新URL和Object的方法，用于将这2个参数传递给UIViewController。GQURLViewController类继承了UIViewController，并实现了该协议。
* GQCompletionWrapper Block参数的对象包装

Installation
------

```ruby
pod 'GQURLDispatcher', '~> 0.2'
```



Usage
------

```objc
// 配置
GQNavigationResponder *responder = [[GQNavigationResponder alloc] initWithContainerViewController:navViewController alias:nil];
    
responder.responseURLs = @[[NSURL URLWithString:@"gqurl://firstViewController"]];

responder.classNameMap = @{@"gqurl://firstViewController": @"GQURLViewController"};

// 注册
[[GQURLDispatcher sharedInstance] registerResponder:responder];

// 使用
[GQURLDispatcher dispatchURL:[NSURL URLWithString:@"gqurl://firstViewController"]];
```

详细例子可查看Example工程。

Custom GQURLResponder
---------------

自定义Responder必须实现GQURLResponder协议中的2个方法：

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

GQSimpleResponder实现了一些公共的方法，通过继承GQSimpleResponder可以便捷的创建自己的Responder。

Contact
-------

[Q.GuoQiang](https://github.com/gonefish)

License
-------

GQURLDispatcher is available under the MIT license. See the LICENSE file for more info.
