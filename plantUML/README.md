


## 附录

### TODO

- 这种图怎么画
  ```
  struct array_cache {
    unsigned int avail
    unsigned int limit
    unsigned int batchcount
    unsigned int touched
  }

  struct kmem_cache_s {
    struct array_cache	*array[NR_CPUS]
  }
  ```


