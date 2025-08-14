


支持三种注释模式.

- bash模 式单行注释

  ```dot
  # 这是一条注释

  digraph {
  	rankdir=LR
    A -> B  
  }
  ```

- C 模式单行注释

  ```dot
  // 这是一条注释
  digraph {
  	rankdir=LR
    A -> B  
  }
  ```

- C 模式多行注释

  ```dot
  /*
   * 这是一条
   * 多行注释
   */
  
  digraph {
  	rankdir=LR
    A -> B  
  }
  ```

