--soal 7

apt install -y vsftpd
mkdir -p shared
adduser melkor
adduser ainur

apt install -y inetutils-ftp

config nya nano /etc/vsftpd.conf

listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.user_list
userlist_deny=YES

>> tambahin di akhir
chroot_local_user=YES
allow_writeable_chroot=YES

ls
service vsftpd start

ftp localhost
input : ainur:ainur

*Eru
chown ainur:ainur shared/
chmod 700 shared/
cd shared/

> su ainur
touch punyainur.txt

>su melkor
touch coba.txt (denied)

