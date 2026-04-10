

push-mark is a native-comp-function in ‘simple.el’.

(push-mark &optional LOCATION NOMSG ACTIVATE)

Inferred type: (function (&optional t t t) null)

Set mark at LOCATION (point, by default) and push old mark on mark ring.
If the last global mark pushed was not in the current buffer,
also push LOCATION on the global mark ring.
Display ‘Mark set’ unless the optional second arg NOMSG is non-nil.

Novice Emacs Lisp programmers often try to use the mark for the wrong
purposes.  See the documentation of ‘set-mark’ for more information.

In Transient Mark mode, activate mark if optional third arg ACTIVATE non-nil.


| 参数     | 说明                                           |
|----------|------------------------------------------------|
| LOCATION | 设置mark 位置                                  |
| NOMSG    | 是否输出'Mark set' 提示                        |
| ACTIVATE | 是否激活这个mark，高亮显示point、mark 之间区域 |


