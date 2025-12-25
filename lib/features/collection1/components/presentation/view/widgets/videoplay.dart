import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String prodname;

  WebViewVideoScreen({Key? key, required this.videoUrl, required this.prodname}) : super(key: key);

  @override
  State<WebViewVideoScreen> createState() => _WebViewVideoScreenState();
}

class _WebViewVideoScreenState extends State<WebViewVideoScreen> {
  late WebViewController webViewController;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can use progress if you want a progress bar
            // print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            // Page started loading
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            // Page finished loading
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // Handle error and hide loading
            setState(() {
              _isLoading = false;
            });
            print("WebView error: ${error.description}");
          },
          onHttpError: (HttpResponseError error) {
            // Handle HTTP error and hide loading
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.videoUrl));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: Text(
          widget.prodname,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,

              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          
          // Loading indicator overlay
          if (_isLoading)
           loading()
        ],
      ),
    );
  }
}