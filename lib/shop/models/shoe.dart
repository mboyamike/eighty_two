class Shoe {
  Shoe({
    required this.id,
    required this.name,
    required this.imagePath,
    this.color,
    this.price = 0,
    this.size = 0,
  }) {
    assert(price > 0);
  }

  String id;
  String? color;
  String name;
  String imagePath;
  double price;
  double size;
}
