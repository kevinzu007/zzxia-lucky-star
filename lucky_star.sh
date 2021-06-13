#!/bin/bash
#############################################################################
# Create By: zhf_sy
# License: GNU GPLv3
# Test On: Ubuntu 18.04
#############################################################################


# sh
SH_NAME=${0##*/}
SH_PATH=$( cd "$( dirname "$0" )" && pwd )
cd ${SH_PATH}


# env
LIST='./people.list'                   #--- 人员名单
CURREND_LIST='/tmp/people.list.tmp'
cp -f  ${LIST}  ${CURREND_LIST}
DATE_TIME="`date +%F_%T`"
CURREND_LIST_TODAY="./people.list---${DATE_TIME}"   #--- 中奖人员
echo "${DATE_TIME}" > ${CURREND_LIST_TODAY}


# 屏幕分辨率:
#   1920 x 1080
# 按像素算：
#   192 x 108
# 按Terminal字符算(一行算两个字符高度)：
#   192 x 54    #--- 实际还要去掉边框与菜单栏等

# 获取图片像素
# convert ~/aa.png  -print "宽 x 长: %w x %h\n" 2>/dev/null

# SCREEN大小
#S_MAX_W=${COLUMNS}
S_MAX_W=`stty size | awk '{print $2}'`
#let S_MAX_H=${LINES}*2
let S_MAX_H=`stty size | awk '{print $1}'`*2



F_HELP()
{
    echo "
    用途：抽奖、问答程序
    注意：
        1、如果安装了image2ascii，可以显示人员的相片（体验更好），需要在【./my_photo/】下放以人员【姓名.png】或【姓名.jpg】的照片
        2、如果没装image2ascii，将会以纯字符的形式显示
    用法：
        $0  [-h|--help]
        $0  <-q|--question>  < <-p|--photo> | <-t|--text> >  <{抽几次}>  <{随机几次}>  <{间隔秒数}>      #--- 默认：抽6次，随机跳跃6次，间隔6秒
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
        $0  -h
        $0
        $0  3
        $0  3 4 5
        $0  -q
        $0  -q  3
        $0  -q  3 4 5
        $0  -q  -p
        $0  -q  -t
        $0  -q  -p  3 4 5
"
}


TEMP=`getopt -o hqpt  -l help,question,photo,text -- "$@"`
if [ $? != 0 ]; then
    echo "参数不合法！【请查看帮助：\$0 --help】"
    exit 1
fi
#
eval set -- "${TEMP}"


while true
do
    case $1 in
        -h|--help)
            shift
            F_HELP
            exit
            ;;
        -q|--question)
            shift
            QA='yes'
            ;;
        -p|--photo)
            shift
            SHOW_PHOTO='yes'
            ;;
        -t|--text)
            shift
            SHOW_PHOTO='no'
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "参数错误，请检查！"
            exit 1
    esac
done


# 参数默认值
QA=${QA:-'no'}                     #--- 默认no，关闭问答环节
SHOW_PHOTO=${SHOW_PHOTO:-'no'}     #--- 默认以文本方式运行
PEOPLE_NUM=${1:-6}                 #--- 抽几次
RANDOM_TIMES=${2:-6}               #--- 随机几次
SLEEP_S=${3:-1}                    #--- 间隔几秒



# https://github.com/qeesung/image2ascii
# 有image2ascii吗？
if [ "${SHOW_PHOTO}" = 'yes' -a "`which image2ascii > /dev/null 2>&1; echo $?`" -ne 0 ]; then
    echo -e "峰哥说：没有找到程序【image2ascii】，将会以【text】的方式运行"
    SHOW_PHOTO='no'
fi



# 用法：F_RATE  图片路径 缩放倍率
F_RATE()
{
    F_PIC=$1
    F_PIC_RATE=$2
    #
    F_PIC_W=`convert ${F_PIC}  -print "%w\n" 2>/dev/null`
    F_PIC_H=`convert ${F_PIC}  -print "%h\n" 2>/dev/null`
    # 取最小的（填满屏幕的倍率）
    F_S_RATE_W=`echo "scale=2; ${S_MAX_W} / ${F_PIC_W}" | bc -l`
    F_S_RATE_H=`echo "scale=2; ${S_MAX_H} / ${F_PIC_H}" | bc -l`
    F_S_RATE=$( echo ${F_S_RATE_W} ${F_S_RATE_H} | awk '{if($1 < $2) print $1; else print $2}' )
    F_S_PIC_RATE=`echo "scale=2; ${F_S_RATE} * ${F_PIC_RATE}" | bc -l`
    echo ${F_S_PIC_RATE}
    return 0
}


# 开始
clear
if [ "${SHOW_PHOTO}" = 'yes' ]; then
    #
    image2ascii  -f ./sys_photo/start.png
    read -p "Ready? Go"
    # 倒数
    for ((n=6;n>=0;n--))
    do
        clear
        image2ascii -f ./sys_photo/${n}.png
        sleep 1
    done
else
    echo '##########################################'
    echo '##########################################'
    echo '##########################################'
    echo "####                                  ####"
    echo "####                                  ####"
    echo "####           抽奖即将开始           ####"
    echo "####                                  ####"
    echo "####                                  ####"
    echo '##########################################'
    echo '##########################################'
    echo '##########################################'
    read -p "Ready? Go"
fi



for i in $(seq 1 ${PEOPLE_NUM})
do
    #
    TOTAL_LINES=$( wc -l < ${CURREND_LIST} )
    if [ ${TOTAL_LINES} -eq 0 ]; then
        echo "人员名单【${CURREND_LIST}】是空的"
        exit 1
    fi
    let TOTAL_LINES=${TOTAL_LINES}+1
    #
    j=1
    while true
    do
        # 选人
        while true; do
            let X_LINE=$RANDOM%${TOTAL_LINES}
            [ $X_LINE -ne 0 ] && break
        done
        NAME=`sed -n "${X_LINE}p" ${CURREND_LIST}`
        #
        # 随机次数
        if [ $j -eq ${RANDOM_TIMES} ]; then
            break
        else
            #
            clear
            if [ "${SHOW_PHOTO}" = 'yes' ]; then
                if [ -f ./my_photo/${NAME}.png ]; then
                    image2ascii  -f ./my_photo/${NAME}.png  -r `F_RATE  ./my_photo/${NAME}.png  1`
                elif [ -f ./my_photo/${NAME}.jpg ]; then
                    image2ascii  -f ./my_photo/${NAME}.jpg  -r `F_RATE  ./my_photo/${NAME}.jpg  1`
                else
                    image2ascii  -f ./sys_photo/404.png
                fi
            else
                echo '##########################################'
                echo '##########################################'
                echo '##########################################'
                echo "####                                  ####"
                echo "####                                  ####"
                echo "####           No.$i：${NAME}           ####"
                echo "####                                  ####"
                echo "####                                  ####"
                echo '##########################################'
                echo '##########################################'
                echo '##########################################'
            fi
            #
            sleep ${SLEEP_S}
        fi
        let j=$j+1
    done
    # 确认人选
    sed -i "${X_LINE}d" ${CURREND_LIST}
    # 显示
    clear
    if [ "${SHOW_PHOTO}" = 'yes' ]; then
        if [ -f ./my_photo/${NAME}.png ]; then
            image2ascii  -f ./my_photo/${NAME}.png  -r `F_RATE  ./my_photo/${NAME}.png  0.8`
        elif [ -f ./my_photo/${NAME}.jpg ]; then
            image2ascii  -f ./my_photo/${NAME}.jpg  -r `F_RATE  ./my_photo/${NAME}.png  0.8`
        else
            image2ascii  -f ./sys_photo/404.png  -r `F_RATE  ./sys_photo/404.png  0.8`
        fi
        read -p "No.$i: 你猜ta是谁？" WHO
        # 再显示名字
        read -p "【${NAME}】"
        # 姓名图片
        #clear
        #image2ascii -f ./my_photo/${NAME}-2.png -r `F_RATE  ./my_photo/${NAME}.png  0.8`
    else
        echo '##########################################'
        echo '##########################################'
        echo '##########################################'
        echo "####                                  ####"
        echo "####                                  ####"
        echo "####           No.$i：${NAME}           ####"
        echo "####                                  ####"
        echo "####                                  ####"
        echo '##########################################'
        echo '##########################################'
        echo '##########################################'
    fi
    # 区别从这里开始
    if [ "${QA}" = 'yes' ]; then
        read -p "有请幸运之星【${NAME}】回答问题"
        read -p '回答正确吗?(y|n)：' ACK
        echo "- No.$i:   ${NAME}  --  ${ACK}" >> ${CURREND_LIST_TODAY}
    else
        echo "- No.$i:   ${NAME}" >> ${CURREND_LIST_TODAY}
    fi
    #
    read -p "按任意键继续"
done

# output
clear
echo -e "\n本期幸运之星龙虎榜："
echo '########################################'
cat ${CURREND_LIST_TODAY}
echo '########################################'
echo
#dingding_by_markdown_file.py  --title='本期幸运之星龙虎榜：'  --message="`cat ${CURREND_LIST_TODAY}`"

