#!/bin/bash
#这是一个批量创建虚拟机的脚本
createvhost (){
vhost=$1
echo $vhost
cd /var/lib/libvirt/images  #这个路径针对的环境不一样(存放后端盘的路径)
qemu-img create -b .node_base.qcow2  -f qcow2 ${vhost}.img 
sed "s,node_base,${vhost}," .node_base.xml > /etc/libvirt/qemu/${vhost}.xml #配置文件(路径按实际环境定)
cd /etc/libvirt/qemu
virsh define ${vhost}.xml
virsh start ${vhost}
}
if [ $# =  0 ];then
echo "请输入创建主机名"
else
for i in $* #$* 所有的位置变量
do
  createvhost ${i}
done
fi

