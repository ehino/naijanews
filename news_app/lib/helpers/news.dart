import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class News {
  List <ArticleModel> news = [];

  Future <void> getNews () async {
    String url = 'https://newsapi.org/v2/top-headlines?country=ng&apiKey=6f3c814af0204029988719b4f6b78398';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element){
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            dateTime: element['dateTime'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }


  }
}

class CategoryNews {
  List <ArticleModel> news = [];


  Future <void> getCategoryNews (String category) async {
    String url = 'https://newsapi.org/v2/top-headlines?country=ng&category=$category&apiKey=6f3c814af0204029988719b4f6b78398';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element){
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            dateTime: element['dateTime'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }


  }
}