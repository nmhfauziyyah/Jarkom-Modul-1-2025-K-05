--soal 9

wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip > /srv/ftp/shared

>> edit nano /etc/vsftpd.conf
tambahkan "user_config_dir=/etc/vsftpd_user_conf"

- config ftp buat user agar setiap kali ainur login → dia langsung masuk ke /srv/ftp/shared

mkdir -p /etc/vsftpd_user_conf
nano /etc/vsftpd_user_conf/ainur
Isi : 
local_root=/srv/ftp/shared
write_enable=NO
download_enable=YES

> service vsftpd restart

Buka node Manwe
ftp 10.66.1.1 > login ainur
switch to binary untuk transfer file
get kitab_penciptaan.txt (berhasil)
put kitab_penciptaan.txt (permission denied)
quit
