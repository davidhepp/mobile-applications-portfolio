import 'package:flutter/material.dart';

import '../data/dish_data.dart';
import '../models/dish.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  DishCategory? _selectedCategory;
  String? _precacheSignature;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final thumbnailWidth = (56 * pixelRatio).round();
    final detailWidth = (screenWidth * pixelRatio).round();
    final detailHeight = (240 * pixelRatio).round();
    final precacheSignature = '$thumbnailWidth:$detailWidth:$detailHeight';

    if (_precacheSignature == precacheSignature) {
      return;
    }

    _precacheSignature = precacheSignature;

    for (final dish in cafeMenu) {
      precacheImage(
        _DishImageCache.providerFor(
          dish,
          cacheWidth: thumbnailWidth,
          cacheHeight: thumbnailWidth,
        ),
        context,
      );
      precacheImage(
        _DishImageCache.providerFor(
          dish,
          cacheWidth: detailWidth,
          cacheHeight: detailHeight,
        ),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Our Menu')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('All'),
                      selected: _selectedCategory == null,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                  ),
                  for (final category in DishCategory.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category.displayName),
                        selected: _selectedCategory == category,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedCategory == null
                  ? 0
                  : DishCategory.values.indexOf(_selectedCategory!) + 1,
              children: [
                _DishListView(
                  key: const PageStorageKey<String>('all-dishes'),
                  dishes: _dishesForCategory(null),
                  showCategoryHeaders: true,
                ),
                for (final category in DishCategory.values)
                  _DishListView(
                    key: PageStorageKey<String>('category-${category.name}'),
                    dishes: _dishesForCategory(category),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Dish> _dishesForCategory(DishCategory? category) {
    if (category != null) {
      return cafeMenu
          .where((dish) => dish.category == category)
          .toList(growable: false);
    }

    return DishCategory.values
        .expand(
          (category) => cafeMenu.where((dish) => dish.category == category),
        )
        .toList(growable: false);
  }
}

class _DishListView extends StatelessWidget {
  const _DishListView({
    super.key,
    required this.dishes,
    this.showCategoryHeaders = false,
  });

  final List<Dish> dishes;
  final bool showCategoryHeaders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        final showCategoryHeader =
            showCategoryHeaders &&
            (index == 0 || dishes[index - 1].category != dish.category);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showCategoryHeader)
              Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 14, bottom: 8),
                child: Text(
                  dish.category.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  leading: _DishImage(dish: dish, size: 56, borderRadius: 10),
                  title: Text(
                    dish.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(dish.shortDescription),
                  trailing: Text(
                    dish.priceLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MenuDetailPage(dish: dish),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({super.key, required this.dish});

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dish.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: _DishImageCache.providerFor(
                dish,
                cacheWidth:
                    (MediaQuery.sizeOf(context).width *
                            MediaQuery.devicePixelRatioOf(context))
                        .round(),
                cacheHeight: (240 * MediaQuery.devicePixelRatioOf(context))
                    .round(),
              ),
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 240,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dish.priceLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(dish.category.displayName),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dish.shortDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dish.longDescription,
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

extension _DishDisplay on Dish {
  String get priceLabel => '\$${price.toStringAsFixed(2)}';
}

class _DishImageCache {
  static final Map<String, ImageProvider> _providers = {};

  static ImageProvider providerFor(
    Dish dish, {
    required int cacheWidth,
    required int cacheHeight,
  }) {
    final key = '${dish.imagePath}:$cacheWidth:$cacheHeight';

    return _providers.putIfAbsent(
      key,
      () => ResizeImage.resizeIfNeeded(
        cacheWidth,
        cacheHeight,
        AssetImage(dish.imagePath),
      ),
    );
  }
}

class _DishImage extends StatelessWidget {
  const _DishImage({
    required this.dish,
    required this.size,
    required this.borderRadius,
  });

  final Dish dish;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image(
        image: _DishImageCache.providerFor(
          dish,
          cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
          cacheHeight: (size * MediaQuery.devicePixelRatioOf(context)).round(),
        ),
        width: size,
        height: size,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }
}
