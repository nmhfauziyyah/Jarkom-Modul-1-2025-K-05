--soal12
>in Eru
apt update && apt install netcat

>in node Melkor
apt install -y iptables

nc -l 21 >/dev/null 2>&1 &
nc -l 80 >/dev/null 2>&1 &
iptables -I INPUT -p tcp --dport 666 -j REJECT

>node Eru
nc -zv 10.66.1.2 21 80 666

