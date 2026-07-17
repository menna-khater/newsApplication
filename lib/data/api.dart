import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/data/models/news_model.dart';

abstract class Api {
  //https://newsapi.org/v2/everything?q=bitcoin&apiKey=03f33d501ba94dd0b9b714459c2e22b7
  static Future<NewsModel> getNews() async {
    Uri url = Uri.https('newsapi.org', '/v2/everything', {
      "q": "bitcoin",
      "apiKey": "03f33d501ba94dd0b9b714459c2e22b7",
    });
    var response = await http.get(url);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    return NewsModel.fromJson(json);
    
  }
}
