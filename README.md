## Pertanyaan Tugas 7

 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

 ## Jawaban Tugas 7
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

## Pertanyaan Tugas 8
1.  Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?


## Jawaban Tugas 8

#### 1. Perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`

#### `Navigator.push(context, route)`
- Menambahkan (push) halaman baru ke atas navigation stack tanpa menghapus halaman sebelumnya.  
- Pengguna masih dapat kembali ke halaman sebelumnya menggunakan tombol back.
- **Penggunaan di aplikasi Football Shop:**
  - Pada `menu.dart`, ketika pengguna menekan card Create Product.
  - Pada `left_drawer.dart`, ketika pengguna memilih menu “Tambah Produk”.
- **Alasan:**  
  Halaman Tambah Produk merupakan halaman sekunder dari halaman utama, sehingga pengguna seharusnya dapat kembali ke halaman utama setelah selesai atau membatalkan pengisian formulir.

#### `Navigator.pushReplacement(context, route)`
- Menggantikan halaman saat ini dengan halaman baru dan menghapus halaman sebelumnya dari stack.  
- Pengguna tidak dapat kembali ke halaman sebelumnya.
- **Penggunaan di aplikasi Football Shop:**
  - Pada `left_drawer.dart`, ketika pengguna memilih menu Halaman Utama.
- **Alasan:**  
  Halaman Utama adalah halaman utama (top-level page), sehingga pengguna tidak perlu kembali ke halaman sebelumnya.

**Kesimpulan:**  
Kita menggunakan `push()` jika pengguna perlu memiliki opsi untuk kembali, dan `pushReplacement()` jika halaman baru menggantikan halaman lama sepenuhnya.


#### 2. Hirarki Widget: `Scaffold`, `AppBar`, dan `Drawer`

#### a. `Scaffold`
- Menjadi kerangka utama setiap halaman yang menyediakan struktur dasar seperti `appBar`, `body`, dan `drawer`.
- Digunakan pada setiap halaman (`MyHomePage` dan `ProductFormPage`).

#### b. `AppBar`
- Menampilkan judul halaman di bagian atas dan tombol navigasi.  
- Warna latar belakang ditentukan dari tema utama:
  ```dart
  backgroundColor: Theme.of(context).colorScheme.primary
#### 3. Kelebihan Widget Layout yang Digunakan pada Halaman Formulir

Layout widget ini sangat penting dalam desain antarmuka, terutama pada halaman formulir, untuk memastikan kegunaan (usability) dan estetika.

* **`Padding`**
    * **Kelebihan:** Memberikan "ruang napas" (whitespace) di sekitar elemen UI. Tanpa `Padding`, formulir akan menempel di tepi layar, membuatnya terlihat sempit dan sulit dibaca.
    * **Contoh Penggunaan:** Di `product_form.dart`, saya membungkus `Form` dengan `SingleChildScrollView` yang memiliki properti `padding: const EdgeInsets.all(16.0)`. Ini memberikan jarak 16 piksel di sekeliling seluruh formulir dari tepi layar. Selain itu, saya menggunakan `const SizedBox(height: 16.0)` di antara setiap `TextFormField` untuk memberikan jarak vertikal yang konsisten antar elemen input.

* **`SingleChildScrollView`**
    * **Kelebihan:** Formulir seringkali lebih panjang dari tinggi layar perangkat, terutama ketika keyboard virtual muncul. `SingleChildScrollView` membungkus konten (dalam hal ini, `Column` yang berisi formulir) dan secara otomatis memungkinkan pengguna untuk *scroll* ke bawah. Ini mencegah error Bottom Overflow (konten terpotong oleh keyboard).
    * **Contoh Penggunaan:** Di `product_form.dart`, seluruh `Form` (beserta `Column` di dalamnya) adalah *child* dari `SingleChildScrollView`. Ini memungkinkan pengguna untuk scroll melihat semua *field* (Nama, Harga, Deskripsi, dll.) bahkan di layar ponsel yang kecil.

* **`ListView`**
    * **Kelebihan:** `ListView` sangat baik untuk menampilkan daftar konten yang bisa scrollable secara default. Ia efisien untuk daftar yang panjang atau yang jumlah itemnya dinamis.
    * **Contoh Penggunaan:** Dalam modifikasi ini, saya tidak menggunakan `ListView` untuk formulir itu sendiri (saya menggunakan `Column` di dalam `SingleChildScrollView` karena jumlah field-nya tetap). Namun, saya **menggunakan `ListView` di dalam `left_drawer.dart`**. `Drawer` tersebut memiliki `ListView` yang berisi `DrawerHeader` dan dua `ListTile` (Halaman Utama dan Tambah Produk). Penggunaan `ListView` di sini memastikan bahwa jika di masa depan kita menambahkan lebih banyak opsi menu hingga melebihi tinggi layar, drawer tersebut akan otomatis menjadi scrollable.

#### 4. Penyesuaian Warna Tema untuk Identitas Visual Aplikasi

Identitas visual yang konsisten dicapai dengan mendefinisikan skema warna terpusat di `main.dart` dan menggunakannya kembali di seluruh aplikasi.

1.  **Definisi Tema (di `main.dart`):**
    Di dalam `MaterialApp`, saya mendefinisikan `theme` utama:
    ```dart
    theme: ThemeData(
       colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent[400]),
    ),
    ```
    `primarySwatch: Colors.blue` menetapkan bahwa warna utama brand ini adalah Biru. Flutter secara otomatis menghasilkan turunan warna (terang, gelap, dll.) dari warna primer ini.

2.  **Penggunaan Tema (di halaman lain):**
    Saya tidak menggunakan warna hard-code (seperti `Colors.blue`) di setiap widget. Sebaliknya, saya memanggil warna dari tema yang sudah didefinisikan tersebut.
    * **AppBar:** Di `menu.dart` dan `product_form.dart`, `AppBar` menggunakan:
        `backgroundColor: Theme.of(context).colorScheme.primary`
    * **Tombol Save:** Di `product_form.dart`, `ElevatedButton` menggunakan:
        `backgroundColor: Theme.of(context).colorScheme.primary`
    * **Drawer Header:** Di `left_drawer.dart`, `DrawerHeader` juga diatur dengan `color: Colors.blue`, yang konsisten dengan `primarySwatch` yang didefinisikan.

3.  **Keuntungan:**
    * **Konsistensi:** Identitas visual aplikasi menjadi seragam di seluruh halaman.
    * **Kemudahan Perubahan:** Jika brand Football Shop memutuskan untuk rebranding dari biru menjadi hijau, saya hanya perlu mengubah **satu baris** di `main.dart` (misalnya, `primarySwatch: Colors.green`). Secara otomatis, `AppBar`, semua tombol, dan `DrawerHeader` di seluruh aplikasi akan ikut berubah menjadi hijau. 