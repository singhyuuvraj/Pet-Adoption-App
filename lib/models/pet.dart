class Pet {
  final String id;
  final String name;
  final String age;
  final double price;
  final String imageUrl;
  bool adopted;
  DateTime? adoptionDate;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.adopted = false,
  });
}
