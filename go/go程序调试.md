## 安装

```bash
# 设置模块代理
go env -w GOPROXY=https://goproxy.cn,direct
# 安装
go install github.com/go-delve/delve/cmd/dlv@latest
```

## 使用

### 开始调试

```bash
# 开始调试
dlv debug ./cmd/kboot_build_bootfs
```

### 调试命令

| 命令        | 说明     |
|-------------|----------|
| b main.main | 设置断点 |
| c           | 继续执行 |


