import 'dart:async';

import 'package:fins_user/utils/finsStandard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            "Privacy policy",
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: WebView(
          initialUrl: "https://finsandslice.com/pages/privacy-policy",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        )
        // WebviewScaffold(
        //     url: "https://finsandslice.com/pages/privacy-policy",
        //     withLocalStorage: true,
        //     initialChild: Center(
        //         child: CircularProgressIndicator(
        //       valueColor: new AlwaysStoppedAnimation<Color>(Fins.finsColor),
        //     )),
        //     appBar: PreferredSize(
        //         preferredSize: Size.fromHeight(5.0), // here the desired height
        //         child: AppBar(
        //           backgroundColor: Colors.white,
        //           brightness: Brightness.light,
        //
        //           // ...
        //         ))),
        );
  }
}
