#!/bin/bash
CPUTIME=$(ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}')
CPUCORES=$(cat /proc/cpuinfo | grep -c processor)
echo "
System Summary (collected `date`)
 
 - CPU Usage (average)       = `echo $CPUTIME / $CPUCORES | bc`
 - Memory free (real)        = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}`
 - Memory free (cache)       = `free -m | head -n 3 | tail -n 1 | awk {'print $3'}`
 - Swap in use               = `free -m | tail -n 1 | awk {'print $3'}`
 - System Uptime             =`uptime`
 - Private IP                = `ip a | grep 'inet ' |grep -v 'inet 127' | awk {'print $2'}`
 - Public IP                 = `dig +short myip.opendns.com @resolver1.opendns.com`
 - Disk Space Used           = `df -h / | tail -n1 | awk {'printf "%s/%s %s (%s Free)", $3, $2, $5, $4'}`
 
" > /etc/motd

echo "
 |_   _.  _ |   _ |  _.  _ |_  
 |_) (_| (_ |< _> | (_| _> | | 
      _     _ _|_  _  ._ _   _ 
     _> \/ _>  |_ (/_ | | | _> 
        /                      

+------------------------------------------------------------------------+
| Unauthorized access to this system is forbidden and will be prosecuted |
| by law. By accessing this system, you agree that your actions may be   |
| monitored if unauthorized usage is suspected.                          |
+------------------------------------------------------------------------+

This is `hostname` (`uname -s -m -r`) `date +%H:%M:%S`

" > /etc/issue
