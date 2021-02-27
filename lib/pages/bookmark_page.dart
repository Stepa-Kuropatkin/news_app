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
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               ArticlePage(article: forArticle),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       margin: EdgeInsets.all(12.0),
                //       padding: EdgeInsets.all(12.0),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(18.0),
                //         boxShadow: [
                //           BoxShadow(
                //             blurRadius: 3.0,
                //             color: Colors.black12,
                //           )
                //         ],
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           bookedArticle.urlToImage != null
                //               ? Container(
                //                   height: 200.0,
                //                   width: double.infinity,
                //                   decoration: BoxDecoration(
                //                     image: DecorationImage(
                //                       fit: BoxFit.cover,
                //                       image: NetworkImage(
                //                           bookedArticle.urlToImage),
                //                     ),
                //                     borderRadius:
                //                         BorderRadius.circular(8.0),
                //                   ),
                //                 )
                //               : Image.network(
                //                   'http://cdn-ds.com/stock/2018-Subaru-Crosstrek-2-0i-Limited-Seattle-WA/seo/PGICARTERVW-JF2GTAMC1J8247483/sz_71918/457c03e771054022163930e3da280e08.jpg',
                //                   fit: BoxFit.cover,
                //                 ),
                //           SizedBox(
                //             height: 8.0,
                //           ),
                //           Container(
                //             decoration: BoxDecoration(
                //               color: Colors.red,
                //               borderRadius: BorderRadius.circular(30.0),
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(5.0),
                //               child: Text(
                //                 bookedArticle.source.name,
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 8.0,
                //           ),
                //           Text(
                //             bookedArticle.title,
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16.0,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
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
