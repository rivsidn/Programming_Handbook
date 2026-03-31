
## 文档说明

define-key is a primitive-function in ‘C source code’.

(define-key KEYMAP KEY DEF &optional REMOVE)

| 成员       | 说明                   |
|------------|------------------------|
| define-key | 函数名                 |
| KEYMAP     | 映射表                 |
| KEY        | 摁键                   |
| DEF        | 功能，也就是绑定的函数 |
| &optional  | 后边是可选的           |
| REMOVE     | 是否删除当前映射的内容 |


In KEYMAP, define key sequence KEY as DEF.
This is a legacy function; see ‘keymap-set’ for the recommended
function to use instead.

新代码更推荐'keymap-set'.

KEYMAP is a keymap.

KEY is a string or a vector of symbols and characters, representing a
sequence of keystrokes and events.  Non-ASCII characters with codes
above 127 (such as ISO Latin-1) can be represented by vectors.
Two types of vector have special meanings:
 [remap COMMAND] remaps any key binding for COMMAND.
 [t] creates a default definition, which applies to any event with no
    other definition in KEYMAP.

DEF is anything that can be a key’s definition:
 nil (means key is undefined in this keymap),
 a command (a Lisp function suitable for interactive calling),
 a string (treated as a keyboard macro),
 a keymap (to define a prefix key),
 a symbol (when the key is looked up, the symbol will stand for its
    function definition, which should at that time be one of the above,
    or another symbol whose function definition is used, etc.),
 a cons (STRING . DEFN), meaning that DEFN is the definition
    (DEFN should be a valid definition in its own right) and
    STRING is the menu item name (which is used only if the containing
    keymap has been created with a menu name, see ‘make-keymap’),
 or a cons (MAP . CHAR), meaning use definition of CHAR in keymap MAP,
 or an extended menu item definition.
 (See info node ‘(elisp)Extended Menu Items’.)

If REMOVE is non-nil, the definition will be removed.  This is almost
the same as setting the definition to nil, but makes a difference if
the KEYMAP has a parent, and KEY is shadowing the same binding in the
parent.  With REMOVE, subsequent lookups will return the binding in
the parent, and with a nil DEF, the lookups will return nil.

删除之后可以继承父keymap 的内容.

If KEYMAP is a sparse keymap with a binding for KEY, the existing
binding is altered.  If there is no binding for KEY, the new pair
binding KEY to DEF is added at the front of KEYMAP.

  Probably introduced at or before Emacs version 13.


## 举例示例

### 

```lisp
(define-key global-map (kbd "C-c a") #'beginning-of-line)
```

