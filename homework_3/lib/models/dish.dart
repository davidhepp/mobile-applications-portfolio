enum DishCategory {
  hotDrinks,
  coldDrinks,
  pastries,
  savory,
}

extension DishCategoryExtension on DishCategory {
  // This extension allows you to easily get a UI-friendly name
  // for your enum values by calling .displayName on them
  String get displayName {
    switch (this) {
      case DishCategory.hotDrinks:
        return 'Hot Drinks';
      case DishCategory.coldDrinks:
        return 'Cold Drinks';
      case DishCategory.pastries:
        return 'Pastries';
      case DishCategory.savory:
        return 'Savory';
    }
  }
}

class Dish {
  final String name;
  final double price;
  final String shortDescription;
  final String longDescription;
  final DishCategory category;

  const Dish({
    required this.name,
    required this.price,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
  });
}
