import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const List<MenuItem> _items = [
    MenuItem(
      name: 'Espresso',
      description: 'Rich and concentrated single-origin espresso.',
      price: '\$4.00',
      imagePath: 'assets/images/dishes/Espresso.png',
      details:
          'A bold espresso shot made from carefully roasted beans. Perfect for people who enjoy a strong and intense coffee flavor.',
    ),
    MenuItem(
      name: 'Cappuccino',
      description: 'Balanced espresso, steamed milk, and microfoam.',
      price: '\$5.50',
      imagePath: 'assets/images/dishes/Cappuccino.png',
      details:
          'A classic cappuccino with equal parts espresso, steamed milk, and foam. Smooth, balanced, and comforting.',
    ),
    MenuItem(
      name: 'Latte',
      description: 'Smooth espresso with steamed milk and light foam.',
      price: '\$5.80',
      imagePath: 'assets/images/dishes/Latte.png',
      details:
          'A creamy and mellow coffee made with espresso and steamed milk. Great for people who prefer a softer coffee taste.',
    ),
    MenuItem(
      name: 'Mocha',
      description: 'Espresso with chocolate and steamed milk.',
      price: '\$6.20',
      imagePath: 'assets/images/dishes/Mocha.png',
      details:
          'A rich and indulgent drink that combines espresso, chocolate, and milk. A great choice if you like sweet coffee drinks.',
    ),
    MenuItem(
      name: 'Iced Coffee',
      description: 'Chilled coffee served over ice.',
      price: '\$5.00',
      imagePath: 'assets/images/dishes/IcedCoffee.png',
      details:
          'A refreshing cold coffee drink served over ice. Ideal for warm days and for people who enjoy lighter chilled beverages.',
    ),
    MenuItem(
      name: 'Butter Croissant',
      description: 'Fresh-baked flaky pastry served warm.',
      price: '\$4.20',
      imagePath: 'assets/images/dishes/Croissant.png',
      details:
          'A buttery, flaky croissant baked fresh daily. Best enjoyed warm with coffee or tea.',
    ),
    MenuItem(
      name: 'Chicken Sandwich',
      description: 'Fresh sandwich with grilled chicken and crisp lettuce.',
      price: '\$7.90',
      imagePath: 'assets/images/dishes/ChickenSandwich.png',
      details:
          'A soul-warming classic featuring a tender chicken breast, double-dredged in our signature herb-flour blend and fried until perfectly crisp. Served on a toasted, buttery gluten-free bun with tangy house-made pickles, shredded iceberg lettuce, and a generous spread of our creamy roasted garlic aioli.',
    ),
    MenuItem(
      name: 'Tuna Sandwich',
      description: 'Classic tuna sandwich with creamy filling and fresh bread.',
      price: '\$7.50',
      imagePath: 'assets/images/dishes/TunaSandwich.png',
      details:
          'The perfect ratio of creamy and crunchy. Premium white albacore tuna tossed with a touch of grey poupon Dijon and burst cherry tomatoes for a bright, tangy finish. Served chilled with crisp romaine lettuce and vine-ripened tomatoes on thick-cut, soft toasted bread.',
    ),
    MenuItem(
      name: 'Avocado Toast',
      description: 'Toasted bread topped with fresh avocado and seasoning.',
      price: '\$6.80',
      imagePath: 'assets/images/dishes/AvocadoToast.png',
      details:
          'A vibrant and rustic breakfast feast. Our thick-cut, flame-charred sourdough serves as the base for a generous spread of creamy avocado mash. We top it with a savory sauté of sweet corn, tender peas, green beans, carrots, and onions, all finished with a crunchy "everything" spice blend and a sprig of fresh rosemary. Complex, colorful, and completely satisfying.',
    ),
    MenuItem(
      name: 'Lemon Tart',
      description: 'Tangy lemon cream with a crisp pastry shell.',
      price: '\$6.00',
      imagePath: 'assets/images/dishes/lemontart.png',
      details:
          'A minimalist masterpiece where the true star is our sharp, pure lemon curd, offering a bright, explosive citrus flavor. Sweet and tangy in every bite.',
    ),
    MenuItem(
      name: 'Blueberry Muffin',
      description: 'Soft muffin filled with sweet blueberries.',
      price: '\$5.80',
      imagePath: 'assets/images/dishes/BlueberryMuffin.png',
      details:
          'A moist and fluffy muffin packed with blueberries. Pairs perfectly with coffee or tea for breakfast or a snack.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Menu'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = _items[index];

          return Card(
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.imagePath,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              title: Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(item.description),
              trailing: Text(
                item.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MenuDetailPage(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({
    super.key,
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imagePath,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 240,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.details,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.details,
  });

  final String name;
  final String description;
  final String price;
  final String imagePath;
  final String details;
}