import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/articles_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    ArticlesDao dau = ArticlesDao();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Article'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: article.urlToImage != null
                          ? NetworkImage(article.urlToImage)
                          : AssetImage(
                              'assets/457c03e771054022163930e3da280e08.jpg'),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: article.author == null || article.author == ''
                            ? Text(
                                article.source.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : Text(
                                (article.author).length > 10
                                    ? article.source.name
                                    : article.author,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: article.publishedAt != null
                            ? Text(
                                article.publishedAt.substring(0, 10),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : Text(
                                new DateFormat.yMMMd().format(
                                  new DateTime.now(),
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                article.description == null
                    ? Text(
                        'Wops! No description yet added :^(\n\nCheck the Source instead!')
                    : Text(
                        article.description,
                      ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    launch(article.url);
                  },
                  child: Text(
                    'Go to source',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.white70,
                  elevation: 0.0,
                ),
                RaisedButton(
                  onPressed: () {
                    dau.insertArticles(article);
                  },
                  child: Text(
                    'Add to Bookmarks',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  color: Colors.white70,
                  elevation: 0.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
