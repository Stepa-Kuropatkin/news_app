import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/sembast_db.dart';
import 'package:sembast/sembast.dart';

class ArticlesDao {
  static const String folderName = 'Articles';
  final _articleFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertArticles(Article article) async {
    await _articleFolder.add(await _db, article.toJson());
  }

  Future<List<Article>> getAllArticles() async {
    var a = await _db;
    var recordSnapshot = await _articleFolder.find(a);
    List<Article> articles = recordSnapshot
        .map<Article>((item) {
          try {
            final art = Article.fromJson(item.value);
            return art;
          } catch (e) {
            print(e);
            return null;
          }
        })
        .where((x) => x != null)
        .toList();

    return articles;
  }
}
