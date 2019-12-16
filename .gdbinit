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

#start remote gdb
target remote localhost:6666

#*** deal silently with SIGNAL 33 using by Android's libc ***
handle SIG33 pass nostop noprint

#b Java_com_squareup_cardreader_lcr_AudioBackendNativeJNI_initialize_1backend_1audio
#b Java_com_squareup_cardreader_lcr_SystemFeatureNativeJNI_system_1initialize
#b Java_com_squareup_cardreader_lcr_AudioBackendNativeJNI_cr_1comms_1backend_1audio_1alloc
#b Java_com_squareup_cardreader_lcr_AudioBackendNativeJNI_decode_1r4_1packet

#set the dynamic $base
#printing a variable places it into $x where x is incrementing. So the first time
#we do 'print' the value of the variable goes into $1
p Java_com_squareup_cardreader_lcr_AudioBackendNativeJNI_initialize_1backend_1audio

#then take the address of the relocatable function and subtract the absolute address from it
#to get the delta. Place that delta into 'dynamic'
dynamic $1-0x313780

p $base


