// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart' as globals;
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/My_Bookings_Page.dart';
import 'package:imechano/ui/screens/bottombar/my_job_card.dart';
import 'package:imechano/ui/screens/bottombar/my_selection_screen.dart';
import 'package:imechano/ui/screens/my_account/home.dart';
import 'package:imechano/ui/screens/select_car/view/my_vehical_screen.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

import '../../share_preferences/pref_key.dart';

class BottomBarPage extends StatefulWidget {
  int checkCondition;
  BottomBarPage(this.checkCondition);

  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  // ignore: unused_field
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int selectedIndex = 2;

  List navigationButtomBar = [
    Myvehicalscreen(),
    MyBookingsPage(),
    HomeScreen(),
    MyJobCard(),
    MySelectionPage(
      selectedService: globals.selectedService,
      categoryName: globals.catogoryName,
      categoryId: "1",
      currentCount: globals.currentCount,
    )

    // AccordionPage(),
    // ProfilePage()
  ];

  bool selecteicon = false;
  dynamic appModelTheme;

  @override
  void initState() {
    print("initializing");
    super.initState();
    selectedIndex = widget.checkCondition;
    BackButtonInterceptor.add(myInterceptor, context: context);
  }

  @override
  void dispose() {
    print("disposing");
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (stopDefaultButtonEvent) return false;

    if (Navigator.canPop(context)) {
      // If there is a previous screen, pop it off the stack
      Navigator.of(context, rootNavigator: true).pop(context);
    } else if (selectedIndex != 2) {
      // If we are not on the home screen, navigate back to it
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBarPage(2),
        ),
      );
    } else {
      // If we are on the home screen, prompt the user to exit the app
      showDialog(
        builder: (_) => AlertDialog(
          title: Text(getTranslated('exitapp', context)),
          content: Text(getTranslated('doyouwanttoexitanapp', context)),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(_).pop(false),
              //return false when click on "NO"
              child: Text(getTranslated('no', context)),
            ),
            ElevatedButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  PrefObj.preferences!.put(PrefKeys.APPSTARTED, true);

                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  PrefObj.preferences!.put(PrefKeys.APPSTARTED, true);

                  exit(0);
                }
              },
              //return true when click on "Yes"
              child: Text(getTranslated('yes', context)),
            ),
          ],
        ),
        context: context,
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: widget.checkCondition,
            // index: selectedIndex!.toInt(),
            height: 60.0,
            items: <Widget>[
              selectedIndex == 0
                  ? Icon(Icons.directions_car, size: 33, color: Colors.white)
                  : Icon(Icons.directions_car,
                      size: 33,
                      color: appModelTheme.darkTheme ? white : Colors.grey),
              selectedIndex == 1
                  ? Icon(Icons.calendar_today, size: 30, color: Colors.white)
                  : Icon(Icons.calendar_today,
                      size: 30,
                      color: appModelTheme.darkTheme ? white : Colors.grey),
              selectedIndex == 2
                  ? Icon(Icons.home, size: 30, color: Colors.white)
                  : Icon(Icons.home,
                      size: 30,
                      color: appModelTheme.darkTheme ? white : Colors.grey),
              selectedIndex == 3
                  ? Icon(Icons.work, size: 30, color: Colors.white)
                  : Icon(Icons.work,
                      size: 30,
                      color: appModelTheme.darkTheme ? white : Colors.grey),
              selectedIndex == 4
                  ? ImageIcon(AssetImage('assets/images/toolbox_filled.png'),
                      color: Colors.white)
                  // ? Icon(Icons.pan_tool_sharp, size: 30, color: Colors.white)
                  : ImageIcon(AssetImage('assets/images/toolbox_filled.png'),
                      color: appModelTheme.darkTheme ? white : Colors.grey),
            ],
            color:
                appModelTheme.darkTheme ? darkmodeColor : Colors.grey.shade200,
            buttonBackgroundColor: logoBlue,
            backgroundColor:
                appModelTheme.darkTheme ? Color(0xff252525) : white,
            animationCurve: Curves.easeInExpo,
            animationDuration: Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            // letIndexChange: (index) => true,
          ),
          body: navigationButtomBar[selectedIndex]),
    );
  }
}
