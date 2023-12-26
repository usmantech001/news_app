import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/controllers/category_controller.dart';
import 'package:news_app/services/controllers/news_controller.dart';
import 'package:news_app/views/screens/web_view_screen.dart';
import 'package:news_app/widgets/widgets.dart';

import '../../models/news_model.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<ArticleModel> categoryNewsList;
  const CategoryScreen({super.key, required this.categoryNewsList, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (newsCOnt) {
        return GetBuilder<CategoryController>(
          builder: (categoryController) {
            print('The lenght is ${categoryController.newsController.categoryNewsList.length}');
            return Scaffold(
              appBar:
                  buildAppBar(firstText: categoryName, secText: '', color: Colors.blue),
              body:  categoryController.newsController.isLoading2?Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),): ListView.builder(
                  itemCount: categoryController.newsController.categoryNewsList.length,
                  itemBuilder: (context, index) {
                    var item = categoryController.newsController.categoryNewsList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(()=>WebViewScreen(url:item.url!));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        height: 350,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(imageUrl: item.urlToImage!, height: 200, fit: BoxFit.cover, width: MediaQuery.sizeOf(context).width,)
                                ),
                                SizedBox(height: 10,),
                            reuseableText(
                                text:
                                    item.title!,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                                reuseableText(text: item.description!, fontSize: 15, maxLines: 3)
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        );
      }
    );
  }
}
