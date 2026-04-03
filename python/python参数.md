




## 参数解析

```python
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--name")
args = parser.parse_args()

print(args.name)
```

运行：

```bash
python test.py --name Tom
```


