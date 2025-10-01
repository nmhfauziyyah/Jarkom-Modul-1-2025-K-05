--soal 2
> edit network conifguration server (Eru)
auto eth0
iface eth0 inet dhcp

Ketik **`iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.66.0.0/16`** pada router `Eru`
echo nameserver 192.168.122.1 > /etc/resolv.conf

--soal 3
> edit network configuration client (Melkor, Manwe, Varda, Ulmo)
- Eru
  ```
  auto eth0
  iface eth0 inet dhcp

  auto eth1
  iface eth1 inet static
  	address 10.66.1.1
  	netmask 255.255.255.0

  auto eth2
  iface eth2 inet static
  	address 10.66.2.1
  	netmask 255.255.255.0
  ```
  - Melkor
  ```
  auto eth0
  iface eth0 inet static
  	address 10.66.1.2
  	netmask 255.255.255.0
  	gateway 10.66.1.1
  ```
  - Manwe
  ```
  auto eth0
  iface eth0 inet static
  	address 10.66.1.3
  	netmask 255.255.255.0
  	gateway 10.66.1.1
  ```
  - Varda
  ```
  auto eth0
  iface eth0 inet static
  	address 10.66.2.2
  	netmask 255.255.255.0
  	gateway 10.66.2.1
  ```
  - Ulmo
  ```
  auto eth0
  iface eth0 inet static
  	address 10.66.2.3
  	netmask 255.255.255.0
  	gateway 10.66.2.1
  ```

--soal4
> di client (Melkor, Manwe, Varda, Ulmo)
echo nameserver 192.168.122.1 > /etc/resolv.conf

--soal5
>simpan semua config di /root/.bashrc

> CLI CONFIGS

> Eru
```
apt update
apt install -y iptables
apt install -y wget
apt install -y unzip
apt install -y vsftpd
apt install -y netcat-traditional
apt install -y ftp
apt install -y telnet
apt install -y openssh-server	
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.66.0.0/16
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

> clients
```
apt update
apt-get install -y wget
apt-get install -y unzip
apt-get install -y vsftpd
apt-get install -y netcat-traditional
apt-get install -y ftp
apt-get install -y openbsd-inetd telnetd
apt-get install -y telnet
apt-get install -y apache2
apt-get install -y openssh-server
echo nameserver 192.168.122.1 > /etc/resolv.conf
```