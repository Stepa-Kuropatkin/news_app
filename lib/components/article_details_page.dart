import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/articles_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatefulWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isPressed;

  @override
  void initState() {
    super.initState();
    isPressed = true;
  }

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
                      image: widget.article.urlToImage != null
                          ? NetworkImage(widget.article.urlToImage)
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
                  widget.article.title,
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
                        child: widget.article.author == null ||
                                widget.article.author == ''
                            ? Text(
                                widget.article.source.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : Text(
                                (widget.article.author).length > 10
                                    ? widget.article.source.name
                                    : widget.article.author,
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
                        child: widget.article.publishedAt != null
                            ? Text(
                                widget.article.publishedAt.substring(0, 10),
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
                widget.article.description == null
                    ? Text(
                        'Wops! No description yet added :^(\n\nCheck the Source instead!')
                    : Text(
                        widget.article.description,
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
                    launch(widget.article.url);
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
                  onPressed: isPressed
                      ? () {
                          dau.insertArticles(widget.article);
                          setState(() {
                            isPressed = !isPressed;
                          });
                        }
                      : () {},
                  child: isPressed
                      ? Text(
                          'Add to Bookmarks',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        )
                      : Text(
                          'Already added',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side:
                        BorderSide(color: isPressed ? Colors.red : Colors.grey),
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
