import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

import '../book.dart';
import '../models/chapter.dart';
import '../models/book.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int chapter = 1;
  int chapterCount = 0;
  int id = 1;
  List verseSelected = [];
  List<Color> textColor = [];
  List<String> selection = [];
  int bookselection = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_initializeFromArgs);
    super.initState();
  }

  void _initializeFromArgs(_) async {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    if (routeArgs != null) {
      setState(() {
        chapter = routeArgs['chapter'];
        id = routeArgs['id'];
        chapterCount = routeArgs['chapterCount'];
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        chapter = prefs.getInt('chapter') ?? 1;
        id = prefs.getInt('id') ?? 1;
        chapterCount = prefs.getInt('chapterCount') ?? 5;
      });
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _loadprefs();
  // }

  // @override
  // void didChangeDependencies() {
  //   final routeArgs =
  //       ModalRoute.of(context).settings.arguments as Map<String, int>;
  //   if (routeArgs != null) {
  //     chapter = routeArgs['chapter'];
  //     id = routeArgs['id'];
  //     chapterCount = routeArgs['chapterCount'];
  //   }
  //   super.didChangeDependencies();
  // }
  // _loadprefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     chapter = prefs.getInt('chapter') ?? 1;
  //     id = prefs.getInt('id') ?? 1;
  //     chapterCount = prefs.getInt('chapterCount') ?? 5;
  //   });
  // }
  _saveprefs(int chapter, int id, int chapterCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('chapter', chapter);
      prefs.setInt('id', id);
      prefs.setInt('chapterCount', chapterCount);
    });
  }
  _savebookmarks(int id, int chapter, int verse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('bookId', id);
    prefs.setInt('bookChapter', chapter);
    prefs.setInt('bookVerse', verse);
  }

  @override
  Widget build(BuildContext context) {
    final List<Book> book = BOOK.where((test) => test.id == id).toList();
    final bookTitle = book[0].title;
    final List<Chapter> chapters = CHAPTER
        .where((test) => test.id == id && test.chapter == chapter)
        .toList();
    final int verseCount = chapters[0].verseCount;
    final List<String> verses = chapters[0].verse;
    for (int i = 0; i < verseCount; i++) {
      verseSelected.add(false);
      textColor.add(Colors.white);
    }
    // void copy(BuildContext ctx) {
    //   Clipboard.setData(new ClipboardData(text: selection.toString() + ' Santosh Thapa'));
    //   Scaffold.of(ctx).showSnackBar(SnackBar(
    //     content: const Text('Copied to ClipBoard'),
    //   ));
    // }

    return Scaffold(
      appBar: !verseSelected.contains(true)
          ? AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (chapter > 1)
                        setState(() {
                          chapter = chapter - 1;
                          _saveprefs(chapter, id, chapterCount);
                        });
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(color: Colors.deepPurple),
                      child: Text(
                        id == 0 ? 'Title' : bookTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pushNamed('/choice'),
                  ),
                  Container(
                    child: Text(chapter.toString()),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      if (chapter < chapterCount)
                        setState(() {
                          chapter = chapter + 1;
                          _saveprefs(chapter, id, chapterCount);
                        });
                    },
                  ),
                ],
              ),
            )
          : PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: Builder(
                builder: (ctx) => AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            verseSelected.clear();
                            textColor.clear();
                            selection.clear();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(selection
                                  .toString()
                                  .replaceAll(RegExp(r'[\[\]]'), ' ') +
                              ' Santosh Thapa Chutiya Ho');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () {
                          _savebookmarks(id, chapter, bookselection);
                          Scaffold.of(ctx).showSnackBar(SnackBar(
                            content: const Text('Added to BookMarks'),
                          ));
                          setState(() {
                            verseSelected.clear();
                            textColor.clear();
                            selection.clear();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          Clipboard.setData(new ClipboardData(
                              text: selection
                                      .toString()
                                      .replaceAll(RegExp(r'[\[\]]'), ' ') +
                                  ' Santosh Thapa Chutiya Ho'));
                          Scaffold.of(ctx).showSnackBar(SnackBar(
                            content: const Text('Copied to ClipBoard'),
                          ));
                          print(selection.toString());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
      drawer: Drawer(
          child: SafeArea(
        child: InkWell(
                  child: ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmarks'),
          ),
          onTap: (){
            Navigator.of(context).pushNamed('/bookmarks');
          },
        ),
      )),
      // body: Builder(
      //   builder: (ctx)=> Container(
      //     child: Center(
      //       child: InkWell(
      //         child: Text(verse),
      //         onTap: (){
      //           Clipboard.setData(new ClipboardData(text: verse + ' Santosh Thapa'));
      //           Scaffold.of(ctx).showSnackBar(SnackBar(content: const Text('Copied to ClipBoard'),));
      //         },
      //       ),
      //     ),
      //   ),
      // // ),
      // body: Container(
      //   child: Center(
      //     child: AbsorbPointer(
      //       absorbing: _enabled,
      //       child: SelectableText(
      //         verse,
      //         style: TextStyle(backgroundColor: textColor),
      //         onTap: () {
      //           setState(() {
      //             verseSelected = !verseSelected;
      //             textColor = Colors.pink;
      //             _enabled = true;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        itemCount: verseCount,
        itemBuilder: (ctx, i) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: textColor[i]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${i + 1} ${verses[i]}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                verseSelected[i] = !verseSelected[i];
                if (textColor[i] == Colors.white) {
                  textColor[i] = Colors.grey[400];
                } else {
                  textColor[i] = Colors.white;
                }
                if (selection
                    .contains('$bookTitle  $chapter:${i + 1} ${verses[i]}')) {
                  selection
                      .remove('$bookTitle  $chapter:${i + 1} ${verses[i]}');
                } else {
                  selection.add('$bookTitle  $chapter:${i + 1} ${verses[i]}');
                }
                bookselection = i + 1;
              });
            },
          );
        },
      ),
    );
  }
}
