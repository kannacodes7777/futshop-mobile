import 'package:flutter/material.dart';
import 'package:futshop/left_drawer.dart'; 

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "";
  bool _isFeatured = false;

  // Controller untuk memudahkan reset form
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _thumbController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    // Bersihkan controller saat widget di-dispose
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _thumbController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _priceController.clear();
    _descController.clear();
    _thumbController.clear();
    _categoryController.clear();
    setState(() {
      _isFeatured = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Tambah Produk',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Tambahkan drawer
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() => _name = value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  if (value.length < 3) {
                    return "Nama terlalu pendek (minimal 3 karakter)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Input Price
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: "Harga",
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() => _price = int.tryParse(value!) ?? 0);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka!";
                  }
                  if (int.parse(value) <= 0) {
                    return "Harga tidak boleh negatif atau nol!";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),

              // Input Description
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  hintText: "Deskripsi Produk",
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() => _description = value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (value.length < 10) {
                    return "Deskripsi terlalu pendek (minimal 10 karakter)!";
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),

              // Input Thumbnail URL
              TextFormField(
                controller: _thumbController,
                decoration: InputDecoration(
                  hintText: "URL Thumbnail",
                  labelText: "URL Thumbnail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() => _thumbnail = value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "URL Thumbnail tidak boleh kosong!";
                  }
                  // Validasi URL sederhana
                  if (!Uri.tryParse(value)!.isAbsolute) {
                     return "Format URL tidak valid (contoh: https://...)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Input Category
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: "Kategori",
                  labelText: "Kategori",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() => _category = value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Input isFeatured (Switch)
              SwitchListTile(
                title: const Text("Produk Unggulan (Featured)"),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() => _isFeatured = value);
                },
              ),
              const SizedBox(height: 24.0),

              // Tombol Save
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Tampilkan pop-up jika validasi berhasil
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Produk Berhasil Disimpan"),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Nama: $_name"),
                                Text("Harga: $_price"),
                                Text("Deskripsi: $_description"),
                                Text("Thumbnail: $_thumbnail"),
                                Text("Kategori: $_category"),
                                Text("Featured: $_isFeatured"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                                _resetForm(); // Reset form setelah dialog ditutup
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}