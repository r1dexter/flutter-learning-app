# Практическая работа №1 — основы Flutter UI

Учебное приложение для знакомства с базовыми виджетами Flutter. Проект
использует Material 3 и стандартные средства Flutter — без провайдеров,
платёжных сценариев и серверной логики.

## Запуск

```powershell
flutter pub get
flutter run
```

Проверка:

```powershell
flutter analyze
flutter test
```

## Экраны

- `lib/main.dart` — точка входа и тема Material 3.
- `lib/screens/home_screen.dart` — меню простых и сложных макетов.
- `lib/screens/simple/simple_screen_one.dart` — форма авторизации/профиля.
- `lib/screens/simple/simple_screen_two.dart` — карточка товара с изображением,
  бейджами и рейтингом.
- `lib/screens/complex/complex_screen_one.dart` — дашборд задач с поиском,
  горизонтальным списком недели и списком задач.
- `lib/screens/complex/complex_screen_two.dart` — детальная страница со
  сворачиваемой шапкой, вкладками и нижней навигацией.

Кнопки и формы демонстрируют внешний вид интерфейса; приложение не выполняет
настоящую авторизацию, покупку или сохранение данных.
