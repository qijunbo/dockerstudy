ip=`/sbin/ip addr show ens33|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
#ip=`/sbin/ip addr show eth0|grep "inet "|grep -v 127.0.0.1|awk '{print $2}'`
port=`docker port wordpressapp`
echo "http://${ip%/*}:${port#*:}"
echo "http://${ip%/*}:${port#*:}/wp-admin"
