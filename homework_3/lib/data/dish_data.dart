import '../models/dish.dart';

const List<Dish> cafeMenu = [
  Dish(
    name: 'Espresso',
    price: 4.00,
    shortDescription: 'Rich and concentrated single-origin espresso.',
    longDescription:
        'A bold espresso shot made from carefully roasted beans. Perfect for people who enjoy a strong and intense coffee flavor.',
    category: DishCategory.hotDrinks,
    imagePath: 'assets/images/dishes/Espresso.png',
  ),
  Dish(
    name: 'Cappuccino',
    price: 5.50,
    shortDescription: 'Balanced espresso, steamed milk, and microfoam.',
    longDescription:
        'A classic cappuccino with equal parts espresso, steamed milk, and foam. Smooth, balanced, and comforting.',
    category: DishCategory.hotDrinks,
    imagePath: 'assets/images/dishes/Cappuccino.png',
  ),
  Dish(
    name: 'Latte',
    price: 5.80,
    shortDescription: 'Smooth espresso with steamed milk and light foam.',
    longDescription:
        'A creamy and mellow coffee made with espresso and steamed milk. Great for people who prefer a softer coffee taste.',
    category: DishCategory.hotDrinks,
    imagePath: 'assets/images/dishes/Latte.png',
  ),
  Dish(
    name: 'Mocha',
    price: 6.20,
    shortDescription: 'Espresso with chocolate and steamed milk.',
    longDescription:
        'A rich and indulgent drink that combines espresso, chocolate, and milk. A great choice if you like sweet coffee drinks.',
    category: DishCategory.hotDrinks,
    imagePath: 'assets/images/dishes/Mocha.png',
  ),
  Dish(
    name: 'Iced Coffee',
    price: 5.00,
    shortDescription: 'Chilled coffee served over ice.',
    longDescription:
        'A refreshing cold coffee drink served over ice. Ideal for warm days and for people who enjoy lighter chilled beverages.',
    category: DishCategory.coldDrinks,
    imagePath: 'assets/images/dishes/IcedCoffee.png',
  ),
  Dish(
    name: 'Butter Croissant',
    price: 4.20,
    shortDescription: 'Fresh-baked flaky pastry served warm.',
    longDescription:
        'A buttery, flaky croissant baked fresh daily. Best enjoyed warm with coffee or tea.',
    category: DishCategory.pastries,
    imagePath: 'assets/images/dishes/Croissant.png',
  ),
  Dish(
    name: 'Lemon Tart',
    price: 6.00,
    shortDescription: 'Tangy lemon cream with a crisp pastry shell.',
    longDescription:
        'A minimalist masterpiece where the true star is our sharp, pure lemon curd, offering a bright, explosive citrus flavor. Sweet and tangy in every bite.',
    category: DishCategory.pastries,
    imagePath: 'assets/images/dishes/lemontart.png',
  ),
  Dish(
    name: 'Blueberry Muffin',
    price: 5.80,
    shortDescription: 'Soft muffin filled with sweet blueberries.',
    longDescription:
        'A moist and fluffy muffin packed with blueberries. Pairs perfectly with coffee or tea for breakfast or a snack.',
    category: DishCategory.pastries,
    imagePath: 'assets/images/dishes/BlueberryMuffin.png',
  ),
  Dish(
    name: 'Chicken Sandwich',
    price: 7.90,
    shortDescription: 'Fresh sandwich with grilled chicken and crisp lettuce.',
    longDescription:
        'A soul-warming classic featuring a tender chicken breast, double-dredged in our signature herb-flour blend and fried until perfectly crisp. Served on a toasted, buttery gluten-free bun with tangy house-made pickles, shredded iceberg lettuce, and a generous spread of our creamy roasted garlic aioli.',
    category: DishCategory.sandwiches,
    imagePath: 'assets/images/dishes/ChickenSandwich.png',
  ),
  Dish(
    name: 'Tuna Sandwich',
    price: 7.50,
    shortDescription:
        'Classic tuna sandwich with creamy filling and fresh bread.',
    longDescription:
        'The perfect ratio of creamy and crunchy. Premium white albacore tuna tossed with a touch of grey poupon Dijon and burst cherry tomatoes for a bright, tangy finish. Served chilled with crisp romaine lettuce and vine-ripened tomatoes on thick-cut, soft toasted bread.',
    category: DishCategory.sandwiches,
    imagePath: 'assets/images/dishes/TunaSandwich.png',
  ),
  Dish(
    name: 'Avocado Toast',
    price: 6.80,
    shortDescription: 'Toasted bread topped with fresh avocado and seasoning.',
    longDescription:
        'A vibrant and rustic breakfast feast. Our thick-cut, flame-charred sourdough serves as the base for a generous spread of creamy avocado mash. We top it with a savory saute of sweet corn, tender peas, green beans, carrots, and onions, all finished with a crunchy "everything" spice blend and a sprig of fresh rosemary. Complex, colorful, and completely satisfying.',
    category: DishCategory.breakfast,
    imagePath: 'assets/images/dishes/AvocadoToast.png',
  ),
];
