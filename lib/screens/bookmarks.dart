import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../book.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  int id;
  int chapter;
  int verse;
  @override
  void initState() {
    super.initState();
    _loadprefs();
  }

  _loadprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      chapter = prefs.getInt('bookChapter') ?? 0;
      id = prefs.getInt('bookId') ?? 0;
      verse = prefs.getInt('bookVerse') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final book = BOOK.where((test) => test.id == id).toList()[0];
    final title = book.title;
    final chapterCount = book.chapter;
    // final verse = CHAPTER.where((test)=>test.id==id&&test.chapter==chapter).toList()[0].verse;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: InkWell(
        child: ListTile(
          leading: Text(title),
          title: Text('Chapter $chapter : $verse Verse'),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/', arguments: {
            'chapter': chapter,
            'id': id,
            'chapterCount': chapterCount,
          });
        },
      ),
    );
  }
}
