import 'package:flutter/material.dart';

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
  final List<String> _notes = [];

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _notes.add(text);
        _controller.clear();
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
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
      title: Text('Simple Notes'),
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
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(_notes[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteNote(index),
          ),
        ),
      ),
    ),
  );
}
}
