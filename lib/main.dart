import 'package:flutter/material.dart';
import 'notes_database.dart';

void main() => runApp(ThimbleNotes());

class ThimbleNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thimble-Notes',
      home: NoteHomePage(),
    );
  }
}

class NoteHomePage extends StatefulWidget {
  @override
  _NoteHomePageState createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await NotesDatabase.instance.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addNote() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await NotesDatabase.instance.addNote(text);
      _controller.clear();
      _loadNotes();
    }
  }

  Future<void> _deleteNote(int id) async {
    await NotesDatabase.instance.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      backgroundColor: Colors.white,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Thimble Notes'),
      backgroundColor: Colors.blueGrey,
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildTextField(),
          SizedBox(height: 10),
          buildSaveButton(),
          SizedBox(height: 20),
          buildNoteList(),
        ],
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Write your note...',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildSaveButton() {
    return ElevatedButton(
      onPressed: _addNote,
      child: Text('Save Note'),
    );
  }

  Widget buildNoteList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Card(
            child: ListTile(
              title: Text(note['content']),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(note['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}
