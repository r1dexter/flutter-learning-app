import 'package:flutter/material.dart';

class ComplexScreenTwo extends StatefulWidget {
  const ComplexScreenTwo({super.key});

  @override
  State<ComplexScreenTwo> createState() => _ComplexScreenTwoState();
}

class _ComplexScreenTwoState extends State<ComplexScreenTwo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _navigationIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabContents = [
      const _DetailContent(
        title: 'О проекте',
        description:
            'Создать понятный и цельный интерфейс для мобильного приложения. '
            'Соберите основные экраны, проверьте композицию и подготовьте '
            'макет к презентации.',
        icon: Icons.description_outlined,
      ),
      const _DetailContent(
        title: 'Этапы работы',
        description:
            'Исследование задачи • Черновой прототип • Визуальный стиль • '
            'Проверка и финальная презентация',
        icon: Icons.checklist,
      ),
      const _DetailContent(
        title: 'Участники',
        description:
            'Алина — дизайн\nМарк — прототипирование\nЕва — проверка макета',
        icon: Icons.people_outline,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(color: Colors.white),
            expandedHeight: 250,
            pinned: true,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Дизайн-проект'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6750A4), Color(0xFF30234D)],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 62,
                    child: Icon(
                      Icons.auto_awesome,
                      size: 150,
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  const Positioned(
                    left: 24,
                    bottom: 78,
                    child: Chip(
                      avatar: Icon(Icons.circle, size: 12),
                      label: Text('В процессе'),
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Обзор'),
                Tab(text: 'Этапы'),
                Tab(text: 'Команда'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Обновлено сегодня',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Icon(Icons.more_horiz),
                    ],
                  ),
                  const SizedBox(height: 20),
                  tabContents[_tabController.index],
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Срок проекта',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(height: 4),
                                const Text('Пятница, 16 мая'),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Редактировать проект'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (index) => setState(() => _navigationIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Проекты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
