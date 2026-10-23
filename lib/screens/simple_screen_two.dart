import 'package:flutter/material.dart';

class SimpleScreenTwo extends StatelessWidget {
  const SimpleScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Карточка товара'),
        actions: [
          IconButton(
            tooltip: 'Добавить в избранное',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Добавлено в избранное')),
              );
            },
            icon: const Icon(Icons.favorite_border_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 240,
                  width: double.infinity,
                  color: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.headphones_rounded,
                    size: 96,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.bolt_rounded, size: 18),
                    label: const Text('В наличии'),
                    backgroundColor: colorScheme.secondaryContainer,
                  ),
                  const Chip(
                    label: Text('Электроника'),
                    avatar: Icon(Icons.category_outlined, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Беспроводные наушники',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: colorScheme.tertiary),
                  const SizedBox(width: 4),
                  Text(
                    '4.8',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(128 отзывов)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Комфортные наушники с чистым звучанием, активным шумоподавлением '
                'и длительным временем работы. Подходят для поездок, работы и отдыха.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    '12 990 ₽',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'Бесплатная доставка',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Товар добавлен в корзину')),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Добавить в корзину'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
