import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '2fbbe14148b54ef682f0680283535e93';

class NewsService with ChangeNotifier {
  List<Articles> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.futbol, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
    Category(FontAwesomeIcons.addressCard, 'general'),
  ];
  Map<String, List<Articles>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Articles>? get getArticulosPorCategoria => categoryArticles[selectedCategory];

  getTopHeadlines() async {
    const url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=us';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewResponse.fromJson(json.decode(resp.body));
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url =
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = NewResponse.fromJson(json.decode(resp.body));
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
