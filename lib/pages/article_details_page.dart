import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: (article.title).length >= 15
            ? Text(
                article.title.substring(0, 15) + '...',
                style: TextStyle(color: Colors.black),
              )
            : Text(
                article.title,
                style: TextStyle(color: Colors.black),
              ),
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
                article.urlToImage != null
                    ? Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(article.urlToImage),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )
                    : Image.network(
                        'http://cdn-ds.com/stock/2018-Subaru-Crosstrek-2-0i-Limited-Seattle-WA/seo/PGICARTERVW-JF2GTAMC1J8247483/sz_71918/457c03e771054022163930e3da280e08.jpg',
                        fit: BoxFit.cover,
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
                                (article.author).length > 10 ? article.source.name : article.author,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                // RaisedButton(
                //   TODO add to bookmarks
                //   onPressed: () {},
                //   child: Text(
                //     'Add to Bookmarks',
                //     style: TextStyle(fontSize: 18, color: Colors.red),
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8.0),
                //     side: BorderSide(color: Colors.red),
                //   ),
                //   color: Colors.white70,
                //   elevation: 0.0,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
