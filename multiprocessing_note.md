# Pool
```python
from multiprocessing import Pool
import numpy as np
import time, random

def func(x):
    time.sleep(random.random())
    return x * x

pool = Pool(4)
data = np.arange(25)
print data
res = [pool.apply_async(func, args=(x, )) for x in data]
out = [p.get() for p in res]
print out
```
