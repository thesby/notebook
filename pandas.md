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
```python
df = pd.DataFrame(data={'Area' : ['A']*5 + ['C']*2,'Bins' : [110]*2 + [160]*3 + [40]*2,'Test_0' : [0, 1, 0, 1, 2, 0, 1],'Data' : np.random.randn(7)})
df['Test_1'] = df['Test_0'] - 1
print pd.merge(df, df, left_on=['Bins', 'Area','Test_0'], right_on=['Bins', 'Area','Test_1'],suffixes=('_L','_R'))
```










