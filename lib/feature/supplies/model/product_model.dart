class Product {
  final String id;
  final String image;
  final String name;
  final String brand;
  final String price;
  final bool inStock;
  final bool isFavorite;
  final bool isSpotOn;
  final String supplyBrand;
  int quantity;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    required this.inStock,
    this.isFavorite = false,
    this.isSpotOn = false,
    required this.supplyBrand,
    this.quantity = 0,
  });
}
