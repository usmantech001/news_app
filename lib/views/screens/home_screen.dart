import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/services/controllers/home_controller.dart';
import 'package:news_app/services/controllers/news_controller.dart';
import 'package:news_app/views/screens/category_screen.dart';
import 'package:news_app/views/screens/view_all_screen.dart';
import 'package:news_app/views/screens/web_view_screen.dart';
import 'package:news_app/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<NewsController>(builder: (newsController) {
        return Scaffold(
          appBar: buildAppBar(firstText: 'Flutter', secText: 'News'),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  newsController.isAlreadyConnected == true ||
                          newsController.isConnected == true
                      ? Container()
                          : reuseableText(
                              text: 'Not connected to internet',
                              fontSize: 12,
                              color: Colors.red),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeController.categoryList.length,
                        itemBuilder: (context, index) {
                          var categoryImageList =
                              homeController.categoryList.values.toList();
                          var categoryNameList =
                              homeController.categoryList.keys.toList();
                          var categoryName = categoryNameList[index];
                          var categoryImage = categoryImageList[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => CategoryScreen(
                                          categoryNewsList:
                                              newsController.categoryNewsList,
                                          categoryName: categoryName),
                                      arguments: {
                                        'categoryName': categoryName,
                                        'newsController': newsController
                                      });
                                },
                                child: categoryTile(
                                    categoryImage: categoryImage,
                                    categoryName: categoryName)),
                          );
                        }),
                  ),
                  SizedBox(height: newsController.isConnected == false&&newsController.breakingNewsList.isEmpty? 100.h:0,),
                  newsController.isConnected == false&&newsController.breakingNewsList.isEmpty
                      ? Center(
                          child: Column(
                            
                          children: [
                            Image.asset(
                              'assets/images/no_connection.png',
                              fit: BoxFit.cover,
                              height: 150,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.h),
                              child: reuseableText(
                                  text: 'Oops no internet connection found'),
                            ),

                            GestureDetector(
                                onTap: () {
                                  newsController.checkInternetConnection();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical:10.h, horizontal: 15),
                                  color: Colors.blue,
                                  child: reuseableText(text: 'Retry', color: Colors.white, fontSize: 18)))
                          ],
                        ))
                      : Column(
                          children: [
                            homeRowText(
                                firstText: 'Breaking News!',
                                onTap: () {
                                  Get.to(
                                    () => ViewAllScreen(
                                      title: 'Breaking News!',
                                      newsController: newsController,
                                    ),
                                  );
                                }),
                            newsController.isLoading == true
                                ? Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.grey[100],),
                                  )
                                : CarouselSlider.builder(
                                    itemCount:
                                        newsController.breakingNewsList.length >
                                                5
                                            ? 5
                                            : newsController
                                                .breakingNewsList.length,
                                    itemBuilder: (context, index, realIndex) {
                                      var breakingNews = newsController
                                          .breakingNewsList[index];

                                      return GestureDetector(
                                          onTap: () => Get.to(() =>
                                              WebViewScreen(
                                                  url: breakingNews.url!)),
                                          child: buildCarouselTile(
                                            context,
                                            breakingNews,
                                          ));
                                    },
                                    options: CarouselOptions(
                                        height: 250,
                                        //autoPlay: true,
                                        viewportFraction: 0.85,
                                        enlargeCenterPage: true,
                                        onPageChanged: (index, reason) {
                                          newsController
                                              .onCarouselChange(index);
                                        },
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height)),
                            SizedBox(
                              height: 30.h,
                            ),
                            newsController.breakingNewsList.isEmpty
                                ? Container()
                                : AnimatedSmoothIndicator(
                                    activeIndex: newsController.currentDotIndex,
                                    count:
                                        newsController.breakingNewsList.length >
                                                5
                                            ? 5
                                            : newsController
                                                .breakingNewsList.length,
                                    effect:
                                        WormEffect(activeDotColor: Colors.blue),
                                  ),
                            homeRowText(
                              firstText: 'Trending News!',
                              onTap: () {
                                Get.to(() => ViewAllScreen(
                                    newsController: newsController,
                                    title: 'Trending News!'));
                              },
                            ),
                            newsController.isLoading1 == true
                                ? Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: newsController
                                            .trendingNewsList.length,
                                        itemBuilder: (context, index) {
                                          var trendingNews = newsController
                                              .trendingNewsList[index];
                                          return GestureDetector(
                                              onTap: () => Get.to(() =>
                                                  WebViewScreen(
                                                      url: trendingNews.url!)),
                                              child: trendingTile(
                                                  context, trendingNews));
                                        }),
                                  )
                          ],
                        )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
