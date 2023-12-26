import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  Map<String, String>? headers;
  ApiClient({required this.appBaseUrl}){
    baseUrl=appBaseUrl;
    headers ={
      'Content_type': 'application/json'
    };
    
  }

  Future<Response> getData(String url) async {
   return await get(url);
  }
}