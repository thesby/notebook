pyplot api  https://matplotlib.org/api/pyplot_api.html
## Control Ticks
```python
from matplotlib.pyplot import xticks
# return locs, labels where locs is an array of tick locations and
# labels is an array of tick labels.
locs, labels = xticks()

# set the locations of the xticks
xticks( arange(6) )

# set the locations and labels of the xticks
xticks( arange(5), ('Tom', 'Dick', 'Harry', 'Sally', 'Sue') )
# fontsize control the actual size. size control the fontsize, Valid font size are large, medium, smaller, small, x-large, xx-small, larger, x-small, xx-large, None
xticks( arange(12), calendar.month_name[1:13], rotation=17, fontsize=13, size='large' )

# if you don't need xticks, you can just let it empty
xticks([])
```
```python
#coding=utf-8
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter

# ---------------------------------------------------
xmajorLocator = MultipleLocator(20)  # 将x主刻度标签设置为20的倍数
xmajorFormatter = FormatStrFormatter('%5.1f')  # 设置x轴标签文本的格式
xminorLocator = MultipleLocator(5)  # 将x轴次刻度标签设置为5的倍数

ymajorLocator = MultipleLocator(0.5)  # 将y轴主刻度标签设置为0.5的倍数
ymajorFormatter = FormatStrFormatter('%1.1f')  # 设置y轴标签文本的格式
yminorLocator = MultipleLocator(0.1)  # 将此y轴次刻度标签设置为0.1的倍数

t = np.arange(0.0, 100.0, 1)
s = np.sin(0.1 * np.pi * t) * np.exp(-t * 0.01)

ax = plt.subplot(111)  # 注意:一般都在ax中设置,不再plot中设置
plt.plot(t, s, '--r*')

# 设置主刻度标签的位置,标签文本的格式
ax.xaxis.set_major_locator(xmajorLocator)
ax.xaxis.set_major_formatter(xmajorFormatter)

ax.yaxis.set_major_locator(ymajorLocator)
ax.yaxis.set_major_formatter(ymajorFormatter)

# 显示次刻度标签的位置,没有标签文本
ax.xaxis.set_minor_locator(xminorLocator)
ax.yaxis.set_minor_locator(yminorLocator)

ax.xaxis.grid(True, which='major')  # x坐标轴的网格使用主刻度
ax.yaxis.grid(True, which='minor')  # y坐标轴的网格使用次刻度

plt.show()
```

## Control show page
```python
matplotlib.rcdefaults()
p = matplotlib.rcParams
# 配置图表字体
plt.rcParams['font.sans-serif'] = ['SimHei']
p["font.family"] = "sans-serif"
p["font.sans-serif"] = ["SimHei", "Tahoma"]
p["font.size"] = 10
p["axes.unicode_minus"] = False
# 配置图表大小
p["figure.figsize"] = (14.15, 20) # A4纸大小，竖向页面
    # p["figure.figsize"] = (20, 14.15) # A4纸大小，横向页面
# 配置图表分辨率
p["figure.dpi"] = 200
# 配置绘图区域的大小和位置，下面的值是基于图标的宽和高的比例
p["figure.subplot.left"] = 0.06   # 左边距 
p["figure.subplot.right"] = 0.94   # 右边距
p["figure.subplot.bottom"] = 0.05  # 下边距 
p["figure.subplot.top"] = 0.92   # 上边距
# 配置subplots之间的间距（水平间距和垂直间距），也是基于图标的宽和高的比例
p["figure.subplot.wspace"] = 0.12
p["figure.subplot.hspace"] = 0.2
```

# Create PDF
```python
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.gridspec as gs
from matplotlib.backends.backend_pdf import PdfPages
# 准备数据
import numpy as np
t = np.arange(0.0, 5.0, 0.01)
data = np.cos(2*np.pi*t)

# 配置图形
pdf = PdfPages(pdf_file)   # pdf_file为全路径的文件名
figure = plt.figure()
figure.subplots_adjust(hspace=0.4)   # 调整subplots之间的垂直方向的间距
figure.suptitle("Title")     # 设置页面上的标题

# 绘制第一个图形（曲线）
sp1 = figure.add_subplot(2, 1, 1)   # 设置plot的布局（rows, cols, num）
     # rows: 一页中图形的行数
     # cols: 一页中图形的列数
     # num: 绘制第几个图形（从1开始）
     # 还有一种写法: sp = figure.add_subplot(221)
# 进行基本的图形绘制
n = len(data)   # 要绘制数据的长度
sp1.set_xlim(0, n-1)   # 设置x轴的范围
sp1.set_ylim(-2, 2)   # 设置y轴的范围，不设置的话会自动设置合适的y值范围（可视区域最大化）
sp1.set_xlabel("x_label")
sp1.set_ylabel("y-label")
sp1.set_title("subtitle1", fontsize=10, color="b")   # 设置当前图形的Title
sp1.plot(data, linewidth=0.5, color="b")   # 以0.5线宽绘制蓝色的data图形
# 绘制第二个图形（点）
sp2 = figure.add_subplot(212)
sp2.set_xlabel("x_label_dot")
sp2.set_ylabel("y-label_dot")
sp2.set_title("subtitle2", fontsize=10, color="r")
for x, y in enumerate(data):   # 以尺寸为2绘制红色的点
    sp2.plot(x, y, "o", markersize=2, markerfacecolor="red", markeredgecolor="red")

pdf.savefig(figure)
plt.close()
pdf.close()
```

## Grid to control multi-plot
```python
#使用GridSpec对象可以实现。

gs1 = gs.GridSpec(3, 1)  # 网格设置为3行，1列，其中第一个图形占2行，第二个图形占1行
gs1.update(hspace=0, wspace=0, top=0.90, bottom=0.10)  # 为使两个图形合并在一起，hspace和wspace必须设置为0，top/bottom是基于整个页面的比例

sp1 = plt.subplot(gs1[0:2, :])   # 注意gs中使用的是index(从0开始)，不包含结束点。
                                    # 第一个参数"0:2"表示从第1行开始，占用2行到第三行结束；第二个参数":"表示占用所有列
                                    # 此处也可以使用 sp = figure.add_subplot(gs1[0:2, :])
sp2 = plt.subplot(gs1[2:3, :])  # 从第二行开始，到第三行结束（不含第三行），占用一行
# 此处也可以使用 sp = figure.add_subplot(gs1[2:3, :])

#合并多个图形的示例（例如，合并5个图形在一起显示）：
gs1 = gridspec.GridSpec(5, 1)   # 网格设置为5行，每个图形占用一行
sp1 = plt.subplot((gs[0, :]))   # 每个图形占用一行，可以直接使用index表示
sp2 = plt.subplot((gs[1, :])) 
sp3 = plt.subplot((gs[2, :])) 
sp4 = plt.subplot((gs[3, :])) 
sp5 = plt.subplot((gs[4, :])) 
```
## Multi x-axis or y-axis
```python
# 使用twinx()和twiny()方法。
# twinx()：共用X轴，使用新的Y轴坐标
# twiny()：共用Y轴，使用新的X轴坐标

# 创建新Y轴坐标：
ax1 = sp1.twinx()      # 第二Y轴（共用X轴）
ax1.set_xlim(0, n-1)   # 设置与sp1相同的X轴范围（不设置默认也是相同的X轴范围），如果修改则sp1的X轴范围也会同时改变
ymin, ymax = sp1.get_ylim()
ax1.set_ylim(ymin-5, ymax+5)   # Y轴与sp1的Y轴是独立开来的，可以随意设置而不影响sp1的Y轴范围
ax1.set_ylabel("第二Y轴：红色", color="r")
for ytl in ax1.get_yticklabels():  # 设置为第二Y轴坐标显示为红色
    ytl.set_color("r")
ax1.set_xticks([])     # 此处设置为不显示X轴坐标，则整个图形就不显示X轴坐标了（共用sp1的X轴坐标），同时X轴的顶部和底部标尺都隐藏了
ax1.plot(data1, linewidth=0.5, color="r")    # 绘制第二Y轴坐标系上的图形

#创建新X轴坐标：
ax2 = sp1.twiny()      # 第二X轴（共用Y轴）
ax2.set_xlim(0, len(data1)-1)   # X轴与sp1的X轴是独立开来的，可以随意设置而不影响sp1的X轴范围
ymin, ymax = sp1.get_ylim()
ax2.set_ylim(ymin, ymax)   # Y轴与sp1的Y轴是共用的，如果不设置则影响sp1的Y轴显示
ax2.set_xlabel("第二X轴：绿色", color="green")
for xtl in ax2.get_xticklabels():  # 设置为第二X轴坐标显示为绿色
    xtl.set_color("g")
ax2.plot(data1, linewidth=0.5, color="g")   # 绘制第二X轴坐标系上的图形
ax2.plot([0, n], [0, 0], linewidth=0.1, color="grey")  # 绘制0基准线
# hide the top iden
ax2 = sp.twiny()
ax2.set_xticks([])
```
