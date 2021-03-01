import 'package:flutter/material.dart';
import 'package:news_app/components/custom_listTile.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/articles_dao.dart';
import 'package:news_app/services/api_service.dart';

class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  ArticlesDao dau = ArticlesDao();
  ApiService client = ApiService();
  Article forArticle = Article();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: dau.getAllArticles(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Article>> recsnapshot) {
          if (recsnapshot.hasData) {
            if (recsnapshot.connectionState == ConnectionState.none &&
                recsnapshot.data == null) {
              return Container(color: Colors.amber[100]);
            }
            List<Article> articles = recsnapshot.data;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return articles.length == null
                    ? Center(child: Text('No data added'))
                    : customListTile(articles[index], context);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
