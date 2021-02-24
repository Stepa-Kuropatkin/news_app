import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/models/article_model.dart';

class ApiService {
  //endpoint URL
  final endPointUrl =
      'http://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=3721795506af42609e6ba9c84c5b2cfc';

  Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl);

    // if 200
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map<Article>((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ('Wop! Wop! That\'s the sound of the police!!');
    }
  }
}
