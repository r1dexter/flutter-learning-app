import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_learning_app/main.dart';

void main() {
  testWidgets('home opens all four practice screens and supports back', (
    tester,
  ) async {
    await tester.pumpWidget(const FlutterLearningApp());

    expect(find.text('Практическая работа №1'), findsOneWidget);
    await tester.tap(find.text('Экран авторизации / профиля'));
    await tester.pumpAndSettle();
    expect(find.text('Ваш профиль'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Карточка товара'));
    await tester.tap(find.text('Карточка товара'));
    await tester.pumpAndSettle();
    expect(find.text('Удобная сумка'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Дашборд задач'));
    await tester.tap(find.text('Дашборд задач'));
    await tester.pumpAndSettle();
    expect(find.text('Мои задачи'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Детальный экран'));
    await tester.tap(find.text('Детальный экран'));
    await tester.pumpAndSettle();
    expect(find.text('Дизайн-проект'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
