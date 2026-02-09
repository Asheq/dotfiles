- scope = global
    1. global value

- scope = buf
    1. local value
    2. global value = used to _initialize_ buffer-local values for _new_ buffers

- scope = win
    1. local value = local to window and _local a specific buffer in that window_
    2. global value = local to window and _global to all buffers in that window_

- scope = (buf | win) + global
    1. local value = ???
    2. global value
