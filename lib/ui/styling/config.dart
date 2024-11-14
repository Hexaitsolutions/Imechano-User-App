import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Config {
  // //Api Url
  // static const String apiurl = 'https://imechano.com/api/';
  // static const String profileurl = 'https://imechano.com/storage/app/';
  // static const String imageurl = 'https://imechano.com/storage/';
  // //===============RAJA OMER===========
  // static const String apiurl = 'http://imechano.rajaomermustafa.com/api/';
  // static const String profileurl =
  //     'http://imechano.rajaomermustafa.com/storage/app/';
  // static const String imageurl = 'http://imechano.rajaomermustafa.com/storage/';
  //===============IMECHANO===========
  static const String apiurl = 'http://admin.imechano.com/api/';
  static const String profileurl = 'http://admin.imechano.com/storage/app/';
  static const String imageurl = 'http://admin.imechano.com/storage/';
  //Api End Points
  static const String rejectbooking = 'reject-booking';
  static const String login = 'login';
  static const String registered = 'register';
  static const String uploadprofile = 'upload-profile';
  static const String editcar = 'edit-car';
  static const String delete_notifications = 'delete-notification';
  static const String addcar = 'add-car';
  static const String carbrand = 'car-brand';
  static const String categories = 'category-list';
  static const String oilchange = 'sub-category-list';
  static const String carList = 'car-list';
  static const String cardetails = 'select-car-details';
  static const String brandmodellist = 'brand-model';
  static const String customer_job_list = 'customer-job-list';
  static const String itemlist = 'item-list';
  static const String userprofile = 'user-profile';
  static const String forgetpassword = 'forgot-password';
  static const String otpverify = 'otp-verified';
  static const String resetpassword = 'reset-password';
  static const String carbooking = 'car-booking';
  static const String emergencycarbooking = 'emergency-booking';
  static const String checkupbooking = 'checkup-booking';
  static const String quickbooking = 'quick-booking';
  static const String detailingbooking = 'detailing-booking';
  static const String accept_delivery_request = 'accept-delivery-request';
  static const String bookinglist = 'booking-list';
  static const String jobcardslist = 'job-cards-list';
  static const String deleteCar = 'delete-car';
  static const String cancelBooking = 'cancel-booking';
  static const String sendadmin = 'send_admin';
  static const String viewparts = 'view-parts';
  static const String viewitems = 'view-items';
  static const String viewservice = 'view-service';
  static const String notification_list = 'customer-notification-list';
  static const String updateNotificationStatus = 'update-notification-status';
  static const String deleteNotifications = 'delete-notification';
  static const String approvedchargesbycustomer =
      'approved-charges-by-customer';
  static const String acceptpickuprequest = 'accept-pickup-request';
  static const String rejectpickuprequest = 'reject-pickup-request';
  static const String appoiementList = 'appoiement_List';
  static const String deleteservice = 'delete-service';
  static const String deleteparts = 'delete-parts';
  static const String customerjobdetails = 'customer-job-details';
  static const String pickup_condition_list = 'pickup-condition-list';
  static const String approve_jobcard = 'approve-jobcard';
  static const String cancel_jobcard = 'cancel-jobcard';
  static const String jobCardPayment = 'job-card-payment';
  static const String listOfInvoices = 'list-of-invoices';
  static const String bookingInvoices = 'booking-invoices';
  static const String viewInvoice = 'view-invoice';
}

Widget carddivider(String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey[500],
          fontFamily: 'Poppins3',
          fontSize: 11,
        ),
      ),
      Container(
        constraints: BoxConstraints(maxWidth: 100.w),
        child: Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 10,
          ),
          overflow: TextOverflow
              .ellipsis, // Handle overflow by truncating text with ellipsis.
          maxLines: 2, // Set the maximum number of lines
        ),
      ),
    ],
  );
}
