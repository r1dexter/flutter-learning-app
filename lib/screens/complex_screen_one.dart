import 'package:flutter/material.dart';

class ComplexScreenOne extends StatefulWidget {
  const ComplexScreenOne({super.key});

  @override
  State<ComplexScreenOne> createState() => _ComplexScreenOneState();
}

class _ComplexScreenOneState extends State<ComplexScreenOne> {
  static const _categories = [
    'Все',
    'Популярное',
    'Техника',
    'Дом',
    'Аксессуары',
  ];

  static const _products = [
    _Product('Наушники', '12 990 ₽', Icons.headphones_rounded, '4.8'),
    _Product('Часы', '8 490 ₽', Icons.watch_rounded, '4.6'),
    _Product('Камера', '24 990 ₽', Icons.camera_alt_rounded, '4.9'),
    _Product('Колонка', '5 990 ₽', Icons.speaker_rounded, '4.7'),
    _Product('Планшет', '31 990 ₽', Icons.tablet_rounded, '4.8'),
    _Product('Клавиатура', '6 490 ₽', Icons.keyboard_rounded, '4.5'),
  ];

  int _selectedCategory = 0;
  String _selectedFilter = 'Все';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Каталог'),
        actions: [
          IconButton(
            tooltip: 'Корзина',
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Найдите своё',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              SearchBar(
                hintText: 'Поиск товаров',
                leading: const Icon(Icons.search_rounded),
                trailing: [
                  IconButton(
                    tooltip: 'Фильтры',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Используйте фильтры ниже'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.tune_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionTitle(
                title: 'Категории',
                action: 'Все',
                onAction: () => setState(() => _selectedCategory = 0),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_categories[index]),
                        selected: _selectedCategory == index,
                        onSelected: (_) {
                          setState(() => _selectedCategory = index);
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              _SectionTitle(
                title: 'Подборка для вас',
                action: 'Смотреть все',
                onAction: () {},
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [
                  for (final filter in ['Все', 'В тренде', 'Со скидкой'])
                    FilterChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (_) => setState(() => _selectedFilter = filter),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                itemCount: _products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  product.icon,
                                  size: 48,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: colorScheme.tertiary,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  product.rating,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Spacer(),
                                Flexible(
                                  child: Text(
                                    product.price,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.action,
    required this.onAction,
  });

  final String title;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        TextButton(onPressed: onAction, child: Text(action)),
      ],
    );
  }
}

class _Product {
  const _Product(this.name, this.price, this.icon, this.rating);

  final String name;
  final String price;
  final IconData icon;
  final String rating;
}
