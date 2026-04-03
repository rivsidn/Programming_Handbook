




## 附录

### 学习步骤

• 可以，下面我按“入门 -> 常用 -> 实战”给你整理一套 pytest 学习资料，尽量都用官方文档，适合你自己系统学一下。

  先给结论

  如果你是为了写“SSH 连设备、执行命令、保存输出、做断言”这类自动化测试，pytest 最值得先学的 6 个点是：

  - assert
  - fixture
  - parametrize
  - mark
  - 输出/日志捕获
  - conftest.py

  你把这几个学会，已经能写出很像样的网络设备自动化测试了。

  推荐学习顺序

  - 第 1 步：先看官方入门
      - Get started
      - 目标：知道怎么安装、怎么写第一个测试、怎么运行
      - 链接：https://docs.pytest.org/en/stable/
  - 第 2 步：学断言
      - assert 是 pytest 的基础
      - 目标：学会普通断言、异常断言、近似值比较
      - 链接：https://docs.pytest.org/en/stable/how-to/assert.html
  - 第 3 步：重点学 fixture
      - 这是最关键的内容
      - 目标：学会测试前准备/测试后清理、资源复用、作用域
      - 对你尤其重要，因为 SSH 连接通常就是用 fixture 管理
      - 链接：https://docs.pytest.org/en/stable/how-to/fixtures.html
  - 第 4 步：学参数化
      - 目标：一套测试逻辑跑多组数据
      - 很适合“同一条命令跑多台设备”
      - 链接：https://docs.pytest.org/en/stable/how-to/parametrize.html
  - 第 5 步：学标记和筛选
      - 目标：区分 smoke、slow、network、destructive
      - 运行时用 -m 按类型筛选测试
      - 链接：https://docs.pytest.org/en/stable/how-to/mark.html
  - 第 6 步：学输出和日志捕获
      - 目标：测试失败时更容易定位问题
      - 对 CLI/SSH 自动化特别有用
      - 输出捕获：https://docs.pytest.org/en/stable/how-to/capture-stdout-stderr.html
      - 日志管理：https://docs.pytest.org/en/stable/how-to/logging.html

  你这个场景最该看的几篇

  如果你是为了网络设备自动化，我建议优先读这几篇，按顺序来：

  - pytest 首页 / 入门
      - https://docs.pytest.org/en/stable/
  - fixtures
      - https://docs.pytest.org/en/stable/how-to/fixtures.html
  - parametrize
      - https://docs.pytest.org/en/stable/how-to/parametrize.html
  - mark
      - https://docs.pytest.org/en/stable/how-to/mark.html
  - assert
      - https://docs.pytest.org/en/stable/how-to/assert.html
  - 输出捕获
      - https://docs.pytest.org/en/stable/how-to/capture-stdout-stderr.html
  - 日志捕获
      - https://docs.pytest.org/en/stable/how-to/logging.html

  学完这些，你就已经能写：

  - 登录设备
  - 执行命令
  - 保存输出
  - 对输出做断言
  - 把不同命令/设备做参数化
  - 把测试分类并接 CI

  进阶资料

  学完上面那些后，再看这些会比较顺：

  - monkeypatch
      - 用来改环境变量、替换对象、mock 外部依赖
      - 链接：https://docs.pytest.org/en/stable/how-to/monkeypatch.html
  - tmp_path
      - 用来处理临时文件、输出文件、测试产物
      - 你做“保存命令输出到文件”时很有用
      - 链接：https://docs.pytest.org/en/stable/how-to/tmp_path.html
  - unittest 兼容
      - 如果你以后会看别人老项目，可能会遇到
      - 链接：https://docs.pytest.org/en/stable/how-to/unittest.html
  - 项目实践建议
      - 官方的 good practices，很值得看
      - 包括目录组织、安装方式、一些推荐习惯
      - 链接：https://docs.pytest.org/en/stable/explanation/goodpractices.html
  - 完整文档目录
      - 方便以后查资料
      - 链接：https://docs.pytest.org/en/stable/contents.html
  - API Reference
      - 不适合最开始看，但后面查参数很方便
      - 链接：https://docs.pytest.org/en/stable/reference.html

  我建议你的学习路线

  如果你想高效一点，可以按这个节奏：

  - 第一天
      - 入门
      - assert
      - 跑通 3 个最简单测试
  - 第二天
      - fixture
      - 写一个“连接设备”的 fixture
      - 学会 yield 清理连接
  - 第三天
      - parametrize
      - 把命令列表、设备列表都参数化
  - 第四天
      - mark
      - 输出捕获 / 日志捕获
      - 学会 -m smoke、-s、日志查看
  - 第五天
      - tmp_path
      - 把命令输出保存到文件
      - 完成一个小实战

  非常适合你的练手题

  你可以按这个顺序练：

  - 练习 1：测试一个普通 Python 函数
  - 练习 2：写一个 fixture，返回一个对象
  - 练习 3：把 3 条命令参数化执行
  - 练习 4：把结果保存到文件，并断言文件存在
  - 练习 5：加 marker，比如 @pytest.mark.network
  - 练习 6：把 SSH 连接写进 conftest.py

  一个最小入门例子

  # test_demo.py
  import pytest

  @pytest.mark.parametrize("a,b,expected", [
      (1, 2, 3),
      (2, 3, 5),
  ])
  def test_add(a, b, expected):
      assert a + b == expected

  运行：

  pytest -q

  这个小例子里你已经接触到：

  - 测试发现
  - assert
  - 参数化

  如果你学的是“网络设备测试”，重点理解这几个概念

  - conftest.py
      - 放公共 fixture
  - fixture
      - 管 SSH 连接
  - parametrize
      - 跑多设备 / 多命令
  - mark
      - 区分只读测试和危险测试
  - tmp_path / 文件操作
      - 保存命令输出
  - logging / capture
      - 调试失败现场

  额外一个很方便的资料

  官方还提供完整 PDF 版文档，适合你离线看：

  - https://docs.pytest.org/_/downloads/en/stable/pdf/

  如果你不想一上来啃英文文档，我建议这样学

  - 先看官方首页和 Get started
  - 然后我可以给你写一套中文的 pytest 学习笔记
  - 每一节配一个小例子，专门按“网络设备 SSH 测试”场景来讲

  如果你愿意，我下一条可以直接给你整理一份：

  1. pytest 中文入门提纲
  2. 结合网络设备场景的 pytest 练习题
  3. 一个从 0 到 1 的 pytest + scrapli 教学示例

  你回我数字就行，我直接继续写。

