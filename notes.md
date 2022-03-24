## 变量

### 声明变量

NAME=VALUE在终端生成一个变量，终端运行的其他程序不能使用

export NAME=VALUE 声明一个全局变量，终端运行的其他程序也可以使用

unset NAME 撤销一个环境变量

readonly NAME=VALUE 声明一个静态变量，不能unset

### 特殊变量

1.$n（n为数字，$0代表该脚本名称，$1-9代表第1-9个参数，十以上的参数需要用大括号包含，如${10}）

2.$#（获取所有参数个数，常用于循环）

3.$*、$@

$\*（这个变量代表命令行所有参数，$*把所有参数看成一个整体）

$@（这个变量也代表命令行中所有参数，不过$@把每个参数区分对待）

4.$?（最后一次执行命令的返回状态。如果这个变量的值为0，证明上一个命令正确执行了；如果为非0，证明上一个命令执行不正确）（终端）

## 运算符

1.(1)$((运算式))或$[运算式]

(2)expr +，-，\\*，/，%   

多运算用``

计算(3+4)*5

1.expr \`expr 3 + 4\` \* 5

2.echo $[(3+4)*5]

注：expr运算符间要有空格



## 条件判断

1.[ 条件 ]（条件前后要有空格）condition

条件非空即true，[ cccccc ]返回true，[]返回false

2.常用条件判断

(1)两个整数比较

=  字符串比较

-lt 小于(less than)		-le 小于等于(less equal)

-eq等于(euqal)			 -gt 大于(greater than)

-ge 大于等于(greater equal)		-ne不等于(Not equal)

(2)按照文件权限进行判断

-r 有读的权限						-w 有写的权限

-x 有执行的权限

(3)按文件类型判断

-f 文件存在且是常规文件

-e 文件存在(existence)			-d文件存在并是一个目录

例：

[ 23 -le 22 ]

echo $?

结果1

[ 23 -ge 22 ]

echo $?

结果0

[ -w helloworld.sh ]

echo $?

结果0

[ -e helloworld.sh ]

echo $?

结果0

(4)多条件判断（&&表示前一条成功执行，才执行后一条，||表示上一条执行失败，才执行后一条）

[ condition ] && echo OK || echo notok

[ condition ] && [  ] || echo notok notok

## 流程控制

### if

1.基本用法

if [ 条件判断式 ];then

​	程序

fi

或者

if [ 条件判断式 ]

​	then

​		程序

fi

注：[ 条件判断式 ]，中括号左右两边有空格

if后要有空格

### case

1.基本语法

case $变量名 in

"值1")

​	如果变量值等于1，则执行程序1

​	;;

"值2")

​	如果变量值等于2，则执行程序2

​	;;

​	...省略其他分支...

*)

​	如果变量值都不是以上的值，则执行此程序

​	;;

esac

### for循环

1.基本语法

for(( 初始值;循环控制条件;变量变化 ))

do

​	程序

done

for 变量 in 值1 值2 值3

do

​	程序

done

### while循环

1.基本语法

while [ 条件判断式 ]

do

​	程序

done

## read读取控制台输入

read(选项)(参数)

选项：

​	-p：指定读取值时的提示符；

​	-t：指定读取值时等待的时间（秒）。

参数

​	变量：制定读取值的变量名

## 函数

### 系统函数

1.basename基本用法

basename [string/pathname] [suffix]

功能：basename命令会删除所有的前缀包括最后一个'/'字符，然后将字符串显示出来。

选项：

suffix为后缀，如果suffix被指定了，basename会将pathname或string中的suffix去掉

2.dirname基本语法

dirname文件为绝对路径

功能描述：从给定的包含绝对路径的文件名中取出文件名（非目录部分），然后返回剩下的路径（目录部分）

### 定义函数

[ function ] funname[()]

{

​	Action;

​	[return int;]

}

funname

注：

1.必须在调用函数之前，先声明函数，shell脚本逐行运行，不会像其他语言先编译

2.函数的返回值只能通过$?系统变量获取，可以显示加：return返回，如果不加，将最后一条命令的运行结果作为返回值。return后跟数值n(0-255)

## Shell工具

### cut

cut的工作就是“剪”，具体地说就是在文件中负责剪切数据用的。cut命令从文件的每一行剪切字节、字符、和字段并将这些字节、字符和字段输出

1.基本用法

cut [选项参数] filename

-f 列号，提取第几列

-d 分隔符，按照指定分隔符割裂

$cut -d " " -f 1 11cut.txt 

$cut -d " " -f 2,3 11cut.txt

$cat 11cut.txt | grep guan

切cut.txt中第一行的guan

$cat 11cut.txt | grep guan | cut -d " " -f 1

输出从第二个:后的所有环境变量80

$echo $PATH | cut -d ":" -f 3-

切割ifconfig 后打印ip地址

$ifconfig wlp1s0 | grep "inet " | cut -d " " -f 10

### sed

sed是一种流编辑器，它一次性处理一行内容。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”，接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出

1.基本用法

sed [选项参数] 'command' filename

2.参数说明

-e 直接在指令模式上进行sed的动作编辑

3.命令功能描述

a 新增，a的后面可以接字符串，在下一行出现

d 删除

s 查找并替换

将niubi添加到12sed.txt第二行下方

$sed "2a niu bi" 12sed.txt 

删除sed中包含有wo的行

$sed "/wo/d" 12sed.txt

将sed文件中wo替换为ni

$sed "s/wo/ni/g" 12sed.txt   不加g只替换第一个，加g全局替换

将sed中第二行删除，wo替换为ni

$sed -e "2d" -e "s/wo/ni/g" 12sed.txt 

## awk

一个强大的文本分析工具，把文件逐行的读入，以空格为默认分隔符进行切片，切开的部分再进行分析处理

1.基本用法

awk [选项参数] 'pattern 1{action1}     pattern2{action2}...' filename

pattern：表示AKW在数据中查找的内容，就是匹配模式

action：在找到匹配内容的同时执行的一系列命令

2.选项参数说明

-F 制定输入文件拆分符

-v赋值一个用户定义变量

3.

(1)搜索passwd文件以root开头的所有行，并输出该行第七列

awk -F : '/^root/ {print $7}' 13passwd

## sort

sort将文件排序，并将排序的结果标准输出

sort(选项)(参数)

-n  依照数据大小排序

-r  以相反的顺序来排序

-t  设置排序时所用的分隔符

-k 指定需要排序的列

以第二列倒叙排序

$sort -t : -nrk 2 14sort.sh 