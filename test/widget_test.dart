import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_practice/main.dart';
import 'package:layout_practice/screens/notes_screen.dart';

void main() {
  testWidgets('notes can be created, edited, and deleted from the menu',
      (tester) async {
    await tester.pumpWidget(const LayoutPracticeApp());

    final notesMenuItem = find.text('Мои заметки');
    await tester.ensureVisible(notesMenuItem);
    await tester.tap(notesMenuItem);
    await tester.pumpAndSettle();

    expect(find.text('Заметок пока нет'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Первая заметка');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();
    expect(find.text('Первая заметка'), findsOneWidget);

    await tester.tap(find.byTooltip('Редактировать заметку'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Обновленная заметка');
    await tester.tap(find.text('Сохранить изменения'));
    await tester.pumpAndSettle();
    expect(find.text('Обновленная заметка'), findsOneWidget);

    await tester.tap(find.byTooltip('Удалить заметку'));
    await tester.pumpAndSettle();
    expect(find.text('Заметка удалена'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });

  testWidgets('swiping a note away shows a confirmation snackbar',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: NotesScreen()),
    );

    await tester.enterText(find.byType(TextField).first, 'Свайп для удаления');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Dismissible), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(find.text('Заметка удалена'), findsOneWidget);
    expect(find.text('Заметок пока нет'), findsOneWidget);
  });
}
