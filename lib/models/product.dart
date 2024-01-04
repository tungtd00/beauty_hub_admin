import 'brand.dart';
import 'category.dart';
import 'package:json_annotation/json_annotation.dart';


part 'product.g.dart';

@JsonSerializable()
class Product {
  String idProduct;
  String name;
  String image;
  String description;
  double cost;
  double? discount;
  Brand brand;
  List<Category> categories;
  double? sold;

  Product(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.brand,
    this.categories,
    this.sold,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Map<String, dynamic> convertToJson() {
    return {
      "idProduct": idProduct,
      "name": name,
      "image": image,
      "description": description,
      "cost": cost,
      "discount": discount,
      "brand": brand.toJson(),
      "categories": categories.map((e) => e.toJson()).toList(),
      "sold": sold,
    };
  }

  double getPrice() {
    return cost;
  }
}
