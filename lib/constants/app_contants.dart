import 'package:news_app/services/repo/repo.dart';

class AppContants{
  static final String APPBASEURL = 'https://newsapi.org/';
  static const String BREAKINGNEWSURL = 'v2/top-headlines?country=us&category=business&apiKey=d1affd6148754297bd5df65fe117124a';
  static const String TRENDINGNEWSURL = 'v2/everything?q=tesla&from=2023-11-23&sortBy=publishedAt&apiKey=d1affd6148754297bd5df65fe117124a';
  static const String CATEGORYNEWSURL = 'v2/top-headlines?country=us&category=business&apiKey=d1affd6148754297bd5df65fe117124a';
}