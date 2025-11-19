import 'package:flutter/material.dart';
import 'package:futshop/models/product_entry.dart';

class DetailProductPage extends StatelessWidget {
  final Product product;

  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.fields.thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  product.fields.thumbnail,
                  errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            
            Text(
              product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Category: ${product.fields.category}",
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            Text(
              "Brand: ${product.fields.brand}",
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              "Price: Rp ${product.fields.price}",
              style: const TextStyle(
                fontSize: 20.0, 
                fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(product.fields.description),
            const SizedBox(height: 20),
            Text("Stock: ${product.fields.stock}"),
            Text("Rating: ${product.fields.rating} / 5.0"),
            
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                child: const Text('Kembali ke Daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}