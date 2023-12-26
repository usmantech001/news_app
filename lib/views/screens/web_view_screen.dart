import 'package:flutter/material.dart';
import 'package:news_app/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatelessWidget {
//   final String url;
//   const WebViewScreen({super.key, required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(firstText: 'Flutter', secText: 'News'),
//       body: Container(
//         child: WebView(
//           onPageStarted: (url) {
//             print('starting');
//             CircularProgressIndicator();

//           },
//           initialUrl: url,
//           javascriptMode: JavascriptMode.disabled,
//         ),
//       ),
//     );
//   }
// }

class WebViewScreen extends StatefulWidget {
 final String url;
   const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(firstText: 'Flutter', secText: 'News'),
      body: Stack(
        children: [
          Container(
            child: WebView(
              onPageFinished: (url) {
                setState(() {
                  isLoading=false;
                });
                
                
              },
              initialUrl:widget.url ,
              javascriptMode: JavascriptMode.disabled,
            ),
          ),
          isLoading==true?Center(child: CircularProgressIndicator(color: Colors.blue,)):Container()
        ],
      ),
    );;
  }
}
// WebViewScreen
//   final String url;
//   const WebViewScreen({super.key, required this.url});

// Scaffold(
//       appBar: buildAppBar(firstText: 'Flutter', secText: 'News'),
//       body: Container(
//         child: WebView(
//           onPageStarted: (url) {
//             print('starting');
            
//           },
//           initialUrl: url,
//           javascriptMode: JavascriptMode.disabled,
//         ),
//       ),
//     );