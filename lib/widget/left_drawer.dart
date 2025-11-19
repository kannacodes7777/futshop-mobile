import 'package:flutter/material.dart';
import 'package:futshop/screens/menu.dart';
import 'package:futshop/screens/product_form.dart';
import 'package:futshop/screens/list_product.dart';
import 'package:futshop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'FutShop',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Catat semua produkmu di sini!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Halaman Utama'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text('Daftar Semua Produk'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProductListPage(filterByUser: false)),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inventory),
                  title: const Text('Produk Saya'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProductListPage(filterByUser: true)),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_shopping_cart),
                  title: const Text('Tambah Produk'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductFormPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () async {
              final response = await request.logout(
                  "http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}