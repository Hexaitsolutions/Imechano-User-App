// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano/ui/common/globals.dart' as globals;
import 'package:imechano/ui/provider/notification_count_provider.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/my_account/Notification.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textIconColor;
  final String? imageicon;
  final String? title;
  final double? height;
  final String? menuItem;
  final String? home;
  final String? action;
  final String? action2;
  final bool flag;

  WidgetAppBar({
    this.backgroundColor = logoBlue,
    this.textIconColor = white,
    this.imageicon,
    this.title = '',
    this.menuItem,
    this.home,
    this.height: kToolbarHeight,
    this.action,
    this.action2,
    this.flag = true,
  });
  dynamic appModelTheme;
  int count = 1;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return ScreenUtilInit(
      // designSize: Size(500, 896),
      builder: () => AppBar(
        key: _key,
        toolbarHeight: preferredSize.height,
        leadingWidth: preferredSize.width,
        iconTheme: IconThemeData(
          color: textIconColor,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  print("I M RRR");
                  // Navigator.pop(context);
                  if (menuItem!.contains('assets/svg/Arrow_alt_left.svg')) {
                    // var route = ModalRoute.of(context);
                    // if (route != null) {
                    //   print(route.settings.name);
                    //   if (route.settings.name == null) {
                    //     print("service selection");
                    //   }
                    // }
                    // if (globals.screenstack != 0) globals.screenstack--;
                    // print('globals.screenstack');
                    // print(globals.screenstack);
                    // Scaffold.of(context).openDrawer();
                  } else {
                    Scaffold.of(context).openDrawer();
                  }
                },
                child: Container(
                    padding: appModelTheme.appLocal == Locale("en")
                        ? EdgeInsets.only(
                            top: 15, bottom: 15, left: 10, right: 10)
                        : EdgeInsets.only(
                            top: 15, bottom: 15, left: 17, right: 17),
                    child: SvgPicture.asset(
                      '${menuItem}',
                    )),
              ),
              InkWell(
                splashColor: Color(0xFF2A7AD5), // Customizing the splash color

                onTap: () {
                  if (imageicon != null) {
                    print("Shoaib Pressed Back button from App Bar");

                    if (Navigator.of(context).canPop()) {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BottomBarPage(2)),
                          (Route<dynamic> route) => false);
                    }
                  }
                },
                child: Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 20, right: 5, bottom: 15),
                    child: SvgPicture.asset('${imageicon}')),
              ),
            ],
          ),
        ),
        actions: [
          home != null
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => BottomBarPage(2)),
                        (Route<dynamic> route) => false);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 15, right: 17, bottom: 15, left: 13),
                      child: SvgPicture.asset(
                        "${home}",
                        height: 20,
                        color: Colors.white,
                      )),
                )
              : Text(''),
          if (action2 != null)
            GestureDetector(onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NotificationScreen();
                },
              ));
              globals.screenstack++;
            }, child: Consumer<NotificationCountProvider>(
                builder: (context, value, child) {
              return value.notifications == 0
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 15, right: 17, bottom: 15, left: 13),
                      child: SvgPicture.asset(
                        "${action2}",
                      ),
                    )
                  : Badge(
                      // toAnimate: false,
                      badgeContent: Text(
                        value.notifications > 99
                            ? '99+'
                            : '${value.notifications}',
                        style: TextStyle(color: Colors.white),
                      ),
                      position: BadgePosition.topEnd(top: 5, end: 10),
                      animationType: BadgeAnimationType.fade,
                      padding: EdgeInsets.all(4),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 15, right: 17, bottom: 15, left: 13),
                        child: SvgPicture.asset(
                          "${action2}",
                        ),
                      ));
            })),
          //   Container(
          //       padding:
          //           EdgeInsets.only(top: 15, right: 17, bottom: 15, left: 13),
          //       child: SvgPicture.asset(
          //         "${action2}",
          //       )),
          // ),
        ],
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 15.w,
            fontFamily: 'Poppins1',
            color: textIconColor,
          ),
        ),
        backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
