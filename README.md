# zzxia-lucky-star

## 1 介绍
抽奖及问答SHELL程序。可以显示中奖人员照片。

### 1.1 背景
网上的抽奖程序都是windows的，且很多要收点费用，不如自己做一个。
由于近期培训考核，须随机提问，所以做它了。

### 1.2 功能
1. 随机抽奖
1. 选择开启问答模式
1. 可选文本方式或照片方式
1. 可选抽取人数、转盘次数、旋转速度

### 1.3 喜欢她，就满足她：

1. 【Star】她，让她看到你是爱她的；
1. 【Issue】她，告诉她有哪些小脾气，她会改的，手动小绵羊；
1. 【Fork】她，为她增加新功能，修Bug，让她更加卡哇伊；
1. 【打赏】她，为她买jk；
<img src="https://img-blog.csdnimg.cn/20210429155627295.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3poZl9zeQ==,size_16,color_FFFFFF,t_70#pic_center" alt="打赏" style="zoom:20%;" />


## 2 软件架构
Linux Shell

### 2.1 设计理念
1. 随机数取余数
1. 照片转ascii

### 2.2 目录结构
```bash
$ tree
.
├── clean.sh
├── LICENSE
├── lucky_star.sh
├── my_photo
│   ├── 李四强.png
│   ├── 陆六六.png
│   ├── 王老五.png
│   └── 张三丰.png
├── people.list
├── people.list.example
├── README.en.md
├── README.md
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

2 directories, 21 files
```


## 3 安装教程

克隆到Linux系统上即可。
在ubuntu上测试通过，理论上只要是基于Linux内核都行


## 4 使用说明
查看帮助即可
```bash
$ ./lucky_star.sh -h

    用途：抽奖、问答程序
    注意：
        1、如果安装了image2ascii，可以显示人员的相片（体验更好），需要在【./my_photo/】下放以人员【姓名.png】或【姓名.jpg】的照片
        2、如果没装image2ascii，将会以纯字符的形式显示
    用法：
        ./lucky_star.sh  [-h|--help]
        ./lucky_star.sh  <-q|--question>  < <-p|--photo> | <-t|--text> >  <{抽几次}>  <{随机几次}>  <{间隔秒数}>      #--- 默认：抽6次，随机跳跃6次，间隔6秒
    参数说明：
        \$0   : 代表脚本本身
        []   : 代表是必选项
        <>   : 代表是可选项
        |    : 代表左右选其一
        {}   : 代表参数值，请替换为具体参数值
        %    : 代表通配符，非精确值，可以被包含
        #
        -h|--help        开启问答环节
        -q|--question    开启问答环节，默认只抽奖
        -p|--photo       显示人员照片，请确保在【./my_photo/】下放了以人员【姓名.png】或【姓名.jpg】的照片
        -t|--text        显示文本，即不显示人员照片
    示例：
        ./lucky_star.sh  -h
        ./lucky_star.sh
        ./lucky_star.sh  3
        ./lucky_star.sh  3 4 5
        ./lucky_star.sh  -q
        ./lucky_star.sh  -q  3
        ./lucky_star.sh  -q  3 4 5
        ./lucky_star.sh  -q  -p
        ./lucky_star.sh  -q  -t
        ./lucky_star.sh  -q  -p  3 4 5
```


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
