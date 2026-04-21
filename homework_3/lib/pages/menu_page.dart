import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const List<_MenuItem> _items = [
    _MenuItem(
      name: 'Espresso',
      description: 'Rich and concentrated single-origin espresso.',
      price: '\$4.00',
      icon: Icons.coffee,
    ),
    _MenuItem(
      name: 'Cappuccino',
      description: 'Balanced espresso, steamed milk, and microfoam.',
      price: '\$5.50',
      icon: Icons.local_cafe,
    ),
    _MenuItem(
      name: 'Butter Croissant',
      description: 'Fresh-baked flaky pastry served warm.',
      price: '\$4.20',
      icon: Icons.bakery_dining,
    ),
    _MenuItem(
      name: 'Lemon Tart',
      description: 'Tangy lemon cream with a crisp pastry shell.',
      price: '\$6.00',
      icon: Icons.cake,
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
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFC67C4E),
                child: Icon(item.icon, color: Colors.white),
              ),
              title: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(item.description),
              trailing: Text(
                item.price,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });

  final String name;
  final String description;
  final String price;
  final IconData icon;
}
