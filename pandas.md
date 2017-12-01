# pandas

## index DataFrame
```python
import pandas as pd
import numpy as np

df = pd.DataFrame({ 'A' : 1.,'B' : pd.date_range('20171122', '20171125'),'C' : pd.Series(1,index=list(range(4)),dtype='float32'),
  'D' : np.array([3]*4,dtype='int32'),'E' : pd.Categorical(["test","train","test","train"]), 'F' : 'foo' })
print df.index
df = df.set_index('B')
print df.index
df = df.reset_index()  # reset index

# index row by label
print df.loc['2017-11-22']

# index row by int index
print df.iloc[0]

# index column by label
print df.A
print df['A']

# index column by index
print df.iloc[:, 2]

# index by range
print df.loc['2017-11-22':'2017-11-24', 'C':'F']

df3 = pd.DataFrame(np.arange(42).reshape([6, 7]), columns=list('ABCDEFG'))
print df3
# index by condition
print df3[(df3.A%2 == 0) & (df3.C == 2)]
print df3[(df3.A%2 == 0) & (df3.C == 2)][['A', 'C', 'F']]

# change date type
df3 = df3.astype({'A': np.int64, 'B':np.int32, 'C':np.int8})

# rename column or index
df4 = df3.rename(columns={'A': 'Alpha'})
#chang inplace
df3.rename(index={0:'Zero'},columns={'A': 'Alpha'}, inplace=True)
```


