// ignore_for_file: unused_local_variable, deprecated_member_use
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/car_brand_bloc.dart';
import 'package:imechano/ui/modal/car_brand_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/auth/landing/view/sign_in_sign_up_landing_screen.dart';
import 'package:imechano/ui/screens/select_car/view/ford_screen.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:provider/provider.dart';

class SelectYourCarScreen extends StatefulWidget {
  final AddCarType type;
  const SelectYourCarScreen({Key? key, required this.type}) : super(key: key);

  @override
  _SelectYourCarScreenState createState() => _SelectYourCarScreenState();
}

class _SelectYourCarScreenState extends State<SelectYourCarScreen> {
  bool submit = false;
  dynamic appModelTheme;
  var userStr;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    log('SelectYourCarScreen');
    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;
    carbrandBloc.carbrandblocSink();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
      key: scaffoldKey,
      drawer: drawerpage(),
      appBar: WidgetAppBar(
        title: getTranslated('SelectyourCar', context),
        menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action2: 'assets/svg/ball.svg',
      ),
      body: PrefObj.preferences!.containsKey(PrefKeys.USER_DATA)
          ? Container(
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                color: appModelTheme.darkTheme ? Color(0xff252525) : white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: StreamBuilder<CarBrandModel>(
                  stream: carbrandBloc.carbrandListStream,
                  builder: (context,
                      AsyncSnapshot<CarBrandModel> allcarbrandsnapshot) {
                    if (!allcarbrandsnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowGlow();
                        return true;
                      },
                      child: GridView.builder(
                        itemCount: allcarbrandsnapshot.data!.data!.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          log(allcarbrandsnapshot.data!.data![index].logo!);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FordScreen(
                                            carLogo: allcarbrandsnapshot
                                                .data!.data![index].logo!,
                                            data: allcarbrandsnapshot
                                                .data!.data![index].id
                                                .toString(),
                                            brand: allcarbrandsnapshot
                                                .data!.data![index].brand!,
                                            type: widget.type,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: appModelTheme.darkTheme
                                          ? darkmodeColor
                                          : grayE6E6E5),
                                  borderRadius: BorderRadius.circular(12),
                                  color: appModelTheme.darkTheme
                                      ? darkmodeColor
                                      : white),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: size.width * 0.15,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Image.network(
                                        allcarbrandsnapshot
                                            .data!.data![index].logo!,
                                        fit: BoxFit.contain,
                                        cacheHeight: 900,
                                        filterQuality: FilterQuality.medium,
                                        errorBuilder:
                                            (context, object, stackTrace) =>
                                                Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Text(allcarbrandsnapshot
                                      .data!.data![index].brand!)
                                ],
                              )),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            )
          : _body2(),
    );
  }

  Widget _body2() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/imechano-logo.svg",
            height: MediaQuery.of(context).size.height * 0.11,
            color: appModelTheme.darkTheme ? white : null,
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: MaterialButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInSignUpLandingScreen(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
