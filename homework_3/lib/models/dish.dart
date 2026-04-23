enum DishCategory { hotDrinks, coldDrinks, pastries, sandwiches, breakfast }

extension DishCategoryExtension on DishCategory {
  String get displayName {
    switch (this) {
      case DishCategory.hotDrinks:
        return 'Hot Drinks';
      case DishCategory.coldDrinks:
        return 'Cold Drinks';
      case DishCategory.pastries:
        return 'Pastries';
      case DishCategory.sandwiches:
        return 'Sandwiches';
      case DishCategory.breakfast:
        return 'Breakfast';
    }
  }
}

class Dish {
  final String name;
  final double price;
  final String shortDescription;
  final String longDescription;
  final DishCategory category;
  final String imagePath;

  const Dish({
    required this.name,
    required this.price,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
    required this.imagePath,
  });
}
