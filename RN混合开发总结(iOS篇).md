# RN混合开发(iOS篇)

RN混合开发有两种情况, 一种是在原生项目中使用RN, 一般在原生中,只会使用RN的相关界面(UI), 而不会去使用js相关的库; 另外一种是在RN项目中, 使用原生模块, 这里面又包含两种情况, 使用原生的功能模块和使用原生的界面(UI).

## 在原生项目中使用RN页面

在原生项目中使用RN页面是通过RCTRootView类来实现的, 然后将创建好的RCTRootView赋值给一个ViewController的view属性, 即可将RN的页面显示在原生的控制器中. 简单使用如下:
```Objective-C
UIViewController *viewController = [[UIViewController alloc] init];
viewController.title = @"RNPageOne";
NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RNPageTwo" initialProperties:@{@"name": @"xiaoming", @"age": @10, @"id": @"007"} launchOptions:nil];
rootView.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
viewController.view = rootView;
[self.navigationController pushViewController:viewController animated:YES];
    
```

也可以在某个控制器内部将RN页面赋值为控制器的view的属性, 这样可以实现更多自定义的原生功能. 简单使用如下:
```Objective-C

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RNPageThree";
    [self addRNPageThree];
}

- (void)addRNPageThree {
    NSURL *jsLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
    UIView *view = [[RCTRootView alloc] initWithBundleURL:jsLocation moduleName:@"RNPageThree" initialProperties:nil launchOptions:nil];
    self.view = view;
}

```

### 将RN页面导入原生模块中的相关步骤

1. 通过react-native init 命令创建一个react native项目, 该项目的名称最好和已存在的原生app的项目名保持一致. 
2. 删除项目中的app.js文件. 删除ios文件夹里面的所有文件, 将目前iOS项目的所有文件拷贝到ios文件夹中.
3. 1和2的步骤也可以通过手动的形式来添加, 步骤如下:
    1. 创建一个文件夹, 文件夹名称为RN项目名
    2. 在该文件夹下面创建一个package.json文件, 在配置文件中, 填写好需要的配置, 然后通过npm install进行安装. 
    3. 在该文件夹下面创建一个ios目录, 将已存在的iOS工程拷贝到该目录下.
4. 在Xcode工程中添加依赖, 推荐使用cocoapods来安装这些依赖, 不推荐使用手动方式来添加依赖, 更新依赖
    ```ruby
    platform :ios, '9.0'
    
    target 'RNHybridDemo01' do
    
    pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'CxxBridge', # 如果RN版本 >= 0.45则加入此行
    'DevSupport', # 如果RN版本 >= 0.43，则需要加入此行才能开启开发者菜单
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # 这个模块是用于调试功能的
    'RCTAnimation'
    # 在这里继续添加你所需要的RN模块
    ]
    # 如果你的RN版本 >= 0.42.0，则加入下面这行
    pod "yoga", :path => "../node_modules/react-native/ReactCommon/yoga"
    
    # 如果RN版本 >= 0.45则加入下面三个第三方编译依赖
    pod 'DoubleConversion', :podspec => '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
    pod 'glog', :podspec => '../node_modules/react-native/third-party-podspecs/glog.podspec'
    pod 'Folly', :podspec => '../node_modules/react-native/third-party-podspecs/Folly.podspec'
    
    end
    ```

5. 在RN中, 创建组件, 并且将通过AppRegistry进行组件注册

    ```jsx harmony
    import {
      AppRegistry,
    } from 'react-native'
    import { RNPageOne } from './js/components/RNPageOne'
    import { RNPageTwo } from './js/components/RNPageTwo'
    import { RNPageThree } from './js/components/RNPageThree'
    
    AppRegistry.registerComponent('RNPageOne', _=>RNPageOne)
    AppRegistry.registerComponent('RNPageTwo', _=>RNPageTwo)
    AppRegistry.registerComponent('RNPageThree', _=>RNPageThree)
    ```
    
6. 组件注册后, 就可以在原生项目中使用组件. 在原生项目中, 组件是以RCTRootView的形式来呈现的.
    ```Objective-C 2.0
    //获取index.js文件的url路径
    NSURL *jsLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil]; //获取index.js文件的位置
    // 通过模块名来创建View, moduleName表示的是在RN中注册的组件名, initialProperties表示的是组件的初始属性, 也就是会作为props传递给组件
    UIView *view = [[RCTRootView alloc] initWithBundleURL:jsLocation moduleName:@"RNPageThree" initialProperties:nil launchOptions:nil]; 
    self.view = view;

    ```
    
#### 原生项目与RN组件的交互

通过上面的步骤, 我们已经在原生项目中, 集成了RN组件, 与RN组件的交互, 主要涉及到两方面, 一是传递数据给RN组件, 二是如何对RN里面的事件做出反馈. 在iOS原生项目中, 是通过RCTBridgeModule来实现的, 在RN端是通过NativeModules模块来实现的.
1. 传递给数据给RN组件, 在创建RCTRootView的时候, 可以通过initialProperties参数传递值给RN组件
2. 对RN组件的事件做出响应, 也就是说可以在RN组件中调用原生的方法
    ```Objective-C
    //在原生中的定义.
    //导出原生方法的该类, 必须遵守RCTBridgeModule协议.
    RCT_EXPORT_MODULE() //导出模块, 在RN中使用的模块
    RCT_EXPORT_METHOD(goBack){ //导出方法
        NSLog(@"self:%@:%@", self, self.navigationController);
        UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [navigationController popViewControllerAnimated:YES];
    }
    
    RCT_EXPORT_METHOD(rnButtonClicked:(NSInteger)count) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了button" message:[NSString stringWithFormat:@"count:%ld", count] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    }
    ```
    ```jsx harmony
    //在RN组件中调用原生方法
    render() {
      return (
        <View style={styles.container}>
          <Text style={styles.text}>RNPageThree</Text>
          <TouchableOpacity
              style={styles.button}
              onPress={_=>NativeModules.RNPageViewController.goBack()}
          >
            <Text style={styles.buttonText}>Go Back</Text>
          </TouchableOpacity>
          <TouchableOpacity
              style={styles.button}
              onPress={_=>{
                count++
                const nativeManager = NativeModules.RNPageViewController
                nativeManager.rnButtonClicked(count)
              }}
          >
            <Text style={styles.buttonText}>Click Me</Text>
          </TouchableOpacity>
        </View>
      )
    }
    ```
    
    
## 在RN项目中使用原生界面(UI)和原生模块

### 在RN项目中使用原生界面

在原生端,导出视图给RN, 是通过RCTViewManager来实现的, 将需要导出的原生视图交给RCTViewManager来管理, 可以简单的认为, 一个RCTViewManager的子类表示导出某一个View给RN, RCTViewManager还提供导出属性, 导出事件给RN端. 具体简单使用如下:

```Objective-C 

#import "RNVMyViewManager.h"
#import "MyView.h"
#import "RCTConvert+Color.h"
@implementation RNVMyViewManager

//导出模块, 在rn中使用的模块.
RCT_EXPORT_MODULE(RNVMyView)

//这里的view将会作为显示在rn界面上的view
- (UIView *)view {
  return [[MyView alloc] init];
}

//导出属性, 通过js来控制原生控件的属性
RCT_EXPORT_VIEW_PROPERTY(userInteractionEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(text, NSString *)
RCT_EXPORT_VIEW_PROPERTY(fontSize, NSInteger)
//RCT_CUSTOM_VIEW_PROPERTY(text, NSString *, MyView) {
//  [view setText:[RCTConvert NSString:json]];
//}

//自定义导出的属性, 当RCTConvert里面提供的方法满足不了你的需求的时候,可以通过类型来自定义转换数据
RCT_CUSTOM_VIEW_PROPERTY(textColor, UIColor *, MyView) {
  [view setTextColor:[RCTConvert UIColorFromHexString:json]];
}

//导出事件
RCT_EXPORT_VIEW_PROPERTY(onClickHandler, RCTBubblingEventBlock);

@end

```

```jsx harmony

import React from 'react'

import {
  requireNativeComponent,
} from 'react-native'

import PropTypes from 'prop-types'

// export default requireNativeComponent('RNVMyView')
const RNVMyView = requireNativeComponent('RNVMyView')

const MyView = (props)=>(
    <RNVMyView {...props}/>
)

MyView.propTypes = {
  userInteractionEnabled: PropTypes.bool.isRequired,
  text: PropTypes.string,
  textColor:PropTypes.string,
  fontSize: PropTypes.number,
  onClickHandler: PropTypes.func
}

MyView.defaultProps = {
  userInteractionEnabled: true,
  textColor: '#eee',
}

export default MyView

render() {
    return (
      <View style={styles.container}>
        <MyView
            style={styles.myView}
            text='First'
            textColor={this.state.color}
            fontSize={24}
            onClickHandler={(event)=>{
              const { count } = event.nativeEvent;
              Alert.alert('Native Button Clicked', `点击次数:${count}`)
            }}
        />
        <MyView
            style={styles.myView}
            userInteractionEnabled={false}
            text='Second'
            textColor='#eee'
            fontSize={16}
        />
      </View>)
    }
```


### RCTViewManager中的方法和宏
* view: 返回的view, 会作为呈现在RN项目的组件
* RCT_EXPORT_VIEW_PROPERTY: 导出属性给对应的RN组件, 如果RCTConvert中提供的方法, 可以将属性转换指定的类型则可以使用, 如果不能, 则需要通过下面的方法来转换属性
* RCT_CUSTOM_VIEW_PROPERTY: 自定义属性.
* RCT_EXPORT_VIEW_PROPERTY(onClickHandler, RCTBubblingEventBlock): 导出方法给对应的RN的组件, 导出的方法一般都以on开头.

### 在RN项目中使用原生模块

导出原生模块给RN的类都需要遵守RCTBridgeManager协议.

在原生端的简单示例如下
```Objective-C 
#import "RNUserDefaults.h"
#import <React/RCTBridgeModule.h>
@interface RNUserDefaults() <RCTBridgeModule>
@end



@implementation RNUserDefaults

//导出模块名
RCT_EXPORT_MODULE(UserDefaults)
//导出不带返回值的函数
RCT_EXPORT_METHOD(saveUserName:(NSString *)userName forKey:(NSString *)key) {
  [[NSUserDefaults standardUserDefaults] setObject:userName forKey:key];
}

//导出同步的带有返回值的函数
RCT_EXPORT_SYNCHRONOUS_TYPED_METHOD(NSString *, getUserNameForKey:(NSString *)key) {
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return userName;
}

//导出block

RCT_EXPORT_METHOD(queryUserNameForKey:(NSString *)key handler:(RCTResponseSenderBlock)handler) {
  NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:key];
  if (handler && userName) {
    handler(@[[NSNull null], userName]);
  }else {
    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1000 userInfo:@{NSUnderlyingErrorKey:[NSString stringWithFormat:@"%@ is not exist", key]}];
    handler(@[error]);
  }
}

//导出Promise
//模拟导出promise
RCT_REMAP_METHOD(loadData, loadDataSuccess:(RCTPromiseResolveBlock)result failed:(RCTPromiseRejectBlock)failed) {
//  [self sendEventWithName:BEGIN_LOAD_DATA_EVENT body:nil];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    [self sendEventWithName:LOADING_DATA_EVENT body:nil];
    NSUInteger randomNumber = arc4random_uniform(100);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSLog(@"number:%ld", randomNumber);
      if (randomNumber > 50) {
        if (result) {
          result(@{@"data": @(randomNumber)});
        }
      }else {
        if (failed) {
          failed(@"100", @"load date failed", nil);
        }
      }
//      [self sendEventWithName:END_LOAD_DATA_EVENT body:nil];
    });
  });
}


//导出初始常量
- (NSDictionary *)constantsToExport {
  return @{@"userName": @"admin"};
}

//
+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (void)batchDidComplete {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));
}

- (void)partialBatchDidFlush {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));
}


@end

```

在RN端的实现如下: 

```jsx harmony

 _loadData() {
  //获取在原生中定义的模块
    const userDefaults = NativeModules.UserDefaults
    //调用导出的Promise
    userDefaults.loadData().then(({data})=>{
      Alert.alert(`data:${data}`)
    }).catch(({code, message})=>{
      Alert.alert(`error:${message}, code:${code}`)
    })
  }
  _queryUserName() {
    const userDefaults = NativeModules.UserDefaults
    //调用导出的回调
    userDefaults.queryUserNameForKey('userName',(error, userName)=>{
      if (error) {
        Alert.alert('获取用户名失败')
      } else {
        this.setState({userName})
      }
    })
  }

```

### 从原生发送事件给RN

继承自RCTEventEmitter的类, 就具有了给RN发送事件的能力.

原生端简单实现如下: 

```Objective-C

#import "NativeEventEmitter.h"

static NSString * const BEGIN_LOAD_DATA_EVENT = @"begin_load_data";
static NSString * const LOADING_DATA_EVENT = @"loading_data";
static NSString * const END_LOAD_DATA_EVENT = @"end_load_data";
static NSString * const kSendEventsToJS = @"com.jianghongbing.sendEventsToJS";

@interface NativeEventEmitter()
//+(void)emitEventWithName:(NSString *)name andPayload:(NSDictionary *)payload;
@end

@implementation NativeEventEmitter



RCT_EXPORT_MODULE(IOSEventEmitter)

RCT_EXPORT_METHOD(sendEvents) {
  [[NSNotificationCenter defaultCenter] postNotificationName:kSendEventsToJS object:nil];
}

//事件相关
//发送事件给js
- (NSArray<NSString *> *)supportedEvents {
  return @[BEGIN_LOAD_DATA_EVENT, LOADING_DATA_EVENT, END_LOAD_DATA_EVENT];
}
- (void)startObserving {
  [self addObserver];
}

- (void)stopObserving {
  [self removeObserver];
}

- (void)addObserver {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendEventsToJS:) name:kSendEventsToJS object:nil];
}

- (void)removeObserver {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendEventsToJS:(NSNotification *)notification {
  if ([notification.name isEqualToString:kSendEventsToJS]) {
  //发生事件
    [self sendEventWithName:BEGIN_LOAD_DATA_EVENT body:@{}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self sendEventWithName:LOADING_DATA_EVENT body:nil];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self sendEventWithName:END_LOAD_DATA_EVENT body:nil];
    });
  }
}

@end

```

RN端简单实现如下: 

```jsx harmony

  componentDidMount() {
    this._addListeners()
  }

  componentWillUnmount(){
    this._removeListeners()
  }

  _addListeners() {
  //获取原生模块
    const { IOSEventEmitter } = NativeModules
    //创建事件发生器对象
    const nativeEventEmitter = new NativeEventEmitter(IOSEventEmitter)
    //添加监听器, 一般在componentWillUnmount移除该监听器, 事件名称必须和在原生中发送的事件名称一致
    this.begin = nativeEventEmitter.addListener('begin_load_data', ()=>{
      Alert.alert('开始加载数据')
    })
    this.loading = nativeEventEmitter.addListener('loading_data', ()=>{
      Alert.alert('正在加载数据')
    })

    this.end = nativeEventEmitter.addListener('end_load_data', ()=>{
      Alert.alert('结束加载数据')
    })
  }
  
  _removeListeners() {
    this.begin.remove()
    this.loading.remove()
    this.end.remove()
  }
  
```

## 原生和RN交互中常用到的API

### 原生端中的类和协议

#### RCTBridgeModule: 桥接原生模块的属性和方法到对应的RN模块中.

1. RCT_EXPORT_MODULE: 导出模块名, 在RN使用的模块名, 如果没有给定的模块名, 就使用该类名作为模块名
2. RCT_EXPORT_METHOD: 导出方法, 不带返回值的方法
3. RCT_EXPORT_SYNCHRONOUS_TYPED_METHOD: 同步导出, 带有返回值方法
4. RCT_REMAP_METHOD: 导出指定名称的方法
5. requiresMainQueueSetup: 是否需要在主线程中,进行设置, 如重写了init方法, 要在该方法中返回YES.
6. methodsToExport: 导出常量给RN模块
7. methodQueue: 该模块方法执行的所在的线程, 默认是RN提供的一个线程,非主线程, 如果该模块所有的方法都在主线程中调用, 可以返回主线程给该属性

#### RCTViewManager: 桥接原生视图的属性和方法到对应的RN组件中

1. - (UIView *)view: RN组件中显示的视图
2. RCT_EXPORT_VIEW_PROPERTY: 导出属性到RN组件中
3. RCT_REMAP_VIEW_PROPERTY: 映射指定的keyPath的值作为对应的RN组件的属性
4. RCT_CUSTOM_VIEW_PROPERTY: 导出自定义的属性到RN的组件中, 当RCTConvert中提供的方法不能将你的属性转换成RN的属性的类型的时候, 需要自定义自己的转换方法, 可以通过该方法来实现

#### RCTEventManager: 发送原生事件给RN

1. supportedEvents: 支持的事件, 该返回必须有返回值
2. -(void)sendEventWithName:(NSString *)name body:(id)body: 从原生中发送事件到RN中
3. startObserving: 当第一个观察者被添加进来时的回调
4. stopObserving: 当最后一个观察者被移除时的回调
5. -(void)addListener:(NSString *)eventName: 添加监听者的回调
6. -(void)removeListeners:(double)count: 移除监听者的回调



#### RCTConvert: 原生数据类型和JS数据类型之间的转换

RCTConvert类中提供大量的方法, 将JS的数据类型转换成OC中的类型. 当该类中提供的方法不能满足自己的需求时,我们可以自定义自己的转换方法

### RN中的模块

#### NativeModules

所有在原生中导出的模块都被添加到该对象上, 作为它的一个属性.

```jsx harmony
import { NativeModules } from 'react-native'
//下面这两种方式都可以获取原生模块
// const MyModule = NativeModules.MyModule
const { MyModule } = NativeModules

```

#### requireNativeComponent: 获取到原生组件, 一个函数

```jsx harmony

import { requireNativeComponents } from 'react-native'
const MyView = requireNativeComponents('MyView')

```












