import 'package:flutter/material.dart';
import 'package:futshop/models/product_entry.dart';
import 'package:futshop/widget/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:futshop/screens/detail_product.dart';

class ProductListPage extends StatefulWidget {
  final bool filterByUser;

  const ProductListPage({super.key, this.filterByUser = false});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    String endpoint = widget.filterByUser ? 'my-json/' : 'json/';
    final response = await request.get('http://127.0.0.1:8000/$endpoint');
    var data = response;
    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filterByUser ? 'Produk Saya' : 'Daftar Produk'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Belum ada data produk pada futshop.",
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProductPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (snapshot.data![index].fields.thumbnail.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data![index].fields.thumbnail,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data![index].fields.name}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Kategori: ${snapshot.data![index].fields.category}",
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text("Rp ${snapshot.data![index].fields.price}"),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data![index].fields.description}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        if (snapshot.data![index].fields.isFeatured)
                          const Text("Featured Product", style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}