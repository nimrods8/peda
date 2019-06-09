define xxd
  if $argc < 2
    set $size = sizeof(*$arg0)
  else
    set $size = $arg1
  end
  dump binary memory dump.bin $arg0 ((void *)$arg0)+$size
  eval "shell xxd -o %d dump.bin; rm dump.bin", ((void *)$arg0)
end
document xxd
  Dump memory with xxd command (keep the address as offset)

  xxd addr [size]
    addr -- expression resolvable as an address
    size -- size (in byte) of memory to dump
            sizeof(*addr) is used by default
end

source ~/peda/peda.py
