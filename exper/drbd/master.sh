#!/bin/bash
VIP="192.168.1.109"
read local_role peer_role <<<$(drbdadm status|awk -F: '{if($1~/ role/)print $2}')
case "$1" in
    start)
        if [[ "${local_role}" == "Secondary" ]] && [[ "${peer_role}" != "Primary" ]];then
            drbdadm primary r1
            mount -t xfs /dev/drbd0 /var/webroot
        fi
        ;;
    stop)
        umount /var/webroot
        drbdadm secondary r1
        ;;
    check)
        df|grep -q drbd
        STATUS=$?
        if [[ "${local_role}" == "Secondary" ]] && [[ "${peer_role}" != "Primary" ]];then 
           $0 start
        else
           ip -o a s dev eth0|grep -q "${VIP}" || STATUS=0
        fi
        ;;
    *)
        echo "Usage: $0 [start|stop|check]"
        ;;
esac

exit ${STATUS:-1}
