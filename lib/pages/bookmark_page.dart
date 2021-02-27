import 'package:flutter/material.dart';
import 'package:news_app/components/article_details_page.dart';
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
  Article forArticle;

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
                Article bookedArticle = articles[index];
                return articles.length == null
                    ? CircularProgressIndicator()
                    : customListTile(bookedArticle, context);
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
