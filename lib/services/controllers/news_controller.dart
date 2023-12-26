import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/repo/repo.dart';

class NewsController extends GetxController{
  final NewsRepo newsRepo;
  NewsController({required this.newsRepo});

  List<ArticleModel> breakingNewsList =[];
  List<ArticleModel> trendingNewsList =[];
  List<ArticleModel> categoryNewsList =[];
  bool isLoading =false;
  bool isLoading1 =false;
  bool isLoading2 =false;
  bool isConnected=false;
  int currentDotIndex =0;
  int index = 0;

  @override
   onInit()  async {
    super.onInit();
     getBreakingNewsDataList();
      getTrendingNewsDataList();
  //  var isConnect =await checkInternetConnection();
 
  //   if(isConnect ==true){
  //     isConnected = true;
  //      getBreakingNewsDataList();
  //     getTrendingNewsDataList();
  //     update();
     
  //   }else{
  //     isConnected = false;
  //     update();
  //   }
  }
  

   Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
        print('..............The connection is${isConnected}');
      
      return false;

      
    }else{ 
       
       return true;
   
    }
  }

 Future<void> getBreakingNewsDataList() async{
  isLoading =true;
  update();
   Response response= await newsRepo.getBreakingNewsData();
   if(response.statusCode==200){
    breakingNewsList =[];
     
    breakingNewsList.addAll(BreakingNewsModel.fromJson(response.body).articles.where((e) =>e.urlToImage!=null ));
    update();
    isLoading =false;
   update();

   }else{
    print(response.statusCode);
   }
   
  }
 Future<void> getTrendingNewsDataList() async{
  isLoading1 =true;
  print('loading........');
  update();
   Response response= await newsRepo.getTrendingNewsData();
   if(response.statusCode==200){
    trendingNewsList =[];

    trendingNewsList.addAll(BreakingNewsModel.fromJson(response.body).articles.where((element) => element.urlToImage!=null));
    print('gotten');
    update();
   }
  isLoading1 =false;
   update();
  }

  Future<void> getCategoryNewsDataList(category) async{
    isLoading2 =true;
    update();
   Response response= await newsRepo.getCategoryNewsData(category);
   if(response.statusCode==200){
    categoryNewsList =[];

    categoryNewsList.addAll(BreakingNewsModel.fromJson(response.body).articles.where((element) => element.urlToImage!=null));
    print(categoryNewsList.length);
    update();
      isLoading2 =false;
  
  
    update();
   }
 

  }


  onCarouselChange(int index){
    currentDotIndex = index;
    update();
  }

  
}