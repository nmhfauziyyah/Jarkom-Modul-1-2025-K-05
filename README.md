<img width="814" height="266" alt="Screenshot 2025-09-30 023123" src="https://github.com/user-attachments/assets/402fd5b9-ec7e-4c3e-a3f2-7dfa8010f781" /># Jarkom-Modul-1-2025-K-05

|No|Nama anggota|NRP|
|---|---|---|
|1. | Adiwidya Budi Pratama | 5027241012|
|2. | Ni'mah Fauziyyah Atok | 5027241103|
---
## Soal 1
> Untuk mempersiapkan pembuatan entitas selain mereka, Eru yang berperan sebagai Router membuat dua Switch/Gateway. Dimana Switch 1 akan menuju ke dua Ainur yaitu Melkor dan Manwe. Sedangkan Switch 2 akan menuju ke dua Ainur lainnya yaitu Varda dan Ulmo. Keempat Ainur tersebut diberi perintah oleh Eru untuk menjadi Client.
<img width="1268" height="779" alt="Screenshot 2025-10-04 124446" src="https://github.com/user-attachments/assets/0d579e31-581c-44d6-8e58-7c1d36f71531" />

---
## Soal 2
> Karena menurut Eru pada saat itu Arda (Bumi) masih terisolasi dengan dunia luar, maka buat agar Eru dapat tersambung ke internet.
<img width="1130" height="492" alt="Screenshot 2025-10-04 122608" src="https://github.com/user-attachments/assets/4703fa0f-6f7f-4a0e-b647-cc578149e3d0" />

---
## Soal 3 - 4
> Sekarang pastikan agar setiap Ainur (Client) dapat terhubung satu sama lain.
> Setelah berhasil terhubung, sekarang Eru ingin agar setiap Ainur (Client) dapat mandiri. Oleh karena itu pastikan agar setiap Client dapat tersambung ke internet.
<img width="1078" height="311" alt="Screenshot 2025-10-04 122706" src="https://github.com/user-attachments/assets/ef3b6558-36ba-4b60-9b9d-3471597879c4" />
<img width="1100" height="544" alt="Screenshot 2025-10-04 122845" src="https://github.com/user-attachments/assets/d359e6c1-e6ca-4351-8151-e027dd34ba48" />
<img width="1107" height="311" alt="Screenshot 2025-10-04 122931" src="https://github.com/user-attachments/assets/5c7a9798-72d1-4054-9a34-100132b54380" />
<img width="965" height="194" alt="Screenshot 2025-10-04 124353" src="https://github.com/user-attachments/assets/8e932d36-8be2-4cff-8358-66938eb84f92" />

---
## Soal 5
> Ainur terkuat Melkor tetap berusaha untuk menanamkan kejahatan ke dalam Arda (Bumi). Sebelum terjadi kerusakan, Eru dan para Ainur lainnya meminta agar semua konfigurasi tidak hilang saat semua node di restart.

<img width="1130" height="492" alt="Screenshot 2025-10-04 122608" src="https://github.com/user-attachments/assets/25062362-56f5-4d4e-bcee-997ef0d6354d" />
<img width="1107" height="576" alt="Screenshot 2025-09-29 210214" src="https://github.com/user-attachments/assets/43be6785-682d-4b7d-b709-a5fe641cec4c" />
write this on `/root/.bashrc`

---
## Soal 6
> Setelah semua Ainur terhubung ke internet, Melkor mencoba menyusup ke dalam komunikasi antara Manwe dan Eru. Jalankan file berikut (link file) lalu lakukan packet sniffing menggunakan Wireshark pada koneksi antara Manwe dan Eru, lalu terapkan display filter untuk menampilkan semua paket yang berasal dari atau menuju ke IP Address Manwe. Simpan hasil capture tersebut sebagai bukti.

- in client Manwe
```c
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5" -O traffic.zip

unzip traffic.zip

chmod +x traffic.zip
```
- go to wireshark
start capture > manwe -> eru 
```
./traffic.sh
```
- stop capture
<img width="725" height="218" alt="Screenshot 2025-10-04 130149" src="https://github.com/user-attachments/assets/e747e1fd-5834-4380-a947-b9d3e91147df" />
<img width="1357" height="141" alt="Screenshot 2025-10-04 125750" src="https://github.com/user-attachments/assets/e4b425a5-a81b-4275-ae75-b4d32a682a56" />

---
## Soal 7
> Untuk meningkatkan keamanan, Eru memutuskan untuk membuat sebuah FTP Server di node miliknya. Lakukan konfigurasi FTP Server pada node Eru. Buat dua user baru: ainur dengan hak akses write&read dan melkor tanpa hak akses sama sekali ke direktori shared. Buktikan hasil tersebut dengan membuat file teks sederhana kemudian akses file tersebut menggunakan kedua user.

- in Eru
```c
apt install -y vsftpd
mkdir -p shared
adduser melkor
adduser ainur

apt install -y inetutils-ftp
```
- config di nano /etc/vsftpd.conf
```c
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

// tambahin di akhir
chroot_local_user=YES
allow_writeable_chroot=YES
```
```
ls
service vsftpd start

ftp localhost
input : ainur:ainur
```
```
*Eru
chown ainur:ainur shared/
chmod 700 shared/
cd shared/
```
```
su ainur
touch punyainur.txt
> su melkor
touch coba.txt (denied)
```
<img width="689" height="555" alt="Screenshot 2025-10-04 131552" src="https://github.com/user-attachments/assets/92e0a9de-87b6-4b35-9df3-955a9b52109f" />

---
## Soal 8
> Ulmo, sebagai penjaga perairan, perlu mengirimkan data ramalan cuaca ke node Eru. Lakukan koneksi sebagai client dari node Ulmo ke FTP Server Eru menggunakan user ainur. Upload sebuah file berikut (link file). Analisis proses ini menggunakan Wireshark dan identifikasi perintah FTP yang digunakan untuk proses upload.

- node ulmo
```c
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip
apt update && apt install -y unzip
unzip cuaca.zip
```
- in Eru
```c
service vsftpd start
```
*pastikan  config : local_enable=YES
lalu restart service 

- node Ulmo
```c
ftp 10.66.1.1
login as ainur:ainur
put cuaca.txt
put mendung.jpg
quit
```
<img width="1200" height="599" alt="Screenshot 2025-10-04 133140" src="https://github.com/user-attachments/assets/92a4d2a4-cb2a-40ac-8725-664186723d6d" />

---
## Soal 9
> Eru ingin membagikan "Kitab Penciptaan" di (link file) kepada Manwe. Dari FTP Server Eru, download file tersebut ke node Manwe. Karena Eru merasa Kitab tersebut sangat penting maka ia mengubah akses user ainur menjadi read-only. Gunakan Wireshark untuk memonitor koneksi, identifikasi perintah FTP yang digunakan, dan uji akses user ainur.

- node Eru
```c
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip > /srv/ftp/shared
```
- edit nano /etc/vsftpd.conf
tambahkan "user_config_dir=/etc/vsftpd_user_conf"

- config ftp buat user agar setiap kali ainur login → dia langsung masuk ke /srv/ftp/shared
```
mkdir -p /etc/vsftpd_user_conf
nano /etc/vsftpd_user_conf/ainur
Isi : 
local_root=/srv/ftp/shared
write_enable=NO
download_enable=YES
```
- service vsftpd restart

- Buka node Manwe
```c
ftp 10.66.1.1 > login ainur
switch to binary untuk transfer file
get kitab_penciptaan.txt (berhasil)
put kitab_penciptaan.txt (permission denied)
quit
```
<img width="996" height="491" alt="Screenshot 2025-09-30 225522" src="https://github.com/user-attachments/assets/2bf8aa73-1a05-4bf9-adb6-27969697cdc2" />
<img width="1438" height="305" alt="image" src="https://github.com/user-attachments/assets/6ac3b38c-673a-4413-8c5f-c8acf41b3aa8" />

---
## Soal 10
> Melkor yang marah karena tidak diberi akses, mencoba melakukan serangan dengan mengirimkan banyak sekali request ke server Eru. Gunakan command ping dari node Melkor ke node Eru dengan jumlah paket yang tidak biasa (spam ping misalnya 100 paket). Amati hasilnya, apakah ada packet loss? Catat average round trip time untuk melihat apakah serangan tersebut mempengaruhi kinerja Eru.
- on Wireshark start capture Melkor -> Eru
- node Melkor
```c
ping 10.66.1.1 -c 100
```
- Analyze if theres a packet loss
<img width="892" height="322" alt="Screenshot 2025-09-30 234217" src="https://github.com/user-attachments/assets/6744df8a-b984-4443-8bd2-5782dd9ead67" />

---
## Soal 11
> Sebelum era koneksi aman, Eru sering menyelinap masuk ke wilayah Melkor. Eru perlu masuk ke node tersebut untuk memeriksa konfigurasi, namun ia tahu Melkor mungkin sedang memantau jaringan. Buktikan kelemahan protokol Telnet dengan membuat akun dan password baru di node Melkor kemudian menangkap sesi login Eru ke node Melkor menggunakan Wireshark. Tunjukkan bagaimana username dan password dapat terlihat sebagai plain text.
> node Melkor
- installation
```
apt update && apt install openbsd-inetd telnetd -y
```
- confg inet
```nano /etc/inetd.conf
nyalakan standard service telnet
""telnet  stream  tcp     nowait  root    /usr/sbin/tcpd  /usr/sbin/telnetd""
```
```
service openbsd-inetd start
adduser ninimm:ninim
```
- node Eru
```
telnet 10.66.1.2 [Prefix]
login as ninim:ninim
```
- Analyze on wirehshark
- filter `telnet`
- look for `info : Telnet Data..[Malformed Packet]`
<img width="1229" height="706" alt="Screenshot 2025-10-01 161014" src="https://github.com/user-attachments/assets/b7ca471c-6027-4267-a06b-50a15ffb4a86" />
<img width="1002" height="859" alt="Screenshot 2025-10-01 161643" src="https://github.com/user-attachments/assets/4ed0102c-6f98-4970-bfd2-0fb7df7a82e7" />

---
## Soal 12
> Eru mencurigai Melkor menjalankan beberapa layanan terlarang di node-nya. Lakukan pemindaian port sederhana dari node Eru ke node Melkor menggunakan Netcat (nc) untuk memeriksa port 21, 80, dalam keadaan terbuka dan port rahasia 666 dalam keadaan tertutup.

- in Eru
```
apt update && apt install netcat
```
- in node Melkor
```c
apt install -y iptables

nc -l 21 >/dev/null 2>&1 &
nc -l 80 >/dev/null 2>&1 &
iptables -I INPUT -p tcp --dport 666 -j REJECT
```
- node Eru
nc -zv 10.66.1.2 21 80 666
<img width="904" height="141" alt="Screenshot 2025-10-01 164417" src="https://github.com/user-attachments/assets/4b07e6c6-21ce-4cb3-9631-f8befe4b4f24" />
<img width="843" height="116" alt="Screenshot 2025-10-01 164425" src="https://github.com/user-attachments/assets/de4ca6dd-1bcc-4fe8-8b3f-a1735c5b081d" />

---
## Soal 13
> Setelah insiden penyadapan Telnet, Eru memerintahkan semua koneksi administratif harus menggunakan SSH (Secure Shell) untuk mengamankan jaringan. Lakukan koneksi SSH dari node Varda ke Eru. Tangkap sesi tersebut menggunakan Wireshark. Analisis dan jelaskan mengapa username dan password tidak dapat dilihat seperti pada sesi Telnet. Tunjukkan paket-paket terenkripsi dalam hasil capture sebagai bukti keamanan SSH.

- in Eru
```c
apt update && apt install -y openssh-server
service ssh start
```
```
adduser <test>
psswd <test>
```
- start capture on wireshark

- Node Varda
```c
apt install -y openssh-server
ssh <test>@10.66.1.1
```
- stop capture on wireshark
<img width="1181" height="379" alt="Screenshot 2025-10-04 134752" src="https://github.com/user-attachments/assets/3fb99a15-0e63-46ec-80de-747c89ba56c3" />
<img width="993" height="859" alt="Screenshot 2025-10-01 165654" src="https://github.com/user-attachments/assets/85719d56-f15f-41f7-9ada-be3f69edd38b" />

---
## Soal 14
```c
nc 10.15.43.32 3401
```
#### Pertanyaan A
How many packets are recorded in the pcapng file?
Format: int
##### Penyelesaian
Di bagian bawah Wireshark,ditampilkan berapa banyak paket yang ada di file PCAP tersebut.
![assets/s14a.png](assets/s14a.png)
#### Jawaban
```c
500358
```
- Teori
Wireshark menghitung jumlah paket total dan menampilkannya di bilah status/bagian bawah aplikasinya.
#### Pertanyaan B
What are the user that successfully logged in?
Format: user:pass
##### Penyelesaian 1
Gunakan display filter berikut di Wireshark untuk memfilter paket yang mengandung kata "success"
```c
frame contains "success"
```
![assets/s14b1.png](assets/s14b1.png)
- Teori
Display filter (```frame contains "..."```) mencari teks dalam isi paket; berguna untuk menemukan kata-kata yang muncul di payload (mis. "success", "login", dsb.).
##### Penyelesaian 2
Buka paket tersebut, lalu gunakan menu Follow > TCP Stream untuk melihat isi aliran TCP tersebut secara utuh (berisi data yang dikirim/diterima pada stream itu).
![assets/s14b2.png](assets/s14b2.png)
#### Jawaban
```c
n1enna:y4v4nn4_k3m3nt4r1
```
#### Pertanyaan C
In which stream were the credentials found?
Format: int
##### Penyelesaian 1
Lihat di bagian "Filter" setelah membuka Follow TCP Stream; akan terlihat sesuatu seperti tcp.stream eq [nomor_stream]. Nomor itu menunjukkan ID stream tempat kredensial ditemukan.
#### Jawaban
```c
41824
```
- Teori
Wireshark memberi setiap koneksi TCP yang ter-capture sebuah indeks tcp.stream (0,1,2,...). Ini memudahkan referensi ke seluruh percakapan TCP tertentu. Saat mengikuti TCP stream, filter otomatis (tcp.stream eq N) menunjukkan bahwa paket-paket yang dilihat adalah bagian dari stream bernomor N — jadi mencari nomor stream memberitahu "di aliran mana" informasi itu lewat.
![assets/s14c.png](assets/s14c.png)

#### Pertanyaan D
What tools are used for brute force?
Format: Hydra v1.8.0-dev
##### Penyelesaian 1
Dari "Follow -> TCP Stream" yang sama, dapat mengenali tanda/teks yang menunjukkan tools yang digunakan untuk brute force; dari situ terlihat nama tool yang digunakan.
#### Jawaban
```c
Fuzz Faster U Fool v2.1.0-dev
```
- Teori
Banyak tools otomatis (seperti brute-forcers atau fuzzers) meninggalkan jejak teks atau pola tertentu di payload (mis. string user-agent, banner, atau output tool). Dengan melihat keseluruhan aliran TCP, kamu sering dapat mengenali nama tool atau signature-nya. Contohnya, tool fuzzing/ brute-force sering mengirim pola uji berulang yang mudah terlihat, atau menyertakan baris informasi versi/identitas yang bisa dibaca.
![assets/s14d.png](assets/s14d.png)

### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{Brut3_F0rc3_N7f6C7vdFVA5f8Rn7I7O7g7nS}
```
![assets/all14.png](assets/all14.png)

---
## Soal 15
```c
nc 10.15.43.32 3402
```
#### Pertanyaan A
What device does Melkor use?
Format: string
##### Penyelesaian 1
Cari paket GET DESCRIPTOR Response tipe DEVICE. Perhatikan field yang bernama `iManufacturer, iProduct, atau iSerialNumber`. Dan dari situ, terdapat `iProduct: 2`
yang berarti nilai nama produknya berada pada indeks 2 dari **STRING DESCRIPTOR*** yang dikembalikan oleh response GET DESCRIPTOR.
#### Jawaban
```c
Keyboard
```
- Teori
Pada USB, perangkat memberikan device descriptor dan string descriptors. Field seperti `iProduct/iManufacturer` biasanya berisi indeks (nomor) yang menunjuk ke string descriptor yang berisi teks (mis. "Keyboard", vendor, serial). Untuk mengetahui nama perangkat, kita lihat GET DESCRIPTOR (STRING) pada indeks yang diberikan. Ini berguna saat menganalisis capture USB untuk mengenali tipe perangkat.
#### Pertanyaan B
What did Melkor write?
Format: string
##### Penyelesaian 1
Menggunakan display filter berikut di Wireshark:
```c
usb.transfer_type == 0x01
```
Nilai 0x01 tersebut berasal dari deskripsi perangkat (device description). Filter ini membantu menemukan transfer HID (interrupt/input) yang berisi data yang dikirim oleh perangkat.
![assets/s15a.png](assets/s15a.png)
##### Penyelesaian 2
Simpan hasil capture atau paket yang relevan: File > Export Packet Dissections as Plain Text — sehingga payload hex dapat diekstrak untuk diproses lebih lanjut
##### Penyelesaian 3
Jalankan skrip `hiddata.py`, lalu decode hex yang tersimpan. `hiddata.py` adalah skrip Python yang digunakan untuk menerjemahkan array-byte HID menjadi karakter ASCII. Contoh perintah:
```c
python3 hiddata.py hidpaket.txt > decode.txt
```
![assets/s15b.png](assets/s15b.png)
#### Jawaban
```c
UGx6X3ByMHYxZGVfeTB1cl91czNybjRtZV80bmRfcDRzc3cwcmQ=
```
- Teori 
Perangkat HID (mis. keyboard) mengirim data dalam bentuk report (array byte/hex). Untuk membaca teks yang diketik, kita sering perlu mengekspor payload (hex), lalu menjalankan script/dekoder yang mengonversi scancode/hex menjadi karakter ASCII. Filter transfer type membantu memfokuskan pada paket yang berisi report HID (biasanya interrupt transfer untuk keyboard/mouse).

#### Pertanyaan C
What is Melkor's secret message?
Format: string
##### Penyelesaian 1
Dekode (base64) pesan terenkripsi/ter-encode dari jawaban pertanyaan B. Contoh perintah untuk mendekode base64 di terminal:
```c
echo "UGx6X3ByMHYxZGVfeTB1cl91czNybjRtZV80bmRfcDRzc3cwcmQ=" | base64 --decode
```
![assets/s15c.png](assets/s15c.png)
#### Jawaban
```c
Plz_pr0v1de_y0ur_us3rn4me_4nd_p4ssw0rd
```
- Teori
Base64 sering dipakai untuk meng-encode data teks agar aman dikirim lewat kanal yang berbasis byte/ASCII. Setelah memperoleh string base64 dari hasil decode HID, cukup jalankan base64 decode untuk mendapatkan pesan plaintext. Teknik ini sering ditemui di forensik/analisis jaringan ketika data dikemas untuk dikirim lewat protokol non-tekstual.
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{K3yb0ard_W4rr10r_BRxsRQ8etjElDYMOJBbksIR0d}
```
![assets/all15.png](assets/all15.png)

---

## Soal 16
```c
nc 10.15.43.32 3403
```
#### Pertanyaan A
What credential did the attacker use to log in?
Format: user:pass
##### Penyelesaian 1
Gunakan display filter berikut di Wireshark untuk menampilkan perintah FTP USER dan PASS:
```c
ftp.request.command== "USER" || ftp.request.command == "PASS"
```
![assets/s16a.png](assets/s16a.png)
#### Jawaban
```c
ind@psg420.com:{6r_6e#TfT1p
```
- Teori
Perintah FTP USER dan PASS digunakan untuk mengirimkan username dan password ke server. Dengan memfilter keduanya, kita bisa mengekstrak kredensial yang dikirimkan dalam sesi FTP (jika tidak terenkripsi). Ini biasa dipakai dalam forensik jaringan untuk menemukan akun yang digunakan oleh penyerang.
#### Pertanyaan B
How many files are suspected of containing malware?
Format: int
##### Penyelesaian
Klik Follow > TCP Stream untuk melihat keseluruhan percakapan TCP dari sesi FTP tersebut. Dari sana terlihat adanya file bernama q.exe, w.exe, e.exe, r.exe, dan t.exe — yang diduga berisi malware.
![assets/s16c.png](assets/s16c.png)
#### Jawaban
```c
5
```
- Teori
Dengan mengikuti TCP stream, Wireshark menyatukan semua paket yang membentuk satu koneksi sehingga kita bisa melihat transfer data (mis. daftar file yang dikirim melalui FTP). Ini memudahkan menghitung berapa file yang diunggah/diunduh atau memeriksa isi transfer.
#### Pertanyaan C
What is the hash of the first file (q.exe)?
Format: sha256
##### Penyelesaian 1
Gunakan display filter berikut :
```c
_ws.col.info == "FTP Data: 1274 bytes (PASV) (SIZE q.exe)"
```
Isi dari “Follow -> TCP Stream”, tampilannya seperti ini
![assets/s16d1.png](assets/s16d1.png)
##### Penyelesaian 2
Klik Follow -> TCP Stream -> Save as raw, beri nama file q16
##### Penyelesaian 3
Hitung hash SHA-256 dari file q16 menggunakan command:
```c
sha256sum q16
```
#### Jawaban
```c
ca34b0926cdc3242bbfad1c4a0b42cc2750d90db9a272d92cfb6cb7034d2a3bd
```
![assets/s16d2.png](assets/s16d2.png)

#### Pertanyaan D
What is the hash of the first file (w.exe)?
Format: sha256
##### Penyelesaian 1
Gunakan display filter berikut :
```c
_ws.col.info == "FTP Data: 1274 bytes (PASV) (SIZE w.exe)"
```
Isi dari “Follow -> TCP Stream”, tampilannya seperti ini
![assets/s16e1.png](assets/s16e1.png)
##### Penyelesaian 2
Klik Follow -> TCP Stream -> Save as raw, beri nama file w16
##### Penyelesaian 3
Hitung hash SHA-256 dari file w16 menggunakan command:
```c
sha256sum w16
```
#### Jawaban
```c
08eb941447078ef2c6ad8d91bb2f52256c09657ecd3d5344023edccf7291e9fc
```
![assets/s16e2.png](assets/s16e2.png)

#### Pertanyaan E
What is the hash of the first file (e.exe)?
Format: sha256
##### Penyelesaian 1
Gunakan display filter berikut :
```c
_ws.col.info == "FTP Data: 1274 bytes (PASV) (SIZE e.exe)"
```
Isi dari “Follow -> TCP Stream”, tampilannya seperti ini
![assets/s16f1.png](assets/s16f2.png)
##### Penyelesaian 2
Klik Follow -> TCP Stream -> Save as raw, beri nama file e16
##### Penyelesaian 3
Hitung hash SHA-256 dari file e16 menggunakan command:
```c
sha256sum e16
```
#### Jawaban
```c
32e1b3732cd779af1bf7730d0ec8a7a87a084319f6a0870dc7362a15ddbd3199
```
![assets/s16f2.png](assets/s16f2.png)

#### Pertanyaan F
What is the hash of the first file (r.exe)?
Format: sha256
##### Penyelesaian 1
Gunakan display filter berikut :
```c
_ws.col.info == "FTP Data: 1274 bytes (PASV) (SIZE r.exe)"
```
Isi dari “Follow -> TCP Stream”, tampilannya seperti ini
![assets/s16g1.png](assets/s16g1.png)
##### Penyelesaian 2
FKlik Follow -> TCP Stream -> Save as raw, beri nama file r16
##### Penyelesaian 3
Hitung hash SHA-256 dari file r16 menggunakan command:
```c
sha256sum r16
```
#### Jawaban
```c
4ebd58007ee933a0a8348aee2922904a7110b7fb6a316b1c7fb2c6677e613884
```
![assets/s16g2.png](assets/s16g2.png)

#### Pertanyaan G
What is the hash of the first file (t.exe)?
Format: sha256
##### Penyelesaian 1
Gunakan display filter berikut :
```c
_ws.col.info == "FTP Data: 1274 bytes (PASV) (SIZE t.exe)"
```
Isi dari “Follow -> TCP Stream”, tampilannya seperti ini
![assets/s16h1.png](assets/s16h1.png)
##### Penyelesaian 2
Klik Follow -> TCP Stream -> Save as raw, beri nama file t16
##### Penyelesaian 3
Hitung hash SHA-256 dari file t16 menggunakan command:
```c
sha256sum t16
```
#### Jawaban
```c
10ce4b79180a2ddd924fdc95951d968191af2ee3b7dfc96dd6a5714dbeae613a
```
![assets/s16h2.png](assets/s16h2.png)

##### Teori Jawaban Pertanyaan C sampai G
- Saat FTP mentransfer file dalam mode aktif atau pasif, isi file muncul sebagai payload pada paket TCP/FTP. Wireshark menampilkan ringkasan di kolom Info (mis. FTP Data: <size> bytes (PASV) (SIZE filename)), sehingga kita dapat langsung menemukan paket yang membawa data file tertentu.
- Follow TCP Stream mengumpulkan semua segmen TCP yang membentuk file tersebut dan memungkinkan kita mengekspor data mentah (raw) tanpa header-protokol — cocok untuk menyimpan ulang sebagai file biner.
- Menghitung SHA-256 pada file mentah memberikan fingerprint kriptografis yang stabil dan dapat digunakan untuk: pemeriksaan integritas, pencarian di layanan reputasi/malware feed, atau bukti di laporan forensik.
- Karena pola langkah (filter → follow stream → save raw → hitung hash) sama untuk tiap file, proses ini dapat diulang (loop) untuk semua file yang ditemukan (q.exe, w.exe, e.exe, r.exe, t.exe).
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{Y0u_4r3_4_g00d_4nalyz3r_iDYON1mAHIfDzG2S49awKOBRm}
```
![assets/all16.png](assets/all16.png)

---

## Soal 17
```c
nc 10.15.43.32 3404
```
#### Pertanyaan A
What is the name of the first suspicious file?
Format: file.exe
##### Penyelesaian 1
Pilih File > Export Objects > HTTP di Wireshark.
##### Penyelesaian 2
Kemudian akan muncul daftar objek HTTP yang diekspor — ada 3 file, termasuk `Invoice&MSO-Request.doc`.
![assets/s17a.png](assets/s17a.png)
#### Jawaban
```c
Invoice&MSO-Request.doc
```
- Teori
HTTP sering digunakan untuk mengirim/mentransfer file (mis. dokumen, executable) lewat jaringan. Wireshark dapat mengekstrak objek/berkas yang lewat HTTP lewat menu Export Objects > HTTP, sehingga kita dapat menyimpan kembali file-file tersebut untuk analisis statis (mis. scanning antivirus, hashing, atau membuka konten dokumen). Ini berguna untuk menemukan artefak berbahaya yang diunduh lewat web.
#### Pertanyaan B
What is the name of the second suspicious file?
Format: file.exe
##### Penyelesaian 1
Gunakan langkah yang sama seperti pada pertanyaan sebelumnya (File > Export Objects > HTTP). Di sana akan terlihat 3 file termasuk knr.exe.
![assets/s17b.png](assets/s17b.png)
#### Jawaban
```c
knr.exe
```
- Teori
Metode ekstraksi objek HTTP memungkinkan peneliti untuk mengambil file-file biner yang dikirim lewat protokol HTTP. Setelah diekspor, file executable seperti knr.exe bisa dianalisis lebih lanjut — mis. dengan hashing, pemeriksaan string, atau analisis statis/dinamis — untuk menentukan apakah file tersebut berbahaya.

#### Pertanyaan C
What is the hash of the second suspicious file (knr.exe)?
Format: sha256
##### Penyelesaian 1
Pilih File > Export Objects > HTTP → simpan knr.exe.
##### Penyelesaian 2
Hitung hash SHA-256 dari file yang telah disimpan dengan perintah:
```c
sha256sum knr.exe
```
![assets/s17c.png](assets/s17c.png)
#### Jawaban
```c
749e161661290e8a2d190b1a66469744127bc25bf46e5d0c6f2e835f4b92db18
```
- Teori 
Menghitung SHA-256 menghasilkan fingerprint kriptografis unik untuk sebuah file. Hash digunakan untuk: memastikan integritas file (apakah file sama dengan versi lain), mencocokkan file ke database malware feed/IOC, dan sebagai bukti dalam laporan forensik. Proses umum: ekstrak objek (dari HTTP), simpan sebagai file lokal, lalu jalankan sha256sum atau alat sejenis untuk memperoleh nilai hash.
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{M4ster_4n4lyzer_1xcg3WUUjKpux80gm8tEdFgL0}
```
![assets/all17.png](assets/all17.png)

---

## Soal 18
```c
nc 10.15.43.32 3405
```
#### Pertanyaan A
How many files are suspected of containing malware?
Format: int
##### Penyelesaian 1
Pilih File > Export Objects > SMB di Wireshark.
##### Penyelesaian 2
Jika kita melihat file-file yang diekspor, ada 2 file yang namanya dimulai dengan %5cWINDOWS%5c... (yaitu path yang di-URL-encode menuju \WINDOWS\...).
![assets/s18a.png](assets/s18a.png)
#### Jawaban
```c
2
```
- Teori
SMB (Server Message Block) adalah protokol berbagi file/print yang sering dipakai pada jaringan Windows. Wireshark dapat mengekstrak objek/file yang lewat SMB melalui menu Export Objects > SMB. File yang berisi path seperti %5cWINDOWS%5c... biasanya menunjukkan file yang ditulis atau diambil dari folder Windows pada mesin target — ini patut dicurigai bila muncul dalam konteks serangan/malware. Mengetahui jumlah file berbahaya membantu menilai skala kompromi.
#### Pertanyaan B
What is the name of the first malicious file?
Format: file.exe
##### Penyelesaian 1
Perhatikan kedua file .exe yang ditemukan pada jawaban Pertanyaan A; nama file pertama adalah salah satunya (lihat daftar SMB yang diekspor).
#### Jawaban
```c
d0p2nc6ka3f_fixhohlycj4ovqfcy_smchzo_ub83urjpphrwahjwhv_o5c0fvf6.exe
```
- Teori
Setelah mengekspor objek SMB, periksa nama-nama file yang muncul. File dengan nama acak/panjang dan yang ditempatkan di direktori Windows sering menandakan malware atau dropper yang disamarkan. Mengekspor file memungkinkan analisis lebih lanjut seperti penghitungan hash, scanning antivirus, atau analisis statis/dinamis.
#### Pertanyaan C
Apa nama file berbahaya yang kedua?
Format: file.exe
##### Penyelesaian 1
Lihat kedua file tersebut dan jawaban untuk file kedua dapat ditemukan di sana (nama file kedua tercantum pada daftar SMB yang diekspor).
#### Jawaban
```c
oiku9bu68cxqenfmcsos2aek6t07_guuisgxhllixv8dx2eemqddnhyh46l8n_di.exe
```
#### Pertanyaan D
What is the hash of the first malicious file?
Format: sha256
##### Penyelesaian 1
Hitung hash SHA-256 dari file pertama (yang disimpan/di-ekspor), menggunakan perintah:
```c
sha256sum 18b.exe
```
![assets/s18d.png](assets/s18d.png)
#### Jawaban
```c
59896ae5f3edcb999243c7bfdc0b17eb7fe28f3a66259d797386ea470c010040
```

#### Pertanyaan E
What is the hash of the second malicious file?
Format: sha256
##### Penyelesaian 1
Hitung hash SHA-256 dari file kedua dengan cara yang sama, misal:
```c
sha256sum 18b.exe
```
![assets/s18e.png](assets/s18e.png)
#### Jawaban
```c
cf99990bee6c378cbf56239b3cc88276eec348d82740f84e9d5c343751f82560
```
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{Y0u_4re_g0dl1ke_e8XQLgCWiRzzsqZm9XqENF6bY}
```
![assets/all18.png](assets/all18.png)

---

## Soal 19
```c
nc 10.15.43.32 3406
```
#### Pertanyaan A
Who sent the threatening message?
Format: string (name)
##### Penyelesaian 1
Lihat protokol SMTP (Simple Mail Transfer Protocol) karena itulah protokol yang digunakan untuk mengirim dan menerima email — lakukan itu dengan mengeklik kolom/label "Protocol" pada Wireshark untuk memfilter paket SMTP.
##### Penyelesaian 2
Gunakan Follow > TCP Stream untuk melihat keseluruhan isi percakapan SMTP (isi email) dalam satu tampilan. Dari sana kita dapat membaca pengirim/isi pesan yang mengancam.
![assets/s19a.png](assets/s19a.png)
#### Jawaban
```c
Your Life
```
- Teori
SMTP adalah protokol pengiriman email; saat traffic email tidak terenkripsi (atau hanya sebagian), payload (header & body) bisa terlihat jelas di capture.

#### Pertanyaan B
How much ransom did the attacker demand ($)?
Format: int
##### Penyelesaian 1
Dengan cara yang sama seperti pertanyaan sebelumnya (melihat isi email via SMTP dan Follow TCP Stream), kita cukup membaca konten email untuk menemukan jumlah tebusan yang diminta.
![assets/s19b.png](assets/s19b.png)
#### Jawaban
```c
1600
```
- Teori
Informasi seperti jumlah tebusan biasanya tercantum secara eksplisit di badan email. Dalam forensik jaringan, mengekstrak body email dari capture membantu menentukan tuntutan, alamat kontak, atau instruksi pembayaran. Jika email terenkripsi (mis. TLS) maka pendekatan lain diperlukan (mis. akses server/endpoint).

#### Pertanyaan C
What is the attacker's bitcoin wallet?
Format: string
##### Penyelesaian 1
Dengan cara yang sama seperti sebelumnya — baca isi email melalui hasil Follow TCP Stream — kita dapat menemukan alamat dompet Bitcoin pelaku yang biasanya ditulis langsung di pesan.
![assets/s19c.png](assets/s19c.png)
#### Jawaban
```c
1CWHmuF8dHt7HBGx5RKKLgg9QA2GmE3UyL
```
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{Y0u_4re_J4rk0m_G0d_uYgq9qyc7cdrJ2F5gyBt0otqK}
```
![assets/all19.png](assets/all19.png)

---

## Soal 20
```c
nc 10.15.43.32 3407
```
#### Pertanyaan A
What encryption method is used?
Format: string
##### Penyelesaian 1
Identifikasi protokol dulu; menggunakan TLS.
##### Penyelesaian 2
Gunakan display filter berikut di Wireshark:
```c
tls.handshake.type == 2
```
Filter ini mencari Server Hello (handshake type 2), yaitu paket saat server memilih versi TLS dan satu-satunya cipher suite yang dipakai untuk sesi, dan juga mengembalikan informasi selected key_share.
![assets/s20a.png](assets/s20a.png)
#### Jawaban
```c
TLS
```
- Teori 
TLS (Transport Layer Security) adalah protokol kriptografi yang melindungi komunikasi jaringan (pengganti SSL). Pada fase handshake, klien dan server menyepakati versi TLS, cipher suite, dan mekanisme pertukaran kunci (key exchange). `tls.handshake.type == 2` merujuk ke Server Hello — paket penting karena mengungkap pilihan protokol/cipher server. Jika capture memiliki keylog (pre-master secrets), Wireshark bisa mendekripsi lalu lintas TLS untuk melihat payload (jika disiapkan).

#### Pertanyaan B
What is the name of the malicious file placed by the attacker?
Format: file.exe
##### Penyelesaian 1
Dari folder yang disediakan oleh asisten, kita juga mendapatkan keylogs.txt. Buka Wireshark → Preferences → Protocols → TLS → klik Browse dan masukkan keylogs.txt. (Ini memungkinkan Wireshark menggunakan keylog untuk mendekripsi sesi TLS yang terekam.)
![assets/s20b1.png](assets/s20b1.png)
##### Penyelesaian 2
gunakan display filter:
```c
http.response.code == 200
```
untuk mencari respons HTTP yang sukses. Gunakan Follow > TCP Stream pada aliran yang relevan; dari sana terlihat bahwa pada hasil HTTP GET terdapat file bernama `invest_20.dll.`
![assets/s20b2.png](assets/s20b2.png)
#### Jawaban
```c
invest_20.dll
```
- Teori
1. Keylog (keylogs.txt): file ini (biasanya berformat NSS/SSLKEYLOGFILE) berisi kunci yang memungkinkan Wireshark mendekripsi sesi TLS pada capture—sangat membantu untuk melihat konten yang seharusnya terenkripsi.
2. Setelah dekripsi aktif, gunakan filter HTTP (mis. `http.response.code == 200`) untuk menemukan transfer file yang sukses. Follow TCP Stream menyatukan percakapan sehingga kita dapat melihat isi HTTP (header & body) dan menemukan nama file yang diunduh (`invest_20.dll`).

#### Pertanyaan C
What is the hash of the file containing the malware?
Format: sha256
##### Penyelesaian 1
Setelah file disimpan (dari langkah pada pertanyaan sebelumnya), hitung SHA-256 dari file tersebut dengan perintah:
```c
sha256sum invest_20.dll
```
![assets/s20c.png](assets/s20c.png)
#### Jawaban
```c
31cf42b2a7c5c558f44cfc67684cc344c17d4946d3a1e0b2cecb8eb58173cb2f
```
### Flag
Jika semua pertanyaan terjawab dengan benar, akan muncul FLAG.
```c
Congratulations! Here is your flag: KOMJAR25{B3ware_0f_M4lw4re_Q1lBjLY0oJ3rCllqfcUS8GO4a}
```
![assets/all20.png](assets/all20.png)
