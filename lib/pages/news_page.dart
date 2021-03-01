import 'package:flutter/material.dart';
import 'package:news_app/components/custom_listTile.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/api_service.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ApiService client = ApiService();

  ScrollController _controller = ScrollController();

  int startCount = 5;
  var original;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    if (startCount < 20) {
      startCount = startCount + 5;
    }
    setState(() {});
  }

  Future refreshState() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshState,
        child: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data;
              original = articles;
              return ListView.builder(
                controller: _controller,
                itemCount:  startCount,
                itemBuilder: (context, index) {
                  if (index == startCount) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return customListTile(articles[index], context);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
