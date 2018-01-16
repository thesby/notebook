## Ticks
https://www.cnblogs.com/nju2014/p/5707980.html

## [Matplotlib fill area](http://stackoverflow.com/questions/16417496/matplotlib-fill-between-multiple-lines)
```python
	
If you start the plot in point (0, 0), and therefore do not need to consider the area of the polygon not in the first quadrant, then this should do the trick in this particular situation:

import matplotlib.pyplot as plt
import numpy as np

x = np.arange(0,10,0.1)

# The lines to plot
y1 = 4 - 2*x
y2 = 3 - 0.5*x
y3 = 1 -x

# The upper edge of polygon (min of lines y1 & y2)
y4 = np.minimum(y1, y2)

# Set y-limit, making neg y-values not show in plot
plt.ylim(0, 5)

# Plotting of lines
plt.plot(x, y1,
         x, y2,
         x, y3)

# Filling between line y3 and line y4
plt.fill_between(x, y3, y4, color='grey', alpha='0.5')
plt.show()
```
## [Matplotlib plot control](https://www.ibm.com/developerworks/cn/linux/l-matplotlib/)
Add math function
```python
ylabel(r'$\rm{Amplitude} \ f(x)$', fontsize=16)
title(r'$f(x) \ \rm{is \ damping  \ with} \ x$', fontsize=16)
text(2.0, 0.5, r'$f(x) = \rm{sin}(2 \pi  x^2) e^{\sigma x}$', fontsize=20)
```
properties
```python
# change the global fontsize.
import matplotlib.pyplot as plt

SMALL_SIZE = 8
MEDIUM_SIZE = 10
BIGGER_SIZE = 12

plt.rc('font', size=SMALL_SIZE)          # controls default text sizes
plt.rc('axes', titlesize=SMALL_SIZE)     # fontsize of the axes title
plt.rc('axes', labelsize=MEDIUM_SIZE)    # fontsize of the x and y labels
plt.rc('xtick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
plt.rc('ytick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
plt.rc('legend', fontsize=SMALL_SIZE)    # legend fontsize
plt.rc('figure', titlesize=BIGGER_SIZE)  # fontsize of the figure title

plt.rcParams['image.cmap'] = 'gray' # set imshow to be gray.
```
```python
'''from http://stackoverflow.com/questions/3899980/how-to-change-the-font-size-on-a-matplotlib-plot'''
import matplotlib.pyplot as plt
ax = plt.subplot(111, xlabel='x', ylabel='y', title='title')
for item in ([ax.title, ax.xaxis.label, ax.yaxis.label] +
             ax.get_xticklabels() + ax.get_yticklabels()):
    item.set_fontsize(20)  # set fontsize of each item.
```

## Draw some shape on the image.
```python
from matplotlib.patches import Ellipse, Circle, Polygon
alpha = 0.9
fill = True
linewidth = 3
ax = plt.gca()
ax.add_patch(Polygon(points,alpha=alpha, fill=fill, color=color, lw=linewidth))
ax.add_patch(Circle(center, radius, alpha=alpha, fill=fill, color=color, lw=linewidth))
ax.add_patch(Ellipse(center, radius_x, radius_y, angle, alpha=alpha, fill=fill, color=color, lw=linewidth))
```

## [Matplotlib: save plot to numpy array](http://stackoverflow.com/questions/7821518/matplotlib-save-plot-to-numpy-array)
```python
import matplotlib.pyplot as plt
import numpy as np

# Make a random plot...
fig = plt.figure()
fig.add_subplot(111)

# If we haven't already shown or saved the plot, then we need to
# draw the figure first...
fig.canvas.draw()

# Now we can save it to a numpy array.
data = np.fromstring(fig.canvas.tostring_rgb(), dtype=np.uint8, sep='')
data = data.reshape(fig.canvas.get_width_height()[::-1] + (3,))
```

## Matplotlib: capture the key press
```python
import numpy as np
from matplotlib.widgets import Button, RadioButtons
import matplotlib.pyplot as plt
import skimage.io

thresh = 0.5
i = 1
def on_press(event):
    global thresh
    global i
    if event.inaxes == None:
        print("none")
        # return
    fig = event.inaxes.figure
    if event.key == 'left':
        thresh -= 0.1
    elif event.key == 'right':
        thresh += 0.1
    elif event.key == 'up':
        thresh += 0.01
    elif event.key == 'down':
        thresh -= 0.01
    elif event.key == '+':
        i += 1
    elif event.key == '-':
        i -= 1
    test_18 = np.load('../drive_seg_result/%02d.npy'%i)
    plt.imshow(test_18[1] > thresh, cmap='gray')
    plt.title('%02d.png'%i)
    print(thresh, event.x, event.key)
    skimage.io.imsave('%02d_seg.png', (test_18[1] > thresh)*255)
    fig.canvas.draw()

if __name__ == "__main__":
    fig = plt.figure()
    fig.canvas.mpl_connect("key_press_event", on_press)
    test_18 = np.load('../drive_seg_result/%02d.npy'%i)
    ax1 = fig.add_subplot(111)
    ax1.imshow(test_18[1], cmap = 'gray')
    plt.show()
```
