enum Category { healthyLife, fastFood, asian }

class Meal {
  const Meal({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    this.rate = 0,
  });

  final String name;
  final Category category;
  final double price;
  final int rate;
  final String description;
}
