
## 安装

```bash
sudo apt install python3-pytest
```

## 示例

### 源码示例

```python
def func(x):
    return x+1

def test_answer():
    assert func(3) == 4
```

### 执行

```bash
yuchao@yuchao:~/demo/python/pytest$ pytest -q
.                                      [100%]
1 passed in 0.00s
```


