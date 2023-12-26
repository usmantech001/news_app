import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/controllers/news_controller.dart';

import '../../widgets/widgets.dart';
import 'web_view_screen.dart';

class ViewAllScreen extends StatelessWidget {
  final String title;
  final NewsController newsController;
  const ViewAllScreen({super.key, required this.newsController, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar:
                  buildAppBar(
                    firstText: title, 
                    secText: '', color: Colors.blue),
              body:   ListView.builder(
                  itemCount: title=='Breaking News!'?newsController.breakingNewsList.length:newsController.trendingNewsList.length,
                  itemBuilder: (context, index) {
                    var item = title=='Breaking News!'?newsController.breakingNewsList[index]:newsController.trendingNewsList[index];
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
}