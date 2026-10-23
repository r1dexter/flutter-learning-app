import 'package:flutter/material.dart';

class ComplexScreenTwo extends StatelessWidget {
  const ComplexScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                leading: const BackButton(),
                pinned: true,
                expandedHeight: 240,
                forceElevated: innerBoxIsScrolled,
                title: const Text('Карточка объекта'),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: colorScheme.primaryContainer,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.apartment_rounded,
                      size: 100,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Обзор'),
                    Tab(text: 'Характеристики'),
                    Tab(text: 'Отзывы'),
                  ],
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                _OverviewTab(),
                _SpecificationsTab(),
                _ReviewsTab(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Заявка отправлена')),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: const Text('Связаться'),
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('overview'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'Современная квартира',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Светлое пространство с продуманной планировкой и видом на город.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const _InfoPanel(
                icon: Icons.location_on_outlined,
                title: 'Адрес',
                value: 'Москва, Пресненская набережная',
              ),
              const SizedBox(height: 12),
              const _InfoPanel(
                icon: Icons.payments_outlined,
                title: 'Стоимость',
                value: '18 500 000 ₽',
              ),
              const SizedBox(height: 12),
              const _InfoPanel(
                icon: Icons.star_outline_rounded,
                title: 'Рейтинг',
                value: '4.9 из 5 · 36 отзывов',
              ),
              const SizedBox(height: 24),
              Text(
                'Об объекте',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Уютный объект в развитом районе. Рядом расположены магазины, '
                'кафе, остановки транспорта и зеленые зоны для прогулок.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _SpecificationsTab extends StatelessWidget {
  const _SpecificationsTab();

  static const _specifications = [
    ('Площадь', '68 м²'),
    ('Комнаты', '2'),
    ('Этаж', '12 из 24'),
    ('Год постройки', '2022'),
    ('Отделка', 'Современная'),
    ('Балкон', 'Есть'),
    ('Парковка', 'Подземная'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('specifications'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Характеристики',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  );
                }
                final specification = _specifications[index - 1];
                return _SpecificationRow(
                  label: specification.$1,
                  value: specification.$2,
                );
              },
              childCount: _specifications.length + 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('reviews'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'Отзывы гостей',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              const _ReviewCard(
                name: 'Анна',
                date: 'Сентябрь 2026',
                review: 'Отличное расположение и очень комфортная планировка.',
              ),
              const SizedBox(height: 12),
              const _ReviewCard(
                name: 'Михаил',
                date: 'Август 2026',
                review: 'Всё соответствует описанию. Остались довольны выбором.',
              ),
              const SizedBox(height: 12),
              const _ReviewCard(
                name: 'Елена',
                date: 'Июль 2026',
                review: 'Удобная инфраструктура и приятный вид из окна.',
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

class _SpecificationRow extends StatelessWidget {
  const _SpecificationRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.name,
    required this.date,
    required this.review,
  });

  final String name;
  final String date;
  final String review;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Text(name.substring(0, 1)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(date, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(Icons.star_rounded, color: colorScheme.tertiary),
                const Text('5.0'),
              ],
            ),
            const SizedBox(height: 12),
            Text(review),
          ],
        ),
      ),
    );
  }
}
