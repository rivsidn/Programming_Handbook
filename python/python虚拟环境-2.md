






## 附录

### pipx 和 pip 有什么区别？


• 核心区别一句话：

  pip 用来安装 Python 包；pipx 用来安装 Python 写的命令行工具。

  pip
  pip 会把包装到“当前 Python 环境”里。

  比如：

  - 系统 Python
  - 你当前激活的虚拟环境
  - 某个指定解释器对应的环境

  这意味着：

  - 适合给项目装依赖，比如 requests、fastapi
  - 也可以装 CLI 工具，但容易和别的包混在一起
  - 在 Ubuntu/Debian 上，直接装到系统 Python 常会碰到你刚才那个 externally-managed-
    environment

  例子：

  pip install requests
  pip install terminal-control-mcp

  pipx
  pipx 会给每个工具单独建一个虚拟环境，然后把可执行命令暴露到你的 PATH 里。

  这意味着：

  - 适合安装“拿来就运行”的命令行工具
  - 不会污染系统 Python
  - 不容易和别的项目依赖冲突
  - 用起来像全局命令，但底层是隔离的

  例子：

  pipx install black
  pipx install terminal-control-mcp

  装完后你可以直接运行：

  terminal-control-mcp

  怎么选

  - 装项目依赖：用 pip
  - 装独立 CLI 工具：用 pipx

  对应你这个场景
  terminal-control-mcp 是一个命令行工具，所以优先建议用 pipx，比 pip 更合适。

  如果你愿意，我可以继续给你画一个很直观的对比图，或者直接告诉你这台机器上该选哪个。



