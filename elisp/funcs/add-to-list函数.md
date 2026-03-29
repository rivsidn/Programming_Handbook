
add-to-list is a native-comp-function in ‘subr.el’.

(add-to-list LIST-VAR ELEMENT &optional APPEND COMPARE-FN)

解释.

| 成员        | 解释         | 详细说明                                   |
|-------------|--------------|--------------------------------------------|
| add-to-list | 函数名       | 函数名                                     |
| LIST-VAR    | 参数1        | list变量名                                 |
| ELEMENT     | 参数2        | 添加的元素                                 |
| &optional   | 可选参数标识 | 后边的参数都是可选参数                     |
| APPEND      | 可选参数1    | 是否追加到列表后，如果是nil 加到表头       |
| COMPARE-FN  | 可选参数2    | 判断函数是否在列表内，如果在就不继续添加了 |

Inferred type: (function (t t &optional t t) t)

推断类型，暂时可以不关注。

Add ELEMENT to the value of LIST-VAR if it isn’t there yet.
The test for presence of ELEMENT is done with ‘equal’, or with
COMPARE-FN if that’s non-nil.
If ELEMENT is added, it is added at the beginning of the list,
unless the optional argument APPEND is non-nil, in which case
ELEMENT is added at the end.
LIST-VAR should not refer to a lexical variable.

The return value is the new value of LIST-VAR.

返回新的 LIST-VAR。

This is meant to be used for adding elements to configuration
variables, such as adding a directory to a path variable
like ‘load-path’, but please do not abuse it to construct
arbitrary lists in Elisp code, where using ‘push’ or ‘cl-pushnew’
will get you more efficient code.

If you want to use ‘add-to-list’ on a variable that is not
defined until a certain package is loaded, you should put the
call to ‘add-to-list’ into a hook function that will be run only
after loading the package.  ‘eval-after-load’ provides one way to
do this.  In some cases other hooks, such as major mode hooks,
can do the job.

  Probably introduced at or before Emacs version 19.29.
  This function has a compiler macro ‘add-to-list--anon-cmacro’.  See
    the manual for details.



### 示例程序

  (add-to-list 'my-list "a" nil #'string=)

  ```elisp
  #'string=
  ```
  明确标明是函数，如果没有'#' 通常也可以工作，这里明确标明是函数更规范。


  按参数位置拆开就是：

  - LIST-VAR -> 'my-list
  - ELEMENT -> "a"
  - APPEND -> nil
  - COMPARE-FN -> #'string=

  意思是：

  - 往变量 my-list 的列表里添加 "a"
  - 如果列表里已经有“和 "a" 相等”的元素，就不添加
  - 这里“相等”的判断规则不用默认的 equal，而改用 string=
  - APPEND 是 nil，所以如果要添加，就加到表头

  #'string= 怎么理解？

  它表示“函数 string= 本身”。

  也就是把 string= 这个函数对象，作为参数传给 add-to-list。

  你可以把它理解成：

  - string= 是一个函数，负责比较两个字符串是否相等
  - #'string= 是“引用这个函数”
  - 这里不是立刻自己调用它，而是把它交给 add-to-list
  - 然后 add-to-list 内部在需要比较时再去调用它


