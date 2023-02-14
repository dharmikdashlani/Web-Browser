import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.lightBlue),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("D.S Browser"),
        backgroundColor: Colors.lightBlue,
      ),
      bottomNavigationBar: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                await inAppWebViewController?.goBack();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                await inAppWebViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: Uri.parse("https://google.com"),
                  ),
                );
              },
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                await inAppWebViewController?.goForward();
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                await inAppWebViewController?.reload();
              },
              icon: const Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse("https://google.com"),
            ),
            onWebViewCreated: (controller) {
              setState(() {
                inAppWebViewController = controller;
              });
            },
            pullToRefreshController: pullToRefreshController,
            onLoadStop: (controller, url) async {
              await pullToRefreshController.endRefreshing();
            }),
      ),
    );
  }
}
