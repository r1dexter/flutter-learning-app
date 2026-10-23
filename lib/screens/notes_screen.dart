import 'package:flutter/material.dart';

@immutable
class Note {
  const Note({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  final int id;
  final String content;
  final DateTime createdAt;

  Note copyWith({String? content}) {
    return Note(
      id: id,
      content: content ?? this.content,
      createdAt: createdAt,
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _textController = TextEditingController();
  final List<Note> _notes = [];
  int _nextId = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final content = _textController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _notes.insert(
        0,
        Note(
          id: _nextId++,
          content: content,
          createdAt: DateTime.now(),
        ),
      );
    });
    _textController.clear();
    FocusScope.of(context).unfocus();
  }

  void _deleteNote(Note note) {
    final index = _notes.indexWhere((item) => item.id == note.id);
    if (index == -1) return;

    setState(() => _notes.removeAt(index));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Заметка удалена'),
          action: SnackBarAction(
            label: 'Отменить',
            onPressed: () {
              if (!mounted) return;
              setState(() {
                _notes.insert(index.clamp(0, _notes.length), note);
              });
            },
          ),
        ),
      );
  }

  Future<void> _editNote(Note note) async {
    final updatedContent = await showDialog<String>(
      context: context,
      builder: (_) => _EditNoteDialog(initialContent: note.content),
    );

    if (!mounted || updatedContent == null || updatedContent.isEmpty) return;
    final index = _notes.indexWhere((item) => item.id == note.id);
    if (index == -1) return;
    setState(() {
      _notes[index] = _notes[index].copyWith(content: updatedContent);
    });
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();
    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final year = localDate.year;
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');
    return '$day.$month.$year, $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Мои заметки'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                minLines: 2,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Введите текст заметки...',
                  alignLabelWithHint: true,
                ),
                onSubmitted: (_) => _saveNote(),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _saveNote,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Сохранить'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _notes.isEmpty
                    ? _EmptyNotesState(color: colorScheme.primary)
                    : ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: _notes.length,
                        itemBuilder: (context, index) {
                          final note = _notes[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Dismissible(
                              key: ValueKey(note.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 24),
                                decoration: BoxDecoration(
                                  color: colorScheme.error,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: colorScheme.onError,
                                ),
                              ),
                              onDismissed: (_) => _deleteNote(note),
                              child: Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    16,
                                    8,
                                    8,
                                    8,
                                  ),
                                  title: Text(note.content),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _formatDate(note.createdAt),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: 'Редактировать заметку',
                                        onPressed: () => _editNote(note),
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Удалить заметку',
                                        onPressed: () => _deleteNote(note),
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: colorScheme.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditNoteDialog extends StatefulWidget {
  const _EditNoteDialog({required this.initialContent});

  final String initialContent;

  @override
  State<_EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<_EditNoteDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Редактировать заметку'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 2,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintText: 'Текст заметки',
          alignLabelWithHint: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: const Text('Сохранить изменения'),
        ),
      ],
    );
  }
}

class _EmptyNotesState extends StatelessWidget {
  const _EmptyNotesState({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sticky_note_2_outlined, size: 72, color: color),
            const SizedBox(height: 16),
            Text(
              'Заметок пока нет',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Добавьте первую заметку — она появится здесь.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
