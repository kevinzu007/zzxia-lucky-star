#!/usr/bin/python3
# encoding: utf-8

from typing import Text
from PIL import Image, ImageDraw, ImageFont
import random ,os

def randomcolor():
    colorArr = ['1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']
    color = ""
    for i in range(6):
        color += colorArr[random.randint(0,14)]
    anti_color = ""
    for i in color:
        anti_color_i = str(hex(16-int(i,16))).strip("0x")
        anti_color += anti_color_i
    return "#" + color, "#" + anti_color



def write(f_name,flag):
    b_color,f_color = randomcolor()
    if flag == "1" :
        PIC_W = 300
        PIC_H = 300
        image = Image.new("RGB",(PIC_W,PIC_H),b_color)
        draw_table = ImageDraw.Draw(im=image)
        font = ImageFont.truetype("./SimHei.ttf",90)
        _w,f_font_h=font.getsize(f_name)
        point_h = (PIC_H - len(f_name)*f_font_h) / 2
        j = 0
        for i in f_name:
            f_font_w,n=font.getsize(i)
            draw_table.text(xy=((PIC_W - f_font_w) / 2, point_h + f_font_h * j),text=i, fill=f_color, font=font)
            j += 1
        #image.show()  # 直接显示图片
        if os.path.exists('./my_photo/' + f_name + '.png'):
            pass
        else:
            image.save('./my_photo/' + f_name + ".png", 'PNG')  # 保存在当前路径下，格式为PNG
        image.close()
    elif flag == "2":
        PIC_W = 800
        PIC_H = 400
        image = Image.new("RGB",(PIC_W, PIC_H),b_color)
        draw_table = ImageDraw.Draw(im=image)
        font = ImageFont.truetype("./SimHei.ttf",240)
        w,h=font.getsize(f_name)
        draw_table.text(xy=((PIC_W - w)/2,(PIC_H - h) / 2),text=f_name, fill=f_color, font=font)
        #image.show()  # 直接显示图片
        if os.path.exists('./my_photo/' + f_name + "-2.png"):
            pass
        else:
            image.save('./my_photo/' + f_name + "-2.png", 'PNG')  # 保存在当前路径下，格式为PNG
        image.close()


if __name__ == "__main__":
    f = open("./people.list","r",encoding="utf-8")
    namelist = []
    a = f.readlines()
    f.close()
    for n in a:
        namelist.append(n.strip("\n"))
    image_file_flag = ["1","2"]
    for name in namelist:
        for x in image_file_flag:
            write(name,x)




