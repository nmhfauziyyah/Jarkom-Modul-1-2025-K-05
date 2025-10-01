--soal11
> node Melkor
- installation
apt update && apt install openbsd-inetd telnetd -y

- conifg inet
nano /etc/inetd.conf
nyalakan standard service telnet
""telnet  stream  tcp     nowait  root    /usr/sbin/tcpd  /usr/sbin/telnetd""

service openbsd-inetd start

adduser ninimm:ninim

>node Eru
telnet 10.66.1.2 [Prefix]
login as ninim:ninim

Analyze on wirehshark
filter "telnet"
info : Telnet Data..[Malformed Packet]
