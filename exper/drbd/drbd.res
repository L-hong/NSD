resource  r1 {   #这个r1是定义资源的名字
  protocol C;
  on  nfs-0001 {                 #on开头，后面是主机名称
    device    /dev/drbd0;        #drbd设备名称
    disk      /dev/vdb;          #drbd0使用的磁盘分区为sdb1
    address   192.168.1.107:7789; #设置drbd监听地址与端口
    meta-disk internal;
  }
  on  nfs-0002 {
    device    /dev/drbd0;
    disk      /dev/vdb;
    address   192.168.1.108:7789;
    meta-disk internal;
  }
}
