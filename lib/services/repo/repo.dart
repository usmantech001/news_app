import 'package:get/get.dart';
import 'package:news_app/constants/app_contants.dart';
import 'package:news_app/services/apiclient/api_client.dart';

class NewsRepo extends GetxService{
  final ApiClient apiClient;
  NewsRepo({required this.apiClient});

 Future<Response> getBreakingNewsData() async{
   return await apiClient.getData(AppContants.BREAKINGNEWSURL);
  }

  Future<Response> getTrendingNewsData() async{
   return await apiClient.getData(AppContants.BREAKINGNEWSURL);
  }

  Future<Response> getCategoryNewsData(category) async{
   return await apiClient.getData('v2/top-headlines?country=us&category=$category&apiKey=d1affd6148754297bd5df65fe117124a');
  }

}