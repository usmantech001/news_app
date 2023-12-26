import 'package:get/get.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/controllers/news_controller.dart';

class CategoryController extends GetxController{
  late String categoryName;
  late NewsController newsController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    categoryName = Get.arguments['categoryName'];
  newsController = Get.arguments['newsController'];
  }
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
  
  newsController.getCategoryNewsDataList(categoryName.toLowerCase());
  print(categoryName);
  }
}