import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    Get.find<NewsController>().getTrendingNewsDataList();
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<NewsController>(
          builder: (newsController) {
            return  Scaffold(
              appBar: buildAppBar(firstText: 'Flutter', secText: 'News'),
              body: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics:const BouncingScrollPhysics(),
                          itemCount: homeController.categoryList.length,
                          itemBuilder: (context, index){
                            var categoryImageList = homeController.categoryList.values.toList();
                            var categoryNameList = homeController.categoryList.keys.toList();
                            var categoryName = categoryNameList[index];
                            var categoryImage = categoryImageList[index];
                            
                            return Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: GestureDetector(
                                onTap: () {
                                 // newsController.getCategoryNewsDataList(categoryName.toLowerCase());
                                  Get.to(()=>CategoryScreen( categoryNewsList: newsController.categoryNewsList, categoryName:categoryName),
                                  
                                  arguments: {
                                    'categoryName':categoryName,
                                    'newsController':newsController
                                  });
                                },
                                child: categoryTile(categoryImage: categoryImage, categoryName: categoryName)),
                            );
                        }),
                      ),
                      homeRowText(firstText: 'Breaking News!', onTap: (){
                       Get.to(()=> ViewAllScreen(title: 'Breaking News!', newsController: newsController,), 
                        
                       );
                      }),
                     
                     newsController.isLoading==true&&newsController.breakingNewsList.isEmpty? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),): CarouselSlider.builder(
                        itemCount: newsController.breakingNewsList.length>5 ? 5: newsController.breakingNewsList.length, 
                        itemBuilder: (context, index, realIndex){
                          var breakingNews = newsController.breakingNewsList[index];
                       
                
                        return GestureDetector(
                          onTap: () => Get.to(()=>WebViewScreen(url:breakingNews.url!)),
                          child: buildCarouselTile(context, breakingNews,));
                      }, options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        viewportFraction: 0.85,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          
                          newsController.onCarouselChange(index);
                        },
                        enlargeStrategy: CenterPageEnlargeStrategy.height
                      )),
                     const SizedBox(height: 30,),
                      newsController.breakingNewsList.isEmpty?Container(): AnimatedSmoothIndicator(
                        activeIndex: newsController.currentDotIndex, 
                        count: newsController.breakingNewsList.length>5?5: newsController.breakingNewsList.length, 
                      
                      effect: WormEffect(activeDotColor: Colors.blue), ),
                      homeRowText(firstText: 'Trending News!', onTap: () {
                        Get.to(()=> ViewAllScreen(newsController: newsController, title: 'Trending News!'));
                      },),
                       newsController.isLoading1==true?Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),):Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: newsController.trendingNewsList.length,
                          itemBuilder: (context, index){
                          var trendingNews = newsController.trendingNewsList[index];
                          return GestureDetector(
                            onTap: () => Get.to(()=>WebViewScreen(url:trendingNews.url!)),
                            child: trendingTile(context, trendingNews));
                        }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}