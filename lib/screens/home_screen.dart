import 'package:flutter/material.dart';

import 'complex_screen_one.dart';
import 'complex_screen_two.dart';
import 'notes_screen.dart';
import 'simple_screen_one.dart';
import 'simple_screen_two.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Практика верстки')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Выберите макет',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Четыре примера экранов Flutter с разным уровнем сложности.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),
              _ScreenSection(
                title: 'Простые макеты',
                description: 'Базовые формы и карточки',
                items: [
                  _ScreenItem(
                    title: 'Авторизация и профиль',
                    subtitle: 'Аватар, поля ввода и проверка формы',
                    icon: Icons.person_outline_rounded,
                    onTap: () => _open(context, const SimpleScreenOne()),
                  ),
                  _ScreenItem(
                    title: 'Карточка товара',
                    subtitle: 'Описание, рейтинг и кнопка действия',
                    icon: Icons.shopping_bag_outlined,
                    onTap: () => _open(context, const SimpleScreenTwo()),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _ScreenSection(
                title: 'Сложные макеты',
                description: 'Каталог, сетка и прокручиваемые секции',
                items: [
                  _ScreenItem(
                    title: 'Каталог и дашборд',
                    subtitle: 'Поиск, категории, фильтры и сетка',
                    icon: Icons.grid_view_rounded,
                    onTap: () => _open(context, const ComplexScreenOne()),
                  ),
                  _ScreenItem(
                    title: 'Экран объекта',
                    subtitle: 'Сворачиваемая шапка и вкладки',
                    icon: Icons.view_agenda_outlined,
                    onTap: () => _open(context, const ComplexScreenTwo()),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _ScreenSection(
                title: 'Дополнительно',
                description: 'Создавайте и редактируйте свои записи',
                items: [
                  _ScreenItem(
                    title: 'Мои заметки',
                    subtitle: 'Добавление, редактирование и удаление',
                    icon: Icons.sticky_note_2_outlined,
                    onTap: () => _open(context, const NotesScreen()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenSection extends StatelessWidget {
  const _ScreenSection({
    required this.title,
    required this.description,
    required this.items,
  });

  final String title;
  final String description;
  final List<_ScreenItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),
        for (final item in items) ...[
          item,
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _ScreenItem extends StatelessWidget {
  const _ScreenItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(icon),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
