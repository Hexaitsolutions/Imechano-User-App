// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:imechano/api/notification_api.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/customer_notification_list_bloc.dart';
import 'package:imechano/ui/modal/customer_notification_list_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/my_job_card.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/shared/widgets/confirmation_dialog.dart';
import 'package:imechano/ui/shared/widgets/show_alert_dialog.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:imechano/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:imechano/ui/common/globals.dart' as globals;

import '../../provider/notification_count_provider.dart';
import '../../share_preferences/pref_key.dart';
import '../../share_preferences/preference.dart';
import '../bottombar/My_Bookings_Page.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSwitch = true;
  dynamic appModelTheme;

  @override
  void initState() {
    super.initState();
    print("Notification page");
    Provider.of<NotificationCountProvider>(context, listen: false)
        .setNotifications();
    if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
      customerNotificationListBloc
          .notificationListSinck(PrefObj.preferences!.get(PrefKeys.USER_ID));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
        appBar: WidgetAppBar(
          title: getTranslated('notification', context),
          menuItem: 'assets/svg/Menu.svg',
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          action: 'assets/svg/shopping-cart.svg',
          home: 'assets/svg/homeicon.svg',
        ),
        drawer: drawerpage(),
        backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowGlow();
              return true;
            },
            child: SafeArea(
              child: Column(children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: appModelTheme.darkTheme
                          ? Color(0xff252525)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        notificationSwitch(),
                        SizedBox(height: 5.h),
                        StreamBuilder<CustomerNotificationListModel>(
                            stream: customerNotificationListBloc
                                .notificationListStream,
                            builder: (context,
                                AsyncSnapshot<CustomerNotificationListModel>
                                    notificationListSnapshot) {
                              if (!notificationListSnapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.separated(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                    notificationListSnapshot.data!.data!.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: notificationListSnapshot
                                                .data!.data![index].status ==
                                            '1'
                                        ? grayE6E6E5
                                        : greycolo.withOpacity(0.5),
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () async {
                                        if (notificationListSnapshot
                                                .data!.data![index].status ==
                                            '0') {
                                          bool response = await NotificationApi
                                              .updateNotificationStatus(
                                                  notificationListSnapshot
                                                      .data!.data![index]);
                                          log('$response');
                                        }

                                        String? str = notificationListSnapshot
                                            .data!.data![index].title!;
                                        String? jobNo = notificationListSnapshot
                                            .data!.data![index].jobNo;
                                        Utils.handleNotificationNavigation(
                                            context, null, str, jobNo);
                                      },
                                      title: Row(
                                        children: [
                                          Text(
                                            getTranslated(
                                                notificationListSnapshot
                                                    .data!
                                                    .data![index]
                                                    .title!
                                                    .removeAllWhitespace,
                                                context),
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Poppins3'),
                                          ),
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox()),
                                          Text(
                                            DateFormat('hh:mm a dd-MM-yy')
                                                .format(DateTime.parse(
                                                    notificationListSnapshot
                                                        .data!
                                                        .data![index]
                                                        .updatedAt!)),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Poppins3'),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        getTranslated(
                                            notificationListSnapshot
                                                .data!
                                                .data![index]
                                                .message!
                                                .removeAllWhitespace,
                                            context),
                                      ),
                                      leading: Image(
                                          height: 10,
                                          image: notificationListSnapshot.data!
                                                      .data![index].status ==
                                                  '1'
                                              ? AssetImage(
                                                  "assets/icons/My Account/Ellipse 27.png")
                                              : AssetImage(
                                                  "assets/icons/My Account/Ellipse 27-1.png")),
                                    ),
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                )),
              ]),
            ),
          ),
        ));
  }

  Widget notificationSwitch() {
    return Row(
      children: [
        Container(
          height: 20.h,
          child: Image(
            height: 25.h,
            image: AssetImage(
                "assets/icons/My Account/notifications_black_24dp.png"),
          ),
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
        ),
        Expanded(
          child: Text(
            getTranslated("notification", context),
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ConfirmationDialog(
                        message: 'delete all notifications?',
                        onYesPressed: () async {
                          Loader().showLoader(context);
                          bool response =
                              await NotificationApi.deleteAllNotifications();
                          if (response) {
                            await Provider.of<NotificationCountProvider>(
                                    context,
                                    listen: false)
                                .setNotifications();
                            if (PrefObj.preferences!
                                .containsKey(PrefKeys.USER_ID)) {
                              await customerNotificationListBloc
                                  .notificationListSinck(PrefObj.preferences!
                                      .get(PrefKeys.USER_ID));
                              setState(() {});
                            }
                          }

                          Loader().hideLoader(context);
                          Navigator.pop(context);
                        });
                  });
            },
            icon: Icon(Icons.delete, color: red)),
        Switch(
          activeColor: Colors.blue,
          value: isSwitch,
          onChanged: (value) {
            setState(() {
              isSwitch = value;
            });
          },
        )
      ],
    );
  }
}
