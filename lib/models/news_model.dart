class BreakingNewsModel{
  String? status;
  int? totalResults;
  List<ArticleModel> articles =[];

  BreakingNewsModel({
      this.status,
      this.totalResults,
      required this.articles
  });

  BreakingNewsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    totalResults = json['totalResults'];
    if(json['articles']!=null){
      articles = <ArticleModel>[];
     ( json['articles'] as List).forEach((e) {
      
      articles.add(ArticleModel.fromJson(e));
     });
    }
  }
  
}

class ArticleModel{
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  ArticleModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content
  });
  ArticleModel.fromJson(Map<String, dynamic> json){
    
      author=json['author'];
      title=json['title'];
      description=json['description'];
      url=json['url'];
      urlToImage=json['urlToImage'];
      publishedAt=json['publishedAt'];
      content=json['content'];
    
  }
}