import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

AppBar buildAppBar(
    {required String firstText,
    required String secText,
    Color color = Colors.black}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        reuseableText(text: firstText, color: color),
        reuseableText(text: secText, color: Colors.blue)
      ],
    ),
  );
}

Widget reuseableText(
    {required String text,
    Color color = Colors.black,
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.normal, int maxLines = 2}) {
  return Text(
    text,
    maxLines: maxLines,
    style: TextStyle(
      fontFamily: 'Montserrat',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: TextOverflow.clip,
      
    ),
  );
}

Widget categoryTile(
    {required String categoryName, required String categoryImage}) {
  return Container(
    margin: const EdgeInsets.only(right: 0),
    child: Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              categoryImage,
              fit: BoxFit.cover,
              width: 150,
              height: 80,
            )),
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: reuseableText(
              text: categoryName, color: Colors.white, fontSize: 16),
        )
      ],
    ),
  );
}

Widget homeRowText({
  required String firstText,
  required Function() onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        reuseableText(
            text: firstText, fontSize: 20, fontWeight: FontWeight.bold),
        GestureDetector(
          onTap: onTap,
          child: reuseableText(
              text: 'View All',
              color: Colors.blue,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget buildCarouselTile(BuildContext context, ArticleModel breakingNews) {
  return Container(
    
    margin:  EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    height: 250.h,
    width: MediaQuery.sizeOf(context).width,
    child: Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: breakingNews.urlToImage == null
                ? Image.asset(
                    'assets/images/business.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: 250.h,
                  )
                : CachedNetworkImage(
                    imageUrl: breakingNews.urlToImage!,
                    height: 250.h,
                    fit: BoxFit.cover,
                  )),
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin:  EdgeInsets.only(top: 160.h),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black12),
          child: reuseableText(
              text: breakingNews.title ?? '',
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget trendingTile(BuildContext context, ArticleModel trendingNews) {
  return Container(
    padding:  EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h, right: 10.w),
    margin:  EdgeInsets.only(bottom: 10.h),
    height: 180.h,
    width: MediaQuery.sizeOf(context).width,
  // width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // color: Colors.red
    ),
    child: Container(
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(-5, -5), color: Colors.grey.shade100),
            BoxShadow(offset: const Offset(5, 5), color: Colors.grey.shade100)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: trendingNews.urlToImage == null
                ? Image.asset(
                    'assets/images/sports.jpg',
                    width: 150.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: trendingNews.urlToImage!,
                    width: 150.w,
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
            // child: Image.asset('assets/images/sports.jpg', width: 150,height: 200, fit: BoxFit.cover,)
          ),
           SizedBox(
            width: 10.w,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                 
                    width: 170.w,
                    child: reuseableText(
                        text: trendingNews.title ?? '',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700)),
                Container(
                    margin:  EdgeInsets.only(top: 5.h),
                    width: 170.w,
                    child: reuseableText(
                        text: trendingNews.description ?? '', fontSize: 15, maxLines: 3)
                        )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
