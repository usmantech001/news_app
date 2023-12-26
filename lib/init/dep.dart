import 'package:get/get.dart';
import 'package:news_app/constants/app_contants.dart';
import 'package:news_app/services/apiclient/api_client.dart';
import 'package:news_app/services/controllers/category_controller.dart';
import 'package:news_app/services/controllers/home_controller.dart';
import 'package:news_app/services/controllers/news_controller.dart';
import 'package:news_app/services/repo/repo.dart';

Future<void> init() async{
  Get.lazyPut(() => ApiClient(appBaseUrl: AppContants.APPBASEURL));
  //repos
  Get.lazyPut(() => NewsRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => NewsController(newsRepo: Get.find(), ), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => CategoryController(), fenix: true);
}