import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/carlist_bloc.dart';
import 'package:imechano/ui/modal/carList_modelclass.dart';
import 'package:imechano/ui/modal/delete_car_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/select_car/view/select_your_car_screen.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:provider/provider.dart';

import '../../auth/sign_in/view/sign_in_screen.dart';
import 'ford_screen.dart';

class Myvehicalscreen extends StatefulWidget {
  final String? id;

  final Function? refreshData;
  const Myvehicalscreen({this.id, this.refreshData});
  @override
  _MyvehicalscreenState createState() => _MyvehicalscreenState();
}

class _MyvehicalscreenState extends State<Myvehicalscreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  dynamic appModelTheme;
  String carid = '';
  var userSt;
  Repository repository = Repository();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    log('my_vehical_screen');
    userSt = PrefObj.preferences!.containsKey(PrefKeys.USER_ID) ? true : false;
    if (userSt == null) userSt = false;
    if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
      carListListBloc.carListSinck(PrefObj.preferences!.get(PrefKeys.USER_ID));
    }
    if (PrefObj.preferences!.containsKey(PrefKeys.CARID)) {
      carid = PrefObj.preferences!.get(PrefKeys.CARID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarPage(2)));
          return true;
        },
        child: Scaffold(
          drawer: drawerpage(),
          key: _key,
          backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
          body: Column(
            children: [
              SizedBox(height: 40),
              appbarWidget(),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          appModelTheme.darkTheme ? Color(0xff252525) : white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: userSt ? bmw07series() : _body2()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appbarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            print("Pressed");
            setState(() {
              _key.currentState!.openDrawer();
            });
          },
          child: Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              color: Colors.transparent,
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 17, right: 17),
              child: SvgPicture.asset("assets/svg/Menu.svg",
                  height: 18.h, width: 18.w)),
        ),
        Center(
            child: Text(
          getTranslated('myvehicle', context),
          style:
              TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp, color: white),
        )),
        InkWell(
          onTap: () async {
            log("BACK");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SelectYourCarScreen(type: AddCarType.add)));
          },
          child: Container(
              padding:
                  EdgeInsets.only(top: 20, right: 17, bottom: 20, left: 13),
              child: Icon(Icons.add, color: white)),
        ),
      ],
    );
  }

  Widget _body2() {
    return Container(
      width: double.infinity,
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SignInScreen();
                  },
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body3() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Center(
          child: Text(
        'Data Not Found',
        style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
      )),
    );
  }

  Widget bmw07series() {
    return StreamBuilder<CarListModelClass>(
        stream: carListListBloc.CarListStream,
        builder: (context, AsyncSnapshot<CarListModelClass> carListsnapshort) {
          if (!carListsnapshort.hasData ||
              carListsnapshort.data!.data!.isEmpty) {
            return Center(
                child: carListsnapshort.data == null
                    ? CircularProgressIndicator()
                    : Text(
                        'No Data Found',
                        style:
                            TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                      ));
          }
          return Container(
            padding: EdgeInsets.only(top: 5),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                  itemCount: carListsnapshort.data!.data!.length,
                  // reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    int reverseIndex =
                        carListsnapshort.data!.data!.length - 1 - index;
                    log("Image URL: http://imechano.rajaomermustafa.com/storage/${carListsnapshort.data!.data![reverseIndex].image}");

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 17,
                            right: 17,
                            top: 18,
                            bottom:
                                index == carListsnapshort.data!.data!.length - 1
                                    ? 18
                                    : 0),
                        decoration: BoxDecoration(
                            color:
                                appModelTheme.darkTheme ? darkmodeColor : white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: grayE6E6E5),
                            boxShadow: [
                              BoxShadow(
                                color: appModelTheme.darkTheme
                                    ? Colors.black45
                                    : Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.h),
                                Text(
                                  carListsnapshort
                                      .data!.data![reverseIndex].model!,
                                  style: TextStyle(fontFamily: "Poppins2"),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getTranslated('CylinderType:-One',
                                                      context) +
                                                  " " ":-${carListsnapshort.data!.data![reverseIndex].cylinder} ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Poppins3"),
                                            ),
                                            Text(
                                              getTranslated('PlateNumber:-666',
                                                      context) +
                                                  " " ":-${carListsnapshort.data!.data![reverseIndex].plateNumber} ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Poppins3"),
                                            ),
                                            Text(
                                              getTranslated(
                                                      'Mileage', context) +
                                                  " " ":-${carListsnapshort.data!.data![reverseIndex].mileage} ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Poppins3"),
                                            ),
                                            Text(
                                              getTranslated(
                                                      'ModelYear', context) +
                                                  " " ":-${carListsnapshort.data!.data![reverseIndex].modelYear} ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Poppins3"),
                                            ),
                                            //  ${getTranslated('PlateNumber:-666', context)!}:- ${carListsnapshort.data!.data![reverseIndex].plateNumber}
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: 120.w,
                                          child: Image.network(
                                              "${Config.imageurl}/${carListsnapshort.data!.data![reverseIndex].image}",
                                              fit: BoxFit.contain),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        ButtonTheme(
                                          height: 30,
                                          minWidth: 82.w,
                                          child: MaterialButton(
                                            child: Text(
                                              getTranslated(
                                                  'Editdetails', context),
                                              style: TextStyle(
                                                  fontSize: 10.0.sp,
                                                  color: Colors.white,
                                                  fontFamily: "Poppins1"),
                                            ),
                                            color: logoBlue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () {
                                              Map postData = {
                                                'model': carListsnapshort.data!
                                                    .data![reverseIndex].model,
                                                'cylinder': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .cylinder,
                                                'mileage': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .mileage,
                                                'model_year': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .modelYear,
                                                'plate_number': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .plateNumber,
                                                'chases_number':
                                                    carListsnapshort
                                                        .data!
                                                        .data![reverseIndex]
                                                        .chasesNumber,
                                                'branId': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .brandId,
                                                'fuelType': carListsnapshort
                                                    .data!
                                                    .data![reverseIndex]
                                                    .fuelType,
                                              };
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FordScreen(
                                                            data: carListsnapshort
                                                                .data!
                                                                .data![
                                                                    reverseIndex]
                                                                .brandId
                                                                .toString(),
                                                            brand: '',
                                                            carLogo:
                                                                "${Config.imageurl}/${carListsnapshort.data!.data![reverseIndex].image}",
                                                            type:
                                                                AddCarType.edit,
                                                            carData: postData,
                                                            carId: carListsnapshort
                                                                .data!
                                                                .data![
                                                                    reverseIndex]
                                                                .id,
                                                            callBackFunction:
                                                                (_) {
                                                              carListListBloc
                                                                  .carListSinck(PrefObj
                                                                      .preferences!
                                                                      .get(PrefKeys
                                                                          .USER_ID));
                                                            },
                                                          )));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              log("Delete index:" +
                                                  index.toString());
                                              confirmDeleteDialog(
                                                  carListsnapshort.data!.data,
                                                  reverseIndex);

                                              // deleteCarBloc.deleteCarSinck(
                                              //     carListsnapshort
                                              //         .data!.data![index].id
                                              //         .toString());
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 82.w,
                                            decoration: BoxDecoration(
                                                color: logoBlue,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Text(
                                                getTranslated(
                                                    'deletecar', context),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.0.sp,
                                                    fontFamily: "Poppins1"),
                                              ),
                                            ),
                                            // OutlineButton(
                                            //   child: Text(
                                            //     "Delete Car",
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 10.0.sp,
                                            //         fontFamily: "Poppins1"),
                                            //   ),
                                            //   color: logoBlue,
                                            //   highlightedBorderColor: Colors.red,
                                            //   shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(20)),
                                            //   onPressed: () {
                                            //     setState(() {
                                            //       deleteCarApiCall(
                                            //           carListsnapshort.data!.data,
                                            //           index);
                                            //       // deleteCarBloc.deleteCarSinck(
                                            //       //     carListsnapshort
                                            //       //         .data!.data![index].id
                                            //       //         .toString());

                                            //       widget.refreshData!(true);
                                            //     });
                                            //   },
                                            // ),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            PrefObj.preferences!.put(
                                                PrefKeys.CARID,
                                                carListsnapshort.data!
                                                    .data![reverseIndex].id);

                                            PrefObj.preferences!.put(
                                                PrefKeys.CARNAME,
                                                carListsnapshort.data!
                                                    .data![reverseIndex].model);

                                            carid = PrefObj.preferences!
                                                .get(PrefKeys.CARID);
                                            setState(() {
                                              //   Navigator.pushReplacementUn(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               BottomBarPage(2)));

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BottomBarPage(2)),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 82.w,
                                            decoration: BoxDecoration(
                                                color: logoBlue,
                                                border: Border.all(
                                                    color:
                                                        red.withOpacity(0.1)),

                                                // color: PrefObj.preferences!.get(
                                                //             PrefKeys.CARID) ==
                                                //         carListsnapshort
                                                //             .data!.data![index].id
                                                //     ? logoBlue
                                                //     : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Text(
                                                getTranslated(
                                                    'SelectCar', context),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.0.sp,
                                                    fontFamily: "Poppins1"),
                                              ),
                                            ),
                                            //  OutlineButton(
                                            //   child: Text(
                                            //     "Select Car",
                                            //     style: TextStyle(
                                            //         fontSize: 10.0.sp,
                                            //         fontFamily: "Poppins1"),
                                            //   ),
                                            //   color: Colors.white,
                                            //   highlightedBorderColor: Colors.red,
                                            //   shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(20)),
                                            //   onPressed: () {
                                            //     PrefObj.preferences!.put(
                                            //         PrefKeys.CARID,
                                            //         carListsnapshort
                                            //             .data!.data![index].id);

                                            //     PrefObj.preferences!.put(
                                            //         PrefKeys.CARNAME,
                                            //         carListsnapshort.data!
                                            //             .data![index].model);

                                            //     carid = PrefObj.preferences!
                                            //         .get(PrefKeys.CARID);
                                            //     setState(() {
                                            //       Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (context) =>
                                            //                   BottomBarPage(2)));
                                            //     });
                                            //   },
                                            // ),
                                          ),
                                        ),
                                        SizedBox(width: 30.w)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }

  // snackBar Widget
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  deleteCarApiCall(List<Data>? carData, int index) async {
    Loader().showLoader(context);
    print("id to delete:");
    print(carData![index].id);
    final DeleteCarModel isdeletecar = await repository.DeleteCarAPI(
      carData[index].id!,
    );

    if (isdeletecar.code == '1') {
      Loader().hideLoader(context);

      snackBar(isdeletecar.message ?? 'Car Delete Successfully');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarPage(0),
          ));
      log('Car already Selected:' + PrefObj.preferences!.get(PrefKeys.CARNAME));
      if (carData[index].id == PrefObj.preferences!.get(PrefKeys.CARID)) {
        log('on delete index:' + index.toString() + ', ');
        PrefObj.preferences!.put(PrefKeys.CARNAME, "");
      }
      //
      // }
      // carListListBloc.carListSinck(PrefObj.preferences!.get(PrefKeys.USER_ID));
    } else {
      print("Status Failed");
      Loader().hideLoader(context);
      showpopDialog(context, 'Error', isdeletecar.message ?? '');
    }
  }

  void confirmDeleteDialog(List<Data>? data, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Column(
            children: [
              Text(
                "" + data![index].model.toString(),
                style: TextStyle(fontFamily: "Poppins2"),
              ),
              SizedBox(height: 15.h),
              Text(
                getTranslated('AreyousureyouwanttoDelete?', context),
                style: TextStyle(fontSize: 15.sp, fontFamily: "Poppins1"),
              )
            ],
          )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    child: Text(
                      getTranslated('Cancel', context),
                      style: TextStyle(color: logoBlue, fontFamily: "Poppins1"),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text(getTranslated('delete', context),
                        style: TextStyle(
                            color: Colors.redAccent, fontFamily: "Poppins1")),
                    onPressed: () {
                      log('seleted index to delete: ' + index.toString());
                      deleteCarApiCall(data, index);
                      // Navigator.of(context).pop();
                      // widget.refreshData!(true);
                    })
              ],
            ),
          ],
        );
      },
    );
  }
}
