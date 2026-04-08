




## 附录

### AI

#### a b 这两种赋值方式有什么不同

 (let ((a "string")
        (b 'string))
    (message "a %s b %s" a b))

  a b 这两种赋值方式有什么不同


• 区别在于：a 绑定的是字符串对象，b 绑定的是符号对象。

  你的代码里：

  (let ((a "string")
        (b 'string))
    (message "a %s b %s" a b))

  含义分别是：

  - a 的值是字符串 "string"
  - b 的值是符号 string

  这里的关键是：

  - "string" 是字符串字面量，它求值后还是它自己
  - 'string 等价于 (quote string)，表示“不要把 string 当变量去求值，而是直接把这个符号本身拿来”

  所以它们的类型不同：

  (stringp a)  ; => t
  (symbolp a)  ; => nil

  (stringp b)  ; => nil
  (symbolp b)  ; => t

  虽然你这里 message 用 %s 打印时，看起来可能都像 string，但本质不是同一个东西。你可以用 %S 看得更清楚：

  (let ((a "string")
        (b 'string))
    (message "a=%S b=%S" a b))

  大致会看到：

  a="string" b=string

  再补一层理解：

  - 字符串：常用于文本内容
  - 符号：常用于变量名、函数名、标识符、枚举值

  例如：

  (symbol-name 'string) ; => "string"

  说明符号 string 也有名字 "string"，但它本身不是字符串。

  你这段代码里，如果写成：

  (let ((b string)) ...)

  那就不是“符号 string”，而是“去取变量 string 的值”；如果这个变量没定义，就会报错。
