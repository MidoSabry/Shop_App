import 'package:flutter/material.dart';
import 'package:flutter_ecomerce_app/Models/page_view_model.dart';
import 'package:flutter_ecomerce_app/Styles/colors.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateAndFinish.dart';
import 'package:flutter_ecomerce_app/Widgets/textbutton.dart';
import 'package:flutter_ecomerce_app/shared/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  _PageViewState createState() => _PageViewState();

  static builder(
      {BouncingScrollPhysics? physics,
      PageController? controller,
      Null Function(int index)? onPageChanged,
      itemBuilder,
      int? itemCount}) {}
}

class _PageViewState extends State<PageViewScreen> {
  var boardController = PageController();

  List<PageViewModel> boarding = [
    PageViewModel(
      image: 'assets/images/onboard_1.png',
      title: 'On Board 1 Title',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
    ),
    PageViewModel(
      image: 'assets/images/onboard_2.png',
      title: 'On Board 2 Title',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
    ),
    PageViewModel(
      image: 'assets/images/onboard_3.png',
      title: 'On Board 3 Title',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
    ),
  ];

  bool isLast = false;

  void submit() {
    CasheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
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
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        //curve: Curves.fastLinearToSlowEaseIn,
                        curve: Curves.easeInOutBack,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(PageViewModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
