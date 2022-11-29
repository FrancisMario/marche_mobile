import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import 'helpers.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  final initialContent =
      '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              buildSpace(direction: Axis.vertical, amount: 10.0, flex: false),
              Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Play around with the buttons below',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              buildSpace(direction: Axis.vertical, amount: 10.0, flex: false),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                ),
                child: WebViewX(
                  key: const ValueKey('webviewx'),
                  initialContent: initialContent,
                  initialSourceType: SourceType.html,
                  height: screenSize.height / 1.5,
                  width: screenSize.width,
                  onWebViewCreated: (controller) =>
                      webviewController = controller,
                  onPageStarted: (src) =>
                      debugPrint('A new page has started loading: $src\n'),
                  onPageFinished: (src) =>
                      debugPrint('The page has finished loading: $src\n'),
                  jsContent: const {
                    EmbeddedJsContent(
                      js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
                    ),
                    EmbeddedJsContent(
                      webJs:
                          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",  
                      mobileJs:
                          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
                    ),
                  },
                  dartCallBacks: {
                    DartCallback(
                      name: 'TestDartCallback',
                      callBack: (msg) => showSnackBar(msg.toString(), context),
                    )
                  },
                  webSpecificParams: const WebSpecificParams(
                    printDebugInfo: true,
                  ),
                  mobileSpecificParams: const MobileSpecificParams(
                    androidEnableHybridComposition: true,
                  ),
                  navigationDelegate: (navigation) {
                    debugPrint(navigation.content.sourceType.toString());
                    return NavigationDecision.navigate;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }
}
