import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:futshop/screens/menu.dart';
import 'package:futshop/widget/left_drawer.dart';

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
  bool _isFeatured = false;
  
  int _stock = 0;
  double _rating = 0.0;
  String? _category;
  String? _brand; 

  final List<String> _categoryOptions = [
    'topwear', 
    'bottomwear', 
    'shoes', 
    'accessories'
  ];
  
  final List<String> _brandOptions = [
    'nikey', 
    'adidas', 
    'puma', 
    'reebok'
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? value) => setState(() => _name = value!),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Nama tidak boleh kosong!";
                  return null;
                },
              ),
              const SizedBox(height: 12.0),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga",
                  labelText: "Harga",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? value) => setState(() => _price = int.tryParse(value!) ?? 0),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Harga tidak boleh kosong!";
                  if (int.tryParse(value) == null) return "Harga harus berupa angka!";
                  return null;
                },
              ),
              const SizedBox(height: 12.0),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? value) => setState(() => _description = value!),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Deskripsi tidak boleh kosong!";
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Stok",
                  labelText: "Stok",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? value) => setState(() => _stock = int.tryParse(value!) ?? 0),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Stok tidak boleh kosong!";
                  if (int.tryParse(value) == null) return "Stok harus berupa angka!";
                  return null;
                },
              ),
              const SizedBox(height: 12.0),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Rating (0.0 - 5.0)",
                  labelText: "Rating",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (String? value) => setState(() => _rating = double.tryParse(value!) ?? 0.0),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Rating tidak boleh kosong!";
                  double? val = double.tryParse(value);
                  if (val == null) return "Rating harus berupa angka!";
                  if (val < 0 || val > 5) return "Rating harus antara 0 sampai 5!";
                  return null;
                },
              ),
              const SizedBox(height: 12.0),

               TextFormField(
                decoration: InputDecoration(
                  hintText: "URL Thumbnail",
                  labelText: "URL Thumbnail",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? value) => setState(() => _thumbnail = value!),
              ),
              const SizedBox(height: 12.0),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                initialValue: _category,
                items: _categoryOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue;
                  });
                },
                validator: (value) => value == null ? "Pilih kategori!" : null,
              ),
              const SizedBox(height: 12.0),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Brand",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                initialValue: _brand,
                items: _brandOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _brand = newValue;
                  });
                },
                validator: (value) => value == null ? "Pilih brand!" : null,
              ),
              const SizedBox(height: 12.0),

              SwitchListTile(
                title: const Text("Produk Unggulan (Featured)"),
                value: _isFeatured,
                onChanged: (bool value) => setState(() => _isFeatured = value),
              ),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            "http://127.0.0.1:8000/create-flutter/",
                            jsonEncode(<String, dynamic>{
                                'name': _name,
                                'price': _price.toString(),
                                'description': _description,
                                'thumbnail': _thumbnail,
                                'category': _category, 
                                'brand': _brand,  
                                'stock': _stock,       
                                'rating': _rating,     
                                'is_featured': _isFeatured,
                            }));
                        
                        if (context.mounted) {
                            if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                content: Text("Produk baru berhasil disimpan!"),
                                ));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                            } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text("Gagal: ${response['message']}"),
                                ));
                            }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}