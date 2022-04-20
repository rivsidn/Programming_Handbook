> The following is a brief description of the shell’s operation when it reads and executes a
> command. Basically, the shell does the following:
> 1. Reads its input from a file (see Section 3.8 [Shell Scripts], page 42), from a string
> supplied as an argument to the -c invocation option (see Section 6.1 [Invoking Bash],
> page 87), or from the user’s terminal.
> 2. Breaks the input into words and operators, obeying the quoting rules described in
> Section 3.1.2 [Quoting], page 6. These tokens are separated by metacharacters. Alias
> expansion is performed by this step (see Section 6.6 [Aliases], page 95).
> 3. Parses the tokens into simple and compound commands (see Section 3.2 [Shell Com-
> mands], page 8).
> 4. Performs the various shell expansions (see Section 3.5 [Shell Expansions], page 22),
> breaking the expanded tokens into lists of filenames (see Section 3.5.8 [Filename Ex-
> pansion], page 33) and commands and arguments.
> 5. Performs any necessary redirections (see Section 3.6 [Redirections], page 35) and re-
> moves the redirection operators and their operands from the argument list.
> 6. Executes the command (see Section 3.7 [Executing Commands], page 39).
> 7. Optionally waits for the command to complete and collects its exit status (see
> Section 3.7.5 [Exit Status], page 41).



1. 获取输入
2. 按照引用规则，将输入分解成词或者运算符，符号被元字符分割；别名展开是在这步执行的
3. 将符号解析成简单命令、复合命令
4. 执行shell 展开
5. 执行重定向操作，从参数列表中移除重定向运算符和操作数
6. 执行命令
7. 等待命令结束，获取退出状态

