--soal 8
>node ulmo
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip
unzip cuaca.zip

service vsftpd start

*pastikan  config : local_enable=YES
lalu restart service 

> node Ulmo
ftp 10.66.1.1
login as ainur:ainur
put cuaca.txt
put mendung.jpg
quit

