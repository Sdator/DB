## 常用函数
```js
// 用css语法查询元素
$$(css过滤器)        
// 用xpath语法查询元素
$x(xpath表达式)
// 查看对象类型
Object.prototype.toString.call(要查询的对象)

```

事件驱动
+ https://www.cnblogs.com/CyLee/p/7513342.html
```js
document.createEvent()
event.initEvent()
element.dispatchEvent()

// 1 选择元素
var dom = document.querySelector('#id')
// 2 绑定事件
document.addEventListener('alert', function (event) {
  console.log(event)
}, false);
 
// 3 创建事件对象
var evt = document.createEvent("HTMLEvents");
// 4 初始化事件
evt.initEvent("alert", false, false);
 
// 5 在dom中触发evt事件 >> 2
dom.dispatchEvent(evt);

```



## Xpath 语法
特性
+ 路径选择方式
  + 绝对路径选择
  + 相对路径选择
+ / 只匹配一级
+ // 匹配任意级包含一级

绝对路径选择
```bash
# 选择根节点下面的html节点
/html               # css html
/html/body/div      # css html>body>div
```

相对路径选择
```bash
# 选择所有div节点
//div       # div
 # 选择所有 div 节点里的 p 节点
//div//p    # div p
 # 选择所有 div 节点下的直属 p 子节点
//div/p     # div > p
//div/*     # div > *       选择 div 元素内的所有元素
```

```js
$x(xpath表达式)
$x('//div/p')
$x('//div/p/text()')        // 获取 p 节点下的文本


```



属性选择
+ 属性名注意前面有个 @
+ 属性值一定要用引号，单引号 或 双引号
```bash
# 语法
 //*[@属性名='属性值']
#  选择id为app的元素
//*[@id='app']

 ```




 ## 参考
 + https://www.cnblogs.com/c-x-a/p/9195644.html
 + http://www.python3.vip/tut/auto/selenium/xpath_1/
