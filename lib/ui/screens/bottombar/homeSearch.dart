import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart' as globals;
import 'package:imechano/ui/provider/Data1.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/categories_bloc.dart';
import '../../bloc/oil change bloc.dart';
import '../../modal/categoriesModelClass.dart';
import '../../modal/oilchange_model.dart';
import '../../provider/theme_provider.dart';
import '../../share_preferences/pref_key.dart';
import '../../share_preferences/preference.dart';
import '../../styling/colors.dart';
import '../my_account/Notification.dart';
import '../my_account/oil_change.dart';
import 'bottom_bar.dart';

class Jobs extends StatefulWidget {
  Jobs() : super();

  @override
  JobsState createState() => JobsState();
}

class JobsState extends State<Jobs> {
  bool isCarAdded = false;
  dynamic appModelTheme;
  var address;
  var dataLoad;
  var userStr;
  bool checkExpansionTile = false;

  Map<String, String> arabicToEnglish = {
    'ا': 'A',
    'ب': 'B',
    'ت': 'T',
    'ث': 'TH',
    'ج': 'J',
    'ح': 'H',
    'خ': 'KH',
    'د': 'D',
    'ذ': 'DH',
    'ر': 'R',
    'ز': 'Z',
    'س': 'S',
    'ش': 'SH',
    'ص': 'S',
    'ض': 'D',
    'ط': 'T',
    'ظ': 'Z',
    'ع': 'A',
    'غ': 'GH',
    'ف': 'F',
    'ق': 'Q',
    'ك': 'K',
    'ل': 'L',
    'م': 'M',
    'ن': 'N',
    'ه': 'H',
    'و': 'W',
    'ي': 'Y',
    'ء': 'A',
    'آ': 'AA',
    'أ': 'A',
    'ؤ': 'W',
    'إ': 'I',
    'ئ': 'Y',
    'ئ': 'Y',
    'ة': 'H',
  };

  String convertArabicToEnglish(String arabicText) {
    String englishText = '';
    for (int i = 0; i < arabicText.length; i++) {
      String arabicLetter = arabicText[i];
      if (arabicToEnglish.containsKey(arabicLetter)) {
        englishText += arabicToEnglish[arabicLetter]!;
      } else {
        englishText +=
            arabicLetter; // If no mapping is found, keep the original letter
      }
    }
    return englishText;
  }

  void _runFilter(String enteredKeyword) {
    // enteredKeyword = convertArabicToEnglish(enteredKeyword);
    print("Search keyword");
    print(enteredKeyword);
    if (enteredKeyword.length < 1) {
    } else {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        categoriesListBloc.categoriesSinck(enteredKeyword);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoriesListBloc.categoriesSinck("null");
    print("I am disposed");
  }

  @override
  void initState() {
    print("initializing");
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getAddress();
    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;
    isCarAdded =
        PrefObj.preferences!.containsKey(PrefKeys.CARNAME) ? true : false;
    categoriesListBloc.categoriesSinck("null");
    oilchnageListBloc.oilChnageSinck('1');
  }

  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address') ?? 'Select your address';

      dataLoad = true;

      print(address);
    });
  }

  Future<bool> _willPopCallback() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    print(convertArabicToEnglish("س"));
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BottomBarPage(2)),
            (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
          backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
          appBar: WidgetAppBar(
            title: getTranslated('Searchservice', context),
            menuItem: 'assets/svg/Menu.svg',
            home: 'assets/svg/homeicon.svg',

            // action: 'assets/svg/shopping-cart.svg',
            action2: 'assets/svg/ball.svg',
          ),
          drawer: drawerpage(),
          body: ScreenUtilInit(
            designSize: Size(414, 896),
            builder: () =>
                NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          focusNode: FocusNode(),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: appModelTheme.darkTheme
                                ? Colors.black
                                : Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            suffixIcon: InkWell(
                              child: Icon(Icons.search),
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: getTranslated("search", context),
                          ),
                          onChanged: (value) {
                            _runFilter(value);
                          },
                        ),
                      ),
                      StreamBuilder<CategoriesModelClass>(
                          stream: categoriesListBloc.CategoryListStream,
                          builder: (context,
                              AsyncSnapshot<CategoriesModelClass>
                                  categoriesSnapshot) {
                            if (!categoriesSnapshot.hasData) {
                              return Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  )),
                                ),
                              );
                            }
                            if (categoriesSnapshot.data!.data!.length == 0) {
                              return Container(
                                  height: 280,
                                  alignment: Alignment.center,
                                  child: Text("No Service Found"));
                            }

                            if (categoriesSnapshot.data!.data!.length == 1) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    containerCard(categoriesSnapshot),
                                  ],
                                ),
                              );
                            }

                            return Column(
                              children: [
                                SizedBox(height: 14),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      containerCard(categoriesSnapshot),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void showSelectCarDialog() {
    showDialog(
      builder: (_) => AlertDialog(
        title: Text(getTranslated("Nocarselected!", context)),
        content: Text(getTranslated('Pleaseselectacartoproceed', context)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(_).pop(false),
            //return false when click on "NO"
            child: Text(getTranslated('close', context)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBarPage(0),
                    //  SelectYourCarScreen(
                    //     type: AddCarType.home)
                  ));
            },
            //return true when click on "Yes"
            child: Text(getTranslated('Select', context)),
          ),
        ],
      ),
      context: context,
    );
  }

  Widget containerCard(AsyncSnapshot<CategoriesModelClass> categoriesSnapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.zero,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     childAspectRatio: (118.w / 110.h),
        //     // mainAxisExtent: 110.h,
        //     crossAxisSpacing: 14.w,
        //     mainAxisSpacing: 14.h),
        itemCount: categoriesSnapshot.data!.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  // height: 110,
                  // width: 118,
                  // margin: EdgeInsets.only(top: 4.h, bottom: 5.h, left: 7.h, right: 5.h),
                  decoration: BoxDecoration(
                    color: appModelTheme.darkTheme
                        ? darkmodeColor
                        : Color(0xfff4f5f7),
                    // color: colorOne[index],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Icon(
                        Icons.search,
                        size: 10,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          if (categoriesSnapshot.data!.data![index].item_name !=
                              "")
                            Text(
                              getTranslated(
                                  categoriesSnapshot.data!.data![index]
                                      .item_name!.removeAllWhitespace,
                                  context),
                              style: TextStyle(
                                  fontSize: 10.w, fontFamily: 'Poppins1'),
                            ),
                          SizedBox(
                            width: 3,
                          ),
                          if (categoriesSnapshot.data!.data![index].item_name !=
                              "")
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                            ),
                          if (categoriesSnapshot
                                  .data!.data![index].subcategory_Name !=
                              "")
                            Text(
                              getTranslated(
                                  categoriesSnapshot.data!.data![index]
                                      .subcategory_Name!.removeAllWhitespace,
                                  context),
                              style: TextStyle(
                                  fontSize: 10.w, fontFamily: 'Poppins1'),
                            ),
                          SizedBox(
                            width: 2,
                          ),
                          if (categoriesSnapshot
                                  .data!.data![index].subcategory_Name !=
                              "")
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                            ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            getTranslated(
                                categoriesSnapshot.data!.data![index]
                                    .categoryName!.removeAllWhitespace,
                                context),
                            style: TextStyle(
                                fontSize: 10.w, fontFamily: 'Poppins1'),
                          ),
                        ],
                      ),
                      // Image(
                      //   image: NetworkImage(
                      //       "${categoriesSnapshot.data!.data![index].icon}"),
                      //   height: 60.h,
                      // ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                log("onTap 1101");
                if (!isCarAdded ||
                    PrefObj.preferences!
                            .get(PrefKeys.CARNAME)
                            .toString()
                            .length <
                        2) {
                  log("car not added");
                  showSelectCarDialog();
                  Fluttertoast.showToast(
                      msg: getTranslated("Pleaseselectacartoproceed", context),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black12,
                      textColor: Colors.black,
                      fontSize: 16.0);
                } else if (categoriesSnapshot
                        .data!.data![index].subcategory_id !=
                    null) {
                  // Loader().showLoader(context);
                  print("~~~~~~~~~~~~~~~~~~~~~~~");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => oil_Change(
                            mainCatogory: categoriesSnapshot
                                .data!.data![index].categoryName,
                            id: categoriesSnapshot
                                .data!.data![index].subcategory_id
                                .toString(),
                            categoryId: categoriesSnapshot.data!.data![index].id
                                .toString(),
                            categoryName: categoriesSnapshot
                                .data!.data![index].subcategory_Name
                                .toString(),
                            data: Data1(
                                id: categoriesSnapshot
                                    .data!.data![index].subcategory_id
                                    .toString(),
                                categoryId: categoriesSnapshot
                                    .data!.data![index].id
                                    .toString(),
                                name: categoriesSnapshot
                                    .data!.data![index].subcategory_Name
                                    .toString(),
                                counter: 0,
                                createdAt: categoriesSnapshot
                                    .data!.data![index].createdAt
                                    .toString(),
                                updatedAt: categoriesSnapshot
                                    .data!.data![index].updatedAt
                                    .toString(),
                                deletedAt: categoriesSnapshot
                                    .data!.data![index].deletedAt
                                    .toString(),
                                selected: List.generate(10, (i) => false),
                                selectedService: globals.selectedService),
                          )));
                } else {
                  oilchnageListBloc.oilChnageSinck(
                      categoriesSnapshot.data!.data![index].id!);
                  showMaterialModalBottomSheet(
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        padding: EdgeInsets.only(top: 5),
                        child: StreamBuilder<OilChangeModel>(
                            stream: oilchnageListBloc.OilchnageListStream,
                            builder: (context,
                                AsyncSnapshot<OilChangeModel> listSnapshot) {
                              if (!listSnapshot.hasData) {
                                return SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (notification) {
                                  notification.disallowIndicator();
                                  return true;
                                },
                                child: SingleChildScrollView(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 25, right: 25, top: 5),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_double_arrow_down_outlined,
                                                      size: 30,
                                                      color: Colors.blue[200],
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  getTranslated(
                                                      categoriesSnapshot
                                                          .data!
                                                          .data![index]
                                                          .categoryName!
                                                          .removeAllWhitespace,
                                                      context),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins1",
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: listSnapshot
                                                  .data!.data!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: appModelTheme
                                                                .darkTheme
                                                            ? Color(0xff373737)
                                                            : Color(0xfff4f5f7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {
                                                          Get.off(oil_Change(
                                                            mainCatogory:
                                                                categoriesSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .categoryName,
                                                            id: listSnapshot
                                                                .data!
                                                                .data![index]
                                                                .id!,
                                                            categoryId:
                                                                categoriesSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id!,
                                                            categoryName:
                                                                listSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .name!,
                                                            data: listSnapshot
                                                                .data!
                                                                .data![index],
                                                          ));
                                                        },
                                                        trailing: Text(
                                                          '',
                                                          style: TextStyle(
                                                              color: blueCOlor),
                                                        ),
                                                        title: Text(getTranslated(
                                                            listSnapshot
                                                                .data!
                                                                .data![index]
                                                                .name!
                                                                .removeAllWhitespace,
                                                            context)),
                                                      )),
                                                );
                                              },
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //         BorderRadius.circular(10),
                                            //     color: appModelTheme.darkTheme
                                            //         ? darkmodeColor
                                            //         : Color(0xfff4f5f7),
                                            //   ),
                                            //   child: ExpansionTile(
                                            //     title: Text(
                                            //       "Others",
                                            //       style: TextStyle(
                                            //           fontFamily: 'Poppins1',
                                            //           fontSize: 15.sp),
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(height: 10.h),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  );
                }
              });
        });
  }

  Widget appBarWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () async {
                Loader().showLoader(context);
                await categoriesListBloc.categoriesSinck("null");
                Loader().hideLoader(context);
                closeKeyboard(context);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BottomBarPage(2)),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 17),
                  child: Image.asset("assets/images/Arrow_alt_left.png",
                      height: 20.h, width: 20.w)),
            ),
            Text(
              getTranslated("Searchservice", context),
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                //Add Home Button Here
              },
              child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset(
                    "assets/images/toolbox.png",
                    height: 22.h,
                    width: 22.w,
                    color: white,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NotificationScreen();
                  },
                ));
              },
              child: Container(
                  padding:
                      EdgeInsets.only(top: 20, right: 17, bottom: 20, left: 13),
                  child: SvgPicture.asset("assets/svg/ball.svg",
                      height: 20.h, width: 20.w)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: SvgPicture.asset(
                    "assets/svg/Places.svg",
                    height: 20.h,
                    width: 20.w,
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  width: 216.w,
                  height: 40.h,
                  margin: EdgeInsets.only(left: 5.w),
                  child: PrefObj.preferences!.containsKey(PrefKeys.USER_DATA)
                      ? dataLoad == true
                          ? Text(
                              "$address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontFamily: 'Poppins3'),
                            )
                          : Text(
                              "No Location Found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins3'),
                            )
                      : Text(
                          getTranslated("search", context),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontFamily: 'Poppins3'),
                        )),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomBarPage(0),
                        //  SelectYourCarScreen(
                        //     type: AddCarType.home)
                      ));
                },
                // minWidth: 50.w,
                // padding: EdgeInsets.only(
                //     top: 2.5.h, bottom: 2.5.h, right: 10.w, left: 10.w),
                // height: 32.h,
                child: Row(
                  children: [
                    if (isCarAdded &&
                        PrefObj.preferences!
                                .get(PrefKeys.CARNAME)
                                .toString()
                                .length >
                            1) ...[
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        PrefObj.preferences!.get(PrefKeys.CARNAME),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins1",
                            fontSize: 13.sp),
                      ),
                    ] else ...[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        getTranslated('AddCar', context),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins1",
                            fontSize: 13.sp),
                      ),
                    ],
                  ],
                ),
                // shape: isCarAdded ? null : RoundedRectangleBorder(
                //   side: BorderSide(color: Colors.white, width: 1.5),
                //   borderRadius: BorderRadius.circular(5),
                // ) ,
              ),
            ],
          ),
        )
      ],
    );
  }
}
