import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    String pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;
    int stock;
    double rating;
    String brand;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.stock,
        required this.rating,
        required this.brand,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"] ?? 0,
        name: json["name"] ?? "Unknown",
        price: json["price"] ?? 0,
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "", 
        category: json["category"] ?? "Uncategorized",
        isFeatured: json["is_featured"] ?? false,
        stock: json["stock"] ?? 0,
        rating: (json["rating"] ?? 0).toDouble(), 
        
        brand: json["brand"] ?? "No Brand",
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "rating": rating,
        "brand": brand,
    };
}