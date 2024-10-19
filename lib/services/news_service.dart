import 'package:dio/dio.dart';
import 'package:news_app/models/news_model.dart';

class NewsService {
  final Dio dio;

  const NewsService(
    this.dio,
  );

  Future<List<NewsModel>> getGeneralNews({required String category}) async {
    try {
      Response response = await dio.get(
          'https://newsapi.org/v2/everything?q=$category&apiKey=YOUR_API_KEY');

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData["articles"];
      List<NewsModel> articleList = [];

      for (var article in articles) {
        NewsModel articlemodel = NewsModel(
          newsImg: article["urlToImage"],
          newsTitle: article["title"],
          newsSubTitle: article["description"],
        );
        // NewsModel articlemodel = NewsModel.fromJson(article);
        articleList.add(articlemodel);
      }
      return articleList;
    } catch (e) {
      return [];
    }
  }
}
