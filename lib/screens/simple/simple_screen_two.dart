import 'package:flutter/material.dart';

class SimpleScreenTwo extends StatelessWidget {
  const SimpleScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Легкий макет 2'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=1000&q=80',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                              ? child
                              : const _ImagePlaceholder(),
                          errorBuilder: (context, error, stackTrace) =>
                              const _ImagePlaceholder(),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: _Badge(
                          label: 'Популярное',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Positioned(
                        top: 14,
                        right: 14,
                        child: _Badge(label: '-20%', color: Color(0xFFB3261E)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Удобная сумка',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Практичный аксессуар на каждый день с продуманным '
                          'дизайном и вместительным отделением.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFFB300)),
                            const SizedBox(width: 4),
                            const Text('4.8'),
                            const SizedBox(width: 6),
                            Text(
                              '(126 отзывов)',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Spacer(),
                            Text(
                              '3 490 ₽',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_bag_outlined),
                            label: const Text('Посмотреть товар'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: ColoredBox(
        color: Color(0xFFEDE7F6),
        child: Center(
          child: Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Color(0xFF6750A4),
          ),
        ),
      ),
    );
  }
}
