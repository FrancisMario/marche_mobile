import 'package:flutter/material.dart';
import 'package:marche/layout/shop_layout/shop_layout_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/shop_login-screen.dart';

class BoardingModel {
  String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image:
            'https://th.bing.com/th/id/OIP.9YwDDeQhgTy0K-SpPs-xkAHaHM?pid=ImgDet&rs=1',
        body:
            'Shopping made easy, fast and secure for you and your families in The Gambia ',
        title: 'MARCHE'),
    BoardingModel(
        image:
            'https://budhahost.com/wp-content/uploads/2019/06/safaghahosting-ecommerce-banner.png',
        body: 'Top up airtime for anyone in the Gambia.',
        title: 'Mobile Top up'),
    BoardingModel(
        image:
            'https://th.bing.com/th/id/OIP.4PlT0k0QaFBQnAet2r2XsQHaHa?pid=ImgDet&rs=1',
        body: 'Deliver the best quality of everything',
        title: 'Trusted services'),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLayoutScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: NetworkImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ],
      );
}
