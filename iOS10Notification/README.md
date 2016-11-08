iOS10Notification
==========
iOS10引进了新的UserNotifications.framework，对iOS中消息通知进行了整合。

此示例发送远程消息，可借第三方工具([pusher](https://github.com/pusher/pusher-test-iOS),[PushMeBaby](https://github.com/Dwarven/PushMeBaby),[APN Tester](https://itunes.apple.com/us/app/apn-tester-free/id626590577?mt=12),或[在线工具](http://pushmebaby.herokuapp.com/))发送。

1.普通测试
```
{
  "aps":{
    "alert":"Test",
    "sound":"default",
    "badge":1
  }
}
```

2.加入Title 或 subTitle
```
{
  "aps":{
    "alert":{
      "title":"I am title",
      "subtitle":"I am subtitle",
      "body":"I am body"
    },
    "sound":"default",
    "badge":1
  }
}
```

3.测试自定义Action
```
{
  "aps":{
    "alert":"Please say something",
    "category":"saySomething"
  }
}
```

4.因Service Extension 现在只对远程推送的通知起效,这可以增加一个 mutable-content 值为1的项来启用内容修改；
```
{
  "aps":{
    "alert":{
      "title":"Greetings",
      "body":"Long time no see"
    },
    "mutable-content":1
  }
}
```

5.显示图片等多媒体内容；
```
{
  "aps":{
    "alert":{
      "title":"Image Notification",
      "body":"Show me an image from web!"
    },
    "mutable-content":1
  },
  "image": "http://ww3.sinaimg.cn/large/680dfa44jw1f8oe9tdh30j20z10z144p.jpg"
}
```

