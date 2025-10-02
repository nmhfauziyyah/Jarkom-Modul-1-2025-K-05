# Jarkom-Modul-1-2025-K-05

|No|Nama anggota|NRP|
|---|---|---|
|1. | Adiwidya Budi Pratama | 5027241012|
|2. | Ni'mah Fauziyyah Atok | 5027241103|
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
