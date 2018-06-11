# pandas

## learning materials
http://manishamde.github.io/blog/2013/03/07/pandas-and-python-top-10/

http://tomaugspurger.github.io/modern-1-intro

## settings of pandas
https://pandas.pydata.org/pandas-docs/stable/options.html#frequently-used-options
```python
import pandas as pd
pd.set_option('display.width', 140)  # the width of dispaly, default is 80.
```

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

## groupby
```python
import pandas as pd
import numpy as np
df = pd.DataFrame(columns=['name', 'day', 'money'])
df['name'] = ['Tim', 'Lily', 'Lily', 'Bob', 'Bob', 'Bob']
df['day'] = [1, 1, 2, 1, 2, 3]
df['money'] = [100, 100, 200, 300, 400, 500]
print df

df_group = df.groupby(['name'])
print df_group.groups
print df_group.groups['Bob']
# operate group
print df_group.apply(np.max)
# design func
def GroupMeanMoney(x):
    day = np.min(x['day'])
    money = np.mean(x['money'])
    name = np.min(x['name'])
    return pd.Series([name, day, money], index=['name', 'day', 'money'])
print df_group.apply(GroupMeanMoney)
```
Process groups with joblib or multiprocessing to accelerate
https://stackoverflow.com/questions/26187759/parallelize-apply-after-pandas-groupby
```python
#coding=utf-8
import pandas as pd
import numpy as np
from multiprocessing import Pool

def process_group(group):
    # group: ['id',  'pv'] 
    return pd.Series([group[0], np.sum(group[1].pv)], index=['id', 'pv'])

if __name__ == '__main__':
    data = pd.DataFrame([[1, 2], [1, 3], [1, 4], [2, 3], [2, 5], [4, 1]], columns=['id', 'pv'])
    print data
    data_group = data.groupby('id')
    pool = Pool(2)
    data_process = pool.map(process_group, data_group)
    print pd.DataFrame(data_process)
```

## Drop / Insert 
```python
import pandas as pd
import numpy as np
df = pd.DataFrame(columns=['name', 'day', 'money'])
df['name'] = ['Tim', 'Lily', 'Lily', 'Bob', 'Bob', 'Bob']
df['day'] = [1, 1, 2, 1, 2, 3]
df['money'] = [100, 100, 200, 300, 400, 500]

# insert a new column
df['remark'] = ['lost', 'book', 'meat', 'lost', 'breakfast', 'don`t know']
print df
df.insert(0, 'remark2', ['lost', 'book', 'meat', 'lost', 'breakfast', 'don`t know'])

# insert a new row
print df.append([dict(name='Jobs', day=1, money=1000, remark='apple')])
print df.append(df.loc[0])
print df.loc[0]

# drop data
data_dropped = df.drop(['remark2'], axis=1)
```

## Merge
Merge: Append two DataFrame with overlapping index. Similar as the 'Join' of SQL

### Merge by index
```python
import pandas as pd
import numpy as np
rng = pd.date_range('2017-11-11', periods=6)  # rng = pd.date_range('2017-11-11', '2017-11-15')
df1 = pd.DataFrame(np.random.randn(6, 3), index=rng, columns=list('ABC'))
df2 = pd.DataFrame(np.random.randn(6, 3), index=rng, columns=list('DEF'))
print pd.merge(df1, df2, left_index=True, right_index=True)
```
how : {‘left’, ‘right’, ‘outer’, ‘inner’}, default ‘inner’
* left: use only keys from left frame, similar to a SQL left outer join; preserve key order
* right: use only keys from right frame, similar to a SQL right outer join; preserve key order
* outer: use union of keys from both frames, similar to a SQL full outer join; sort keys lexicographically
* inner: use intersection of keys from both frames, similar to a SQL inner join; preserve the order of the left keys

### Merge by column
```python
# reference: http://pandas.pydata.org/pandas-docs/stable/merging.html
df = pd.DataFrame(data={'Area' : ['A']*5 + ['C']*2,'Bins' : [110]*2 + [160]*3 + [40]*2,'Test_0' : [0, 1, 0, 1, 2, 0, 1],'Data' : np.random.randn(7)})
df['Test_1'] = df['Test_0'] - 1
print pd.merge(df, df, left_on=['Bins', 'Area','Test_0'], right_on=['Bins', 'Area','Test_1'],suffixes=('_L','_R'), indicator=True)
```

## Sort DataFrame
```
 df.sort_index(axis=1, ascending=False)
 df.sort_values(by='B')
```

# Histogram
```
pd.Series(np.random.randint(0, 7, size=10))
s.value_counts()
```

# Get max index of each group
```
df = pd.DataFrame({'animal': 'cat dog cat fish dog cat cat'.split(),
    'size': list('SSMMMLL'),
    'weight': [8, 10, 11, 1, 20, 12, 12],
    'adult' : [False]*5 + [True]*2})
df.groupby('animal').apply(lambda subf: subf['size'][subf['weight'].idxmax()])
```

# string operation
```
s = pd.Series(['A', 'B', 'C', 'Aaba', 'Baca', np.nan, 'CABA', 'dog', 'cat'])
s.str.lower()
s.str.len()
s[s.str.len() > 1]
```



