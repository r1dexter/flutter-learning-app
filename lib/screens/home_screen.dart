import 'package:flutter/material.dart';

import 'complex/complex_screen_one.dart';
import 'complex/complex_screen_two.dart';
import 'simple/simple_screen_one.dart';
import 'simple/simple_screen_two.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практическая работа №1'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Основы интерфейса Flutter',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Выберите макет для просмотра',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _SectionCard(
              title: 'Легкие макеты',
              subtitle: 'Формы, карточки и базовые виджеты',
              icon: Icons.widgets_outlined,
              color: const Color(0xFFEDE7F6),
              actions: [
                _ScreenButton(
                  label: 'Экран авторизации / профиля',
                  onPressed: () => _open(context, const SimpleScreenOne()),
                ),
                _ScreenButton(
                  label: 'Карточка товара',
                  onPressed: () => _open(context, const SimpleScreenTwo()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Сложные макеты',
              subtitle: 'Списки, прокрутка и составные экраны',
              icon: Icons.dashboard_customize_outlined,
              color: const Color(0xFFE3F2FD),
              actions: [
                _ScreenButton(
                  label: 'Дашборд задач',
                  onPressed: () => _open(context, const ComplexScreenOne()),
                ),
                _ScreenButton(
                  label: 'Детальный экран',
                  onPressed: () => _open(context, const ComplexScreenTwo()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.actions,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(subtitle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...actions,
          ],
        ),
      ),
    );
  }
}

class _ScreenButton extends StatelessWidget {
  const _ScreenButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
