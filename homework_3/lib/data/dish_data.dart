import '../models/dish.dart';

final List<Dish> cafeMenu = [
  const Dish(
    name: 'Cappuccino',
    price: 4.50,
    shortDescription: 'Classic espresso with steamed milk foam.',
    longDescription: 'A rich and creamy classic cappuccino made with our signature espresso blend, steamed milk, and a thick layer of silky foam.',
    category: DishCategory.hotDrinks,
  ),
  const Dish(
    name: 'Iced Latte',
    price: 4.00,
    shortDescription: 'Chilled espresso and milk over ice.',
    longDescription: 'Refreshing iced latte made with double espresso, poured over ice and your choice of milk for a smooth finish.',
    category: DishCategory.coldDrinks,
  ),
  const Dish(
    name: 'Butter Croissant',
    price: 3.50,
    shortDescription: 'Flaky, buttery, and freshly baked.',
    longDescription: 'A traditional French-style butter croissant, baked fresh daily. Perfectly crisp on the outside and soft and airy on the inside.',
    category: DishCategory.pastries,
  ),
  const Dish(
    name: 'Turkey Club Sandwich',
    price: 7.50,
    shortDescription: 'Turkey, bacon, and greens on artisan bread.',
    longDescription: 'A wholesome savory sandwich loaded with roasted turkey, crispy bacon, fresh greens, tomatoes, and mayo on toasted artisan bread.',
    category: DishCategory.savory,
  ),
];
