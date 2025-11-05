**Pertanyaan Tugas 7**

 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

 **Jawaban Tugas 7**
 1. Widget tree pada flutter adalah representasi logis dari seluruh user interface dalam widget. Widget tree akan diproses pada saat proses identifikasi layout dan akan digunakan ketika me-render data frame ke screen. Hubungan parent-child parent sebagai widget yang membungkus widget lain. Parent bertanggung jawab untuk mengonfigurasi dan menentukan posisi child widgetnya. Contohnya adalah dalam code saya, Column adalah parent dari SizedBox, Text, dan GridView.

 2. Widget yang saya gunakan ada 4, yaitu MyHomePage, ItemCard, MyApp dan InfoCard. Fungsi dari masing-masing widget ini adalah:
    a. MyApp: Adalah root widget dari aplikasi. Fungsinya adalah menginisialisasi aplikasi dengan MaterialApp, mengatur tema global (seperti primarySwatch berwarna biru), dan menentukan home (halaman utama) aplikasi, yaitu MyHomePage.

    b. MyHomePage: Berfungsi sebagai halaman utama aplikasi. Widget ini menggunakan Scaffold untuk menyediakan struktur dasar (seperti AppBar dan body). Di dalam body, ia menampilkan judul FutShop, teks sambutan, dan sebuah GridView yang berisi tiga ItemCard.

    c. ItemCard: Berfungsi sebagai template (widget reusable) untuk menampilkan satu item di dalam GridView. Setiap ItemCard menerima objek ItemHomepage (yang berisi nama, ikon, dan warna). Widget ini menggunakan InkWell untuk mendeteksi click dan menampilkan SnackBar saat ditekan.

    d. InfoCard: Ini adalah widget reusable yang kamu buat untuk menampilkan judul dan konten dalam sebuah Card

3. Fungsi dari widget MaterialApp adalah membungkus fungsionalitas yang dibutuhkan untuk sebuah aplikasi bergaya Material Design. Widget ini harus berada di puncak (atau dekat puncak) widget tree karena ia menyediakan BuildContext yang dibutuhkan oleh hampir semua widget Material Design. Tanpa MaterialApp sebagai pembungkus utama, fitur-fitur seperti Theme.of(context), Navigator.of(context), atau ScaffoldMessenger.of(context) tidak akan bisa ditemukan dan akan menyebabkan error.

4. Perbedaan utamanya terletak pada kemampuan widget untuk menyimpan dan mengubah data internal (state). 
    a. Stateless: Widget yang konfigurasinya tidak bisa berubah (immutable) setelah dibuat. Tampilannya murni ditentukan oleh parameter yang diterimanya dari parent. Statenya tidak memiliki state internal.
    b. StatefulWidget: Widget yang memiliki state internal yang bisa berubah selama lifetime widget tersebut. State dari widget ini terdiri dari dua kelas yaitu StatefulWidget dan State dengan logika dan data yang bisa berubah. Ketika state berubah, kamu memanggil setState() untuk memberi tahu Flutter agar membangun ulang (rebuild) UI dengan data baru.
5. BuildContext adalah lokasi atau handle dari sebuah widget di dalam widget tree. Setiap widget yang ada di tree memiliki BuildContext-nya sendiri. BuildContext sangat penting karena ia adalah cara bagi sebuah widget untuk berkomunikasi dengan lingkungannya (terutama parent dan ancestor-nya). Ia digunakan untuk 2 hal, yaitu mencari ancestor terdekat dan mendapatkan informasi perangkat dengan MediaQuery.of(context)

6. Konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart"
    a. Hot Reload: Fitur yang menginjeksikan  file kode sumber yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan. 
    b. Hot Restart: Memuat ulang kode aplikasi, tetapi tidak mempertahankan state. Ini menghancurkan state aplikasi yang ada dan me-restart Dart VM. Pada dasarnya, ini seperti menutup dan membuka kembali aplikasi, tetapi jauh lebih cepat daripada full restart.
    c. Perbedaan utamanya perbedaannya adalah hanya pada preservasi state. Hot Reload preservasinya cepat dan state aman. Sementara hot Restart, preservasinya agak lambat, sehingga state mudah hilang.
=