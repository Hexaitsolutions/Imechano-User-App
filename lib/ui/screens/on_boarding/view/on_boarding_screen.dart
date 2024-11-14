// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/on_boarding/controller/on_boarding_controller.dart';
import 'package:imechano/ui/shared/widgets/text_widgets.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final onBoardingController = OnBoardingController();
  final _pageController = PageController();
  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: onBoardingController.selectedPageIndex,
              itemCount: onBoardingController.onBoardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 35),
                      child: SvgPicture.asset(
                        onBoardingController.onBoardingPages[index].imagePath,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.544,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: logoBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            Bold30White(
                              onBoardingController.onBoardingPages[index].title,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            Regular20White(
                              onBoardingController
                                  .onBoardingPages[index].subTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            // Positioned(
            //   bottom: 3,
            //   left: 10,
            //   child: TextButton(
            //     onPressed: () {
            //       Get.offNamed('/sign-in-sign-up-landing');
            //
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 30),
            //       child: Text(
            //         'Skip',
            //         style: TextStyle(
            //           color: white,
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 15,
              right: MediaQuery.of(context).size.width * 0.42,
              child: Row(
                children: List.generate(
                  onBoardingController.onBoardingPages.length,
                  (index) => Obx(() {
                    return Container(
                      width: 12,
                      height: 12,
                      margin: EdgeInsets.only(bottom: 30, left: 5),
                      decoration: BoxDecoration(
                        color: onBoardingController.selectedPageIndex.value ==
                                index
                            ? white
                            : transparent,
                        border: Border.all(color: white),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              bottom: 3,
              right: 10,
              child: TextButton(
                onPressed: () {
                  Get.offNamed('/sign-in-sign-up-landing');

                  // if (_pageController.page!.toInt() == 2) {
                  //   Get.offNamed('/sign-in-sign-up-landing');
                  //   // onBoardingController.selectedPageIndex = 0;
                  //   // _pageController.animateToPage(_pageController.page!.toInt()-2, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                  // } else {
                  //   onBoardingController.selectedPageIndex++;
                  //   print(_pageController.page!.toInt());
                  //   _pageController.animateToPage(
                  //       _pageController.page!.toInt() + 1,
                  //       duration: Duration(milliseconds: 400),
                  //       curve: Curves.easeIn);
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    getTranslated('Skip', context),
                    style: TextStyle(
                      color: white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
