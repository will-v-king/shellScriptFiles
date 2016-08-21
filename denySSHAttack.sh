#refer to http://www.yuanyueping.cn/linux_system/system_security/security-2-78.html
# Use /etc/hosts.deny to deny ssh attack
cat /var/log/denySSHAttack.log > /var/log/denySSHAttack.log1
date >> /var/log/denySSHAttack.log
#echo "\(Failed password for\)"
cat /var/log/auth.log | grep "\(Failed password for\)" | awk '{ print $(NF-3)}' | sort -n | uniq -c | awk '{ print $1"="$2}' | sort -nr > /var/log/denySSHAttack.log
#cat /var/log/auth.log | grep "\(Failed password for\)" | awk '{ print $(NF-3)}' | sort -n | uniq -c
#echo "\(Invalid user transfer\)"
cat /var/log/auth.log | grep "\(Invalid user transfer\)" | awk '{ print $(NF-0)}' | sort -n | uniq -c | awk '{ print $1"="$2}' | sort -nr >> /var/log/denySSHAttack.log
#cat /var/log/auth.log | grep "\(Invalid user transfer\)" | awk '{ print $(NF-0)}' | sort -n | uniq -c
#sed -i /65.243.142.192$/d /var/log/denySSHAttack.log
ipaddr=$(cat /var/log/denySSHAttack.log | awk -F= '{ print $2"="$1 }' | sort -n | sed /^65.243.142.192/d);
for i in ${ipaddr[*]} ; do
»···IP=`echo $i |awk -F= '{ print $1 }'`;
»···NUM=`echo $i | awk -F= '{ print $2 }'`;
»···if [ $NUM -ge 20 ];
»···then  
»···»···grep $IP /etc/hosts.deny > /dev/null;
»···»···if [ $? -gt 0 ];
»···»···then
»···»···»···echo "sshd:$IP" >> /etc/hosts.deny;
»···»···fi;
»···fi;
done
