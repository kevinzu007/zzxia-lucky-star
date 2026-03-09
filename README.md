# zzxia-lucky-star

中文名：猪猪侠之幸运之星抽奖系统

**如果有使用上的问题或其他，可以加wx：`zzxia_ggbond` 解决。加好友时请注明你来自哪个平台！**


## 1 介绍
抽奖及问答程序。可以显示中奖人员照片。

### 1.1 背景
网上的抽奖程序都是windows的，且很多要收点费用，不如自己做一个。
由于近期培训考核，须随机提问，所以做它了。

### 1.2 功能
1. 随机抽奖
1. 选择开启问答模式
1. 可选文本方式或照片方式
1. 可选抽取人数、转盘次数、旋转速度
1. 生成姓名图片

### 1.3 喜欢她，就满足她：

1. 【Star】她，让她看到你是爱她的；
1. 【Issue】她，告诉她有哪些小脾气，她会改的，手动小绵羊；
1. 【Fork】她，为她增加新功能，修Bug，让她更加卡哇伊；
1. 【打赏】她，为她买jk；
<img src="https://gitee.com/zhf_sy/pic-bed/raw/master/dao.png" alt="打赏" style="zoom:40%;" />


## 2 软件架构
Linux Shell
Python3 (需要依赖 `Pillow` 库：`pip3 install Pillow`)

### 2.1 设计理念
1. 随机数取余数
1. 照片转ascii

### 2.2 目录结构
```bash
$ tree
.
├── clean.sh
├── dingding_send_markdown.sh
├── docs
│   └── SCRIPT_HELP_SPEC.md
├── generate_text_photo.py
├── LICENSE
├── lucky_star.sh
├── my_photo
│   ├── bak
│   ├── zzxia-2.png
│   ├── zzxia.png
│   ├── 张三丰-2.png
│   ├── 张三丰.png
│   ├── 李四强-2.png
│   ├── 李四强.png
│   ├── 王老五-2.png
│   ├── 王老五.png
│   ├── 陆六六-2.png
│   └── 陆六六.png
├── people.list.sample
├── README.en.md
├── README.md
├── SimHei.ttf
└── sys_photo
    ├── 0.png
    ├── 1.png
    ├── 2.png
    ├── 3.png
    ├── 404.png
    ├── 4.png
    ├── 5.png
    ├── 6.png
    ├── start.png
    └── zzxia.png

4 directories, 27 files
```


## 3 安装教程

克隆到Linux系统上即可。
在ubuntu上测试通过，理论上只要是基于Linux内核都行


## 4 使用说明

1. 将抽奖人员名单写入文件【./people.list】（参考./people.list.sample）
2. 如果需要更好体验，将人员照片保存到【./my_photo/姓名.png】。如果没有也可以运行【./generate_text_photo.py】产生基于姓名的图片(自动跳过已存在的图片)。当然也可以什么都不做，运行在纯文本方式
3. 运行抽奖程序【./lucky_star.sh】，请看帮助：

```bash
$ ./lucky_star.sh -h

    用途：抽奖、问答程序
    特征码：
        未命名
    权限要求：
        未指定
    依赖：
        export DINGDING_WEBHOOK_API="https://oapi.dingtalk.com/robot/send?access_token=你的token" 注入
        photo方式需要：image2ascii - 图片转文本（https://github.com/qeesung/image2ascii）
                       convert     - 计算图片长宽（https://github.com/ImageMagick/ImageMagick）
    注意：
        1、text方式
            不需要安装其他软件包，可以直接使用
        2、photo方式
            - image2ascii可以支持显示人员的相片（体验更好），需要在【./my_photo/】下放以人员【姓名.png】或【姓名.jpg】的照片
            - 如果没装image2ascii，将会以纯字符的形式显示
            - convert可以计算图片的长宽，用以动态适配屏幕，非常棒
    用法：
        ./lucky_star.sh  -h|--help
        ./lucky_star.sh  [-s|--send-message] [-q|--question] [-p|--photo|-t|--text] [<抽几次> <旋转几次> <旋转速度>]
    参数规范：
        无包围符号 ：-a                : 必选【选项】
                   ：val               : 必选【参数值】
                   ：val1 val2 -a -b   : 必选【选项或参数值】，且不分先后顺序
        []         ：[-a]              : 可选【选项】
                   ：[val]             : 可选【参数值】
        <>         ：<val>             : 需替换的具体值（用户必须提供）
        %%         ：%val%             : 通配符（包含匹配，如%error%匹配error_code）
        |          ：val1|val2|<valn>  : 多选一
        {}         ：{-a <val>}        : 必须成组出现【选项+参数值】，且保持顺序
                   ：{val1 val2}       : 必须成组的【参数值组合】，且必须按顺序提供
    参数说明：
        -h|--help        此帮助
        -q|--question    开启问答环节，默认只抽奖
        -p|--photo       显示人员照片，请确保在【./my_photo/】下放了以人员【姓名.png】或【姓名.jpg】的照片
        -t|--text        显示文本，即不显示人员照片
        -s|--send-message  发送dingding消息（需要设置``中的token）
        <抽几次> <旋转几次> <旋转速度>    默认：抽6次，旋转6次，旋转速度1秒/次
    示例：
        ./lucky_star.sh  -h
        ./lucky_star.sh                 #--- 默认（不显示照片，抽6人，旋转6次，旋转速度1秒/次）
        ./lucky_star.sh  3              #--- 抽3人，其他默认
        ./lucky_star.sh  3 4 5          #--- 抽3人，旋转4次，旋转速度5秒/次
        ./lucky_star.sh  -q             #--- 开启问答，其他默认
        ./lucky_star.sh  -q  3          #--- 开启问答，抽三人，其他默认
        ./lucky_star.sh  -q  3 4 5      #--- 开启问答，抽3人，旋转4次，旋转速度5秒/次
        ./lucky_star.sh  -q  -p         #--- 开启问答，显示照片，其他默认
        ./lucky_star.sh  -q  -t         #--- 开启问答，不显示照片，其他默认
        ./lucky_star.sh  -q  -p  3 4 5  #--- 开启问答，显示照片，抽3人，旋转4次，旋转速度5秒/次
        ./lucky_star.sh  -s  -q  -p  3 4 5  #--- 开启问答，显示照片，抽3人，旋转4次，旋转速度5秒/次

Good Luck!
```


#### 5 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 6 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
