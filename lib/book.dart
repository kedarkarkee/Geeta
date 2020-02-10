import './models/book.dart';
import './models/chapter.dart';

const BOOK = const {
  Book(id: 1,title: 'Book 1',chapter: 5),
  Book(id: 2,title: 'Book 2', chapter: 3),
};
const CHAPTER = const {
Chapter(id: 1,chapter: 1, verseCount: 4, verse: ['This is a Book 1 Chapter 1 verse 1','This is a Book 1 Chapter 1 verse 2. This is very long verse. This should span multiple lines anyway.','This is a Book 1 Chapter 1 verse 3 ','This is a Book 1 Chapter 1 verse 4']),
Chapter(id: 1,chapter: 2, verseCount: 1, verse: ['This is a Book 1 Chapter 2 verse']),
Chapter(id: 1,chapter: 3, verseCount: 1, verse: ['This is a Book 1 Chapter 3 verse']),
Chapter(id: 1,chapter: 4, verseCount: 1, verse: ['This is a Book 1 Chapter 4 verse']),
Chapter(id: 1,chapter: 5, verseCount: 1, verse: ['This is a Book 1 Chapter 5 verse']),
Chapter(id: 2,chapter: 3, verseCount: 1, verse: ['This is a Book 2 Chapter 6 verse']),
Chapter(id: 2,chapter: 2, verseCount: 1, verse: ['This is a Book 2 Chapter 7 verse']),
Chapter(id: 2,chapter: 1, verseCount: 1, verse: ['This is a Book 2 Chapter 8 verse']),
};