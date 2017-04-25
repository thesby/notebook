## moviepy: create a movie from the sequence images
```python
from moviepy.editor import ImageSequenceClip
from skimage.color import gray2rgb
# assume 1024 gray images.
clip = ImageSequenceClip([gray2rgb(io.imread('gen/images/%02d.png'%i, as_grey=False)) for i in range(1024)], fps=4, with_mask=False)
clip.write_videofile('01.mp4')
```
