import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://www.tm-trainer.com"));


  Future<bool> _exitApp(BuildContext context) async {
    if (await controller.canGoBack()) {
      print("onwill goback");
      controller.goBack();
      return Future.value(false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WillPopScope(
      onWillPop: () => _exitApp(context),
      child: WebViewWidget(
        controller: controller,
      ),
    ));
  }
}