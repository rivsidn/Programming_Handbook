
## 测试文件

### 配置文件

可以设置根目录.

## 测试函数


  包 -> 模块 -> 类 -> 函数


## 附录

### AI

#### 多层级执行流程

• 可以。这个问题最关键的一点是：

  - 包 -> 模块 -> 类 -> 函数 更像是 pytest 的“收集树”
  - 真正被执行的是最底层的“测试项”，也就是测试函数/测试方法
  - 每个测试项执行时，都会经历 setup -> call -> teardown 三个阶段

  你可以先记住一句话：

  - 执行时通常是“从外到内做准备”，再“从内到外做清理”

  也就是：

  包级准备 -> 模块级准备 -> 类级准备 -> 函数级准备
  -> 执行测试函数
  -> 函数级清理 -> 类级清理 -> 模块级清理 -> 包级清理

  不过要注意一个细节：

  - pytest 里没有常用的 setup_package()/teardown_package() 这一套
  - 包级通常是通过 scope="package" 的 fixture 来实现
  - 模块/类/函数这几层，既可以用 fixture，也可以用 setup_module/setup_class/setup_method

  下面我用一个完整例子说明。

  示例目录

  为了体现“包 -> 模块 -> 类 -> 函数”，先假设目录是这样：

  tests/
  ├── __init__.py
  ├── conftest.py
  └── test_device.py

  这里：

  - tests/ 是一个包，因为有 __init__.py
  - test_device.py 是模块
  - TestCLI 是类
  - test_show_version / test_show_buildsvn 是函数（更准确说是测试方法）

  示例代码

  tests/conftest.py

  import pytest

  @pytest.fixture(scope="package", autouse=True)
  def pkg_env():
      print("\n[package setup]")
      yield
      print("\n[package teardown]")

  tests/test_device.py

  def setup_module(module):
      print("\n[module setup]")

  def teardown_module(module):
      print("\n[module teardown]")


  class TestCLI:
      @classmethod
      def setup_class(cls):
          print("\n[class setup]")

      @classmethod
      def teardown_class(cls):
          print("\n[class teardown]")

      # 方法执行前调用
      def setup_method(self, method):
          print(f"\n[function setup] {method.__name__}")

      # 方法执行后调用
      def teardown_method(self, method):
          print(f"\n[function teardown] {method.__name__}")

      def test_show_version(self):
          print("\nrun test_show_version")
          assert True

      def test_show_buildsvn(self):
          print("\nrun test_show_buildsvn")
          assert True

  运行：

  pytest -s -vv

  这里 -s 是为了让 print 直接显示出来。

  执行顺序是什么

  如果当前只跑这一个模块，执行顺序大致就是：

  [package setup]
  [module setup]
  [class setup]

  [function setup] test_show_version
  run test_show_version
  [function teardown] test_show_version

  [function setup] test_show_buildsvn
  run test_show_buildsvn
  [function teardown] test_show_buildsvn

  [class teardown]
  [module teardown]
  [package teardown]

  这就是最典型的执行顺序：

  - 包级只进一次
  - 模块级只进一次
  - 类级只进一次
  - 函数级每个测试方法都会进一次

  怎么理解这个顺序

  你可以把它想成“套娃”：

  - 包把模块包住
  - 模块把类包住
  - 类把函数包住

  所以执行一个测试方法时，必须先把外层环境准备好：

  1. 先准备包环境
  2. 再准备模块环境
  3. 再准备类环境
  4. 再准备函数环境
  5. 执行测试函数
  6. 然后先清理函数环境
  7. 再清理类环境
  8. 再清理模块环境
  9. 最后清理包环境

  这其实就是典型的：

  - setup：外 -> 内
  - teardown：内 -> 外

  但为什么类级/模块级不会在每个函数后都销毁？

  因为它们有“作用域”概念。

  比如上面有两个测试方法：

  - test_show_version
  - test_show_buildsvn

  它们都属于同一个类 TestCLI

  所以：

  - setup_class 只会在这个类的第一个测试方法执行前跑一次
  - teardown_class 只会在这个类的最后一个测试方法执行完后跑一次

  同理：

  - setup_module 只会在这个模块第一次进入时跑一次
  - teardown_module 只会在模块里最后一个测试结束后跑一次

  所以你会看到：

  - 函数级 setup/teardown 最频繁
  - 类级次之
  - 模块级更少
  - 包级最少

  如果有两个类，会怎么执行？

  假设 test_device.py 里还有第二个类：

  class TestConfig:
      @classmethod
      def setup_class(cls):
          print("\n[class setup] TestConfig")

      @classmethod
      def teardown_class(cls):
          print("\n[class teardown] TestConfig")

      def test_save(self):
          print("\nrun test_save")
          assert True

  那顺序会更像这样：

  [package setup]
  [module setup]

  [class setup] TestCLI
    [function setup] test_show_version
    run test_show_version
    [function teardown] test_show_version
    [function setup] test_show_buildsvn
    run test_show_buildsvn
    [function teardown] test_show_buildsvn
  [class teardown] TestCLI

  [class setup] TestConfig
    run test_save
  [class teardown] TestConfig

  [module teardown]
  [package teardown]

  也就是说：

  - 类和类之间是顺序执行的
  - 模块环境在两个类之间不会销毁
  - 因为它们还在同一个模块里

  如果有两个模块，会怎么执行？

  假设 tests/ 下面还有另一个文件 test_system.py。

  那么一般可以这样理解：

  - 包级环境在整个包里第一次测试开始前建立
  - 第一个模块跑完后，模块级环境会清理
  - 第二个模块开始时，再建立第二个模块的模块级环境
  - 包级环境要等整个包里的最后一个测试结束后才清理

  也就是：

  [package setup]

    [module1 setup]
      ... module1 tests ...
    [module1 teardown]

    [module2 setup]
      ... module2 tests ...
    [module2 teardown]

  [package teardown]

  再强调一个很重要的点

  pytest 不是先“执行包”，再“执行模块”，再“执行类”。

  更准确的说法是：

  - pytest 先收集出叶子节点，也就是每一个测试函数/方法
  - 然后按顺序逐个执行这些测试项
  - 对每个测试项，在执行前准备它所需要的外层上下文
  - 在作用域结束时再清理

  所以：

  - 包/模块/类 更多是“容器”
  - 函数/方法 才是“真正执行的测试项”

  如果改用 fixture 来写，原理一样吗？

  一样，甚至更标准。

  例如：

  import pytest

  @pytest.fixture(scope="module", autouse=True)
  def mod_env():
      print("\n[module fixture setup]")
      yield
      print("\n[module fixture teardown]")

  @pytest.fixture(scope="function", autouse=True)
  def func_env():
      print("\n[function fixture setup]")
      yield
      print("\n[function fixture teardown]")

  class TestCLI:
      def test_a(self):
          print("\nrun test_a")

      def test_b(self):
          print("\nrun test_b")

  执行顺序还是同一个原则：

  - 先 setup 外层 scope
  - 再 setup 内层 scope
  - 跑测试
  - teardown 从内往外

  官方文档里明确写到 fixture 的作用域有：

  - function
  - class
  - module
  - package
  - session

  而且 fixture 是“第一次被请求时创建，在对应作用域结束时销毁”。
  这也是为什么高作用域 fixture 会被复用。

  实际工作里怎么选

  我建议你这样理解：

  - 如果你只是想快速理解层级顺序：
      - 看 setup_module / setup_class / setup_method
  - 如果你想写正式项目：
      - 优先学 fixture

  因为 fixture 更强，尤其适合：

  - SSH 连接
  - 数据准备
  - 临时文件
  - 登录/清理
  - 多设备共享资源

  比如你的网络设备测试里：

  - package/module：建立公共配置或公共测试环境
  - class：一组设备场景共用一个连接或前置状态
  - function：每条测试命令前后的独立准备和清理

  一句话总结

  对于 包 -> 模块 -> 类 -> 函数 这条链，pytest 执行时的核心规律是：

  - 收集时：把它组织成树
  - 执行时：按“测试函数/方法”逐条执行
  - setup 顺序：从外到内
  - teardown 顺序：从内到外
  - 作用域越大，复用时间越长，执行次数越少

  官方资料

  - Fixture 作用域与生命周期：https://docs.pytest.org/en/stable/explanation/fixtures.html
  - xunit 风格 setup/teardown：https://docs.pytest.org/en/7.3.x/how-to/xunit_setup.html
  - collection tree / node 概念：https://docs.pytest.org/en/stable/reference.html

  如果你愿意，我下一条可以继续给你画一个更贴近你场景的例子：

  1. pytest + scrapli 下，SSH 连接放在 module 级和 function 级分别会怎么执行
  2. 用一张“时间线图”把 package -> module -> class -> function 执行顺序画出来

  你回我 1 或 2 就行。



#### › 给我解释一下pytest 的工作原理

• 可以。你可以把 pytest 的工作原理理解成一句话：

  - pytest 本质上是一个“测试发现器 + 执行器 + 报告器”

  它干的事情大致是：

  - 找到哪些测试要跑
  - 准备运行环境
  - 执行测试函数
  - 判断通过还是失败
  - 输出结果和失败原因

  如果你想真正理解它，最重要的是看它从你输入 pytest 到最后出结果，中间到底发生了什么。

  整体流程

  当你在命令行执行：

  pytest

  pytest 大致会经过这几步：

  - 读取配置
  - 确定项目根目录 rootdir
  - 搜索测试文件
  - 收集测试项
  - 准备 fixture
  - 执行测试
  - 记录结果
  - 输出报告

  你可以把它想成一条流水线：

  命令行参数
   -> 读取配置
   -> 收集测试
   -> 构建执行计划
   -> 运行 setup
   -> 运行测试函数
   -> 运行 teardown
   -> 汇总报告

  1. 测试发现：它先找“有哪些测试”

  这是你之前碰到 collected 0 items 的关键原因。

  pytest 默认只会收集符合规则的文件和函数，比如：

  - 文件名：test_*.py
  - 文件名：*_test.py
  - 函数名：test_xxx
  - 类名一般也会按 TestXxx 这类规则收集

  比如：

  # test_demo.py
  def test_add():
      assert 1 + 1 == 2

  这个会被收集。

  但你之前的文件叫 pytest.py，所以默认不会被当成测试文件。

  这一步通常叫：

  - collection，也就是“收集测试项”

  2. 导入测试文件：它会把你的测试模块加载进来

  找到测试文件后，pytest 会导入这些 Python 文件。

  比如它发现了：

  - test_demo.py

  它就会把这个文件当成 Python 模块导入。

  在导入过程中，pytest 会做两件很重要的事：

  - 收集里面符合规则的测试函数/测试类
  - 对 assert 做特殊处理

  这里顺便解释一个核心点：

  3. assert 为什么能显示那么详细的失败信息

  普通 Python 里，assert a == b 失败时，信息很普通。
  但 pytest 里失败信息往往很详细，比如会告诉你：

  - 左边值是什么
  - 右边值是什么
  - 哪部分不一样

  这是因为 pytest 在导入测试模块时，会做：

  - assertion rewriting，也就是“断言重写”

  你可以简单理解成：

  - pytest 在加载你的测试代码时，不是傻乎乎地直接执行
  - 它会先改造 assert 相关代码
  - 这样当断言失败时，它就能拿到更多上下文并生成详细报错

  所以 pytest 的 assert 体验比原生 assert 好很多。

  4. 构建测试树：它把测试组织成节点

  在 pytest 内部，测试不是一坨代码直接跑，而是会构造成一棵“测试节点树”。

  大致可以理解成：

  - Session
  - Package
  - Module
  - Class
  - Function

  例如：

  Session
   └─ test_demo.py
       └─ test_add

  每个测试函数最终会变成一个“测试项”，也就是：

  - test item

  后面执行时，pytest 就是逐个执行这些 item。

  5. fixture 解析：运行前先准备依赖

  这是 pytest 最核心的机制之一。

  比如你写：

  import pytest

  @pytest.fixture
  def data():
      return 123

  def test_example(data):
      assert data == 123

  这里测试函数 test_example(data) 里有个参数 data。
  pytest 会做的事情不是“随便传个参数”，而是：

  - 发现 test_example 依赖一个叫 data 的 fixture
  - 找到这个 fixture 定义
  - 先执行 fixture
  - 把返回值注入给测试函数

  所以 fixture 的本质是：

  - 一种“按名字注入依赖”的机制

  对网络自动化来说非常重要，因为你可以这样写：

  @pytest.fixture
  def conn():
      c = connect_device()
      yield c
      c.close()

  def test_show_version(conn):
      output = conn.send_command("show version")
      assert output

  这里 pytest 会自动：

  - 先建立 SSH 连接
  - 把连接对象传给测试
  - 测试结束后再自动关闭连接

  这就是它的“依赖注入 + 生命周期管理”能力。

  6. fixture 为什么能自动清理

  因为 pytest 会把每个测试分成 3 个阶段：

  - setup
  - call
  - teardown

  对应到 fixture 上就是：

  - setup：执行 yield 前面的内容
  - call：真正执行测试函数
  - teardown：执行 yield 后面的清理逻辑

  例如：

  @pytest.fixture
  def conn():
      print("连接设备")
      c = "ssh_connection"
      yield c
      print("关闭连接")

  运行顺序是：

  setup: 连接设备
  call: 执行 test_xxx(conn)
  teardown: 关闭连接

  所以你不需要手动写很多 try/finally。

  7. 参数化：它会把一条测试拆成多条来跑

  比如：

  import pytest

  @pytest.mark.parametrize("x, expected", [
      (1, 2),
      (2, 3),
      (3, 4),
  ])
  def test_func(x, expected):
      assert x + 1 == expected

  pytest 不会把它当成“一条测试”。

  它会在收集阶段把它展开成多条测试项，类似：

  - test_func[1-2]
  - test_func[2-3]
  - test_func[3-4]

  所以参数化的本质是：

  - 在收集阶段动态生成更多测试用例

  这也是为什么 pytest 特别适合：

  - 同一条测试跑多台设备
  - 同一条命令跑多个输入
  - 同一逻辑跑多个场景

  8. 执行阶段：逐个运行测试项

  到了真正执行时，pytest 会按顺序跑每个测试项。

  每个测试项又是三阶段：

  - setup
  - call
  - teardown

  举个例子：

  def test_answer():
      assert func(3) == 4

  实际流程是：

  - setup：准备这个测试需要的 fixture
  - call：执行 test_answer()
  - teardown：清理资源

  如果测试函数里抛异常，或者断言失败：

  - pytest 会记录这个测试失败
  - 然后继续跑其他测试，除非你加了 -x 这类参数让它遇错即停

  9. conftest.py 为什么很重要

  conftest.py 是 pytest 的一个特殊文件。

  它的作用通常是：

  - 放公共 fixture
  - 放 hook
  - 放一些测试配置逻辑

  pytest 在收集测试时，会沿目录层级自动查找 conftest.py，并把其中定义的 fixture 提供给当前目录及子目录的测试使用。

  所以它非常适合放：

  - SSH 登录连接
  - 测试设备信息
  - 通用前置初始化
  - 命令行参数处理

  比如：

  # conftest.py
  import pytest

  @pytest.fixture
  def conn():
      return "my_conn"

  那么 tests/ 下的测试文件就可以直接写：

  def test_xxx(conn):
      assert conn == "my_conn"

  不用 import conn。

  10. 插件机制：为什么 pytest 这么强

  pytest 的扩展能力很强，是因为它不是把所有功能都写死在核心里，而是用了插件系统。

  它底层依赖：

  - pluggy

  你可以简单理解成：

  - pytest 在很多关键节点都暴露了“钩子”
  - 插件可以在这些钩子上插入自己的逻辑

  比如插件可以做：

  - 并行执行测试
  - 生成 HTML 报告
  - 统计覆盖率
  - 支持异步测试
  - 增加新的命令行参数
  - 修改收集规则

  这也是为什么 pytest 很适合工程化项目。

  11. 标记和筛选：不是所有测试都会跑

  收集到测试后，pytest 还会按你的命令行参数过滤。

  例如：

  - -k "buildsvn"：按名称表达式筛选
  - -m smoke：按 marker 筛选
  - 指定文件路径：只跑某个文件
  - 指定某个测试节点：只跑某个函数

  所以“收集到的测试”和“最终执行的测试”不是完全一回事。

  举例：

  pytest -m smoke

  即使项目里有 100 条测试，可能最后只执行打了 smoke 标记的 10 条。

  12. 最终报告：为什么你能看到 passed/failed/skipped

  每条测试执行完后，pytest 都会得到一个结果状态，比如：

  - passed
  - failed
  - skipped
  - xfailed
  - xpassed
  - error

  然后它把这些汇总成最终报告。

  例如：

  collected 3 items

  test_demo.py ..F

  =================== FAILURES ===================
  ...
  ================= 2 passed, 1 failed =================

  所以终端里的输出，其实是整个执行模型的汇总结果。

  把它和你现在的例子连起来看

  你之前这个文件：

  def func(x):
      return x+1

  def test_answer():
      assert func(3) == 5

  如果文件名改成 test_demo.py，pytest 的工作流程就是：

  - 发现 test_demo.py
  - 导入这个模块
  - 收集到 test_answer
  - 重写里面的 assert
  - 执行 test_answer
  - 调用 func(3) 得到 4
  - 比较 4 == 5
  - 断言失败
  - 输出失败报告

  如果文件名还是 pytest.py，流程就变成：

  - 扫描目录
  - 没发现符合规则的测试文件
  - collected 0 items

  你可以把 pytest 的工作原理记成 5 个关键词

  - 发现：找到测试
  - 收集：构建测试项
  - 注入：fixture 注入依赖
  - 执行：setup/call/teardown
  - 报告：汇总结果

  一个更贴近直觉的比喻

  你可以把 pytest 想成一个“考试系统”：

  - 它先去题库里找题目：测试发现
  - 把每道题整理成考试清单：测试收集
  - 给每道题准备草稿纸和工具：fixture
  - 一题一题作答：执行测试
  - 最后统计分数并打印错题：报告输出

  为什么它特别适合自动化测试

  因为它不只是“执行 Python 函数”，它真正强的地方是：

  - 自动收集
  - 依赖注入
  - 生命周期管理
  - 参数化展开
  - 断言增强
  - 丰富插件生态

  这些组合起来，才让它变成一个强大的测试框架。

  如果你愿意，我下一条可以继续给你讲两个更实用的方向之一：

  1. pytest 内部是怎么处理 fixture 的依赖关系的
  2. pytest 从命令行到执行一条测试的完整流程图


