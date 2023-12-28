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
  bool isConnected = false;
   bool isAlreadyConnected=false ;
  int currentDotIndex =0;
  late ConnectivityResult subscription;
  int index = 0;

  @override
   onInit()  async {
    super.onInit();
     await checkInternetConnection();
  }
  @override
  onReady() async {
    super.onReady();
   await checkInternetConnection();
    
  }
  
  

   Future<void> checkInternetConnection() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult status) async { 
  if(status == ConnectivityResult.none) {
    isConnected=false;
    update();
    isAlreadyConnected = false;
    update();
  }else if(status!= ConnectivityResult.none && breakingNewsList.isEmpty&&trendingNewsList.isEmpty){
     
     isConnected = true;
    update();

      await getBreakingNewsDataList();
     await  getTrendingNewsDataList();
     isAlreadyConnected =true;
   update();
 
  
  }else{
    isConnected = true;
    update();
    isAlreadyConnected = true;
    update();
  }

 
  
   

    });
    // if(connectivityResult == ConnectivityResult.none){
      
       
    //     print('..............The connection is false');
      
    //   //return false;

      
    // }else{ 
    //   getBreakingNewsDataList();
    //   getTrendingNewsDataList();
    //    print('..............The connection istrue');
     
  
   
    // }
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
   }
   
  }
 Future<void> getTrendingNewsDataList() async{
  isLoading1 =true;
  update();
   Response response= await newsRepo.getTrendingNewsData();
   if(response.statusCode==200){
    trendingNewsList =[];

    trendingNewsList.addAll(BreakingNewsModel.fromJson(response.body).articles.where((element) => element.urlToImage!=null));
    isLoading1 =false;
   update();
    update();
   }
  
  }

  Future<void> getCategoryNewsDataList(category) async{
    isLoading2 =true;
    update();
   Response response= await newsRepo.getCategoryNewsData(category);
   if(response.statusCode==200){
    categoryNewsList =[];

    categoryNewsList.addAll(BreakingNewsModel.fromJson(response.body).articles.where((element) => element.urlToImage!=null));
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