import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/provider/notification_count_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/job_card_details.dart';
import 'package:imechano/ui/screens/my_account/progress_report_active.dart';
import 'package:provider/provider.dart';

class Utils {
  static void handleNotificationNavigation(BuildContext context,
      [RemoteMessage? message, String? title, String? jobNo]) {
    try {
      var str = title ?? message!.data.toString();
      log('Notification Message : ' + str);
      log('GOT DATA FROM APPROVE JOB CARD ${message?.data}, JOB NO:  ${message?.data['job_number']}');
      Provider.of<NotificationCountProvider>(Get.context!, listen: false)
          .setNotifications();
      if (str.contains('Pickup') && str.contains('Accept') ||
          (str.contains('Pickup Confirmation Request')) ||
          (str.contains('Accept Booking')) ||
          str.contains("قبول الحجز") ||
          str.contains("ب تأكيد الاستلام")) {
        currentBookingTab = 3;
        screenstack++;
        Get.offAll(() => BottomBarPage(1));
      } else if (str.contains('Reject Booking')) {
        currentBookingTab = 2;
        screenstack++;
        Get.offAll(() => BottomBarPage(1));
      } else if (str.contains('Job Card') ||
          str.contains("تم تحميل بطاقة العمل")) {
        String? jobNumber = jobNo ?? message!.data['job_number'];
        if (jobNumber == null) return;
        print("show Job Card Page");
        currentJobcardTab = 0;
        screenstack++;

        Get.to(() => MyJobCardDetails(job_number: jobNumber));
      } else if (str.contains('Task Completed') ||
          str.contains("تمت المهمة") ||
          str.contains('Please Confirm Delivery') ||
          str.contains('Delivery Request') ||
          str.contains("طلب توصيل")) {
        String? jobNumber = jobNo ?? message!.data['job_number'];
        log('jobNumber $jobNumber');
        log('Before job number == null');
        if (jobNumber == null) return;
        log('After job number == null');
        currentJobcardTab = 3;
        screenstack++;
        log('Navigate now');
        Get.to(() => ProgressReportActive(job_number: jobNumber));
      }
    } on Exception catch (e) {
      log('Expection caught in handle notification navigation: $e');
    } catch (e) {
      log('Expection caught in handle notification navigation: $e');
    }
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
