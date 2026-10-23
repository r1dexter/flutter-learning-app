import 'package:flutter/material.dart';

class ComplexScreenOne extends StatelessWidget {
  const ComplexScreenOne({super.key});

  static const _weeklyTasks = [
    ('ПН', '12', Color(0xFFEDE7F6)),
    ('ВТ', '13', Color(0xFFE3F2FD)),
    ('СР', '14', Color(0xFFFFF3E0)),
    ('ЧТ', '15', Color(0xFFE8F5E9)),
    ('ПТ', '16', Color(0xFFFCE4EC)),
    ('СБ', '17', Color(0xFFE0F7FA)),
    ('ВС', '18', Color(0xFFFFF8E1)),
  ];

  static const _tasks = [
    _TaskData('Подготовить макет главного экрана', '09:00 — 10:30', 'Алина', 3),
    _TaskData('Обсудить цветовую палитру', '11:00 — 11:45', 'Марк', 2),
    _TaskData('Собрать компоненты интерфейса', '13:00 — 15:00', 'Ева', 4),
    _TaskData('Проверить адаптивность', '16:00 — 17:00', 'Илья', 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Сложный макет 1'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Уведомления',
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Мои задачи',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Планируйте день и работайте вместе',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Найти задачу',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  tooltip: 'Фильтр',
                  icon: const Icon(Icons.tune),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Эта неделя',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Календарь')),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _weeklyTasks.length,
                itemBuilder: (context, index) {
                  final day = _weeklyTasks[index];
                  final selected = index == 2;
                  return Container(
                    width: 58,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : day.$3,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.$1,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          day.$2,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Сегодня',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('4 задачи', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              itemCount: _tasks.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  _TaskTile(task: _tasks[index], index: index),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskData {
  const _TaskData(this.title, this.time, this.owner, this.teamSize);

  final String title;
  final String time;
  final String owner;
  final int teamSize;
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task, required this.index});

  final _TaskData task;
  final int index;

  static const _avatarColors = [
    Color(0xFF6750A4),
    Color(0xFF006A60),
    Color(0xFFB3261E),
    Color(0xFF386A20),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 54,
              decoration: BoxDecoration(
                color: _avatarColors[index],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.time,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Ответственный: ${task.owner}'),
                ],
              ),
            ),
            SizedBox(
              width: 62,
              height: 42,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (
                    var avatarIndex = 0;
                    avatarIndex < task.teamSize.clamp(1, 3);
                    avatarIndex++
                  )
                    Positioned(
                      right: avatarIndex * 17,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor:
                            _avatarColors[(index + avatarIndex) % 4],
                        child: Text(
                          avatarIndex == 0
                              ? task.owner.substring(0, 1)
                              : '${avatarIndex + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    bottom: -2,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Text(
                        '+${task.teamSize}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
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
