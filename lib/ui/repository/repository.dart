// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imechano/ui/provider/accept_pickup_request_provider.dart';
import 'package:imechano/ui/provider/addcar_provider.dart';
import 'package:imechano/ui/provider/approve_job_card_provider.dart';
import 'package:imechano/ui/provider/approvedcharged_provider.dart';
import 'package:imechano/ui/provider/booking_invoices_provider.dart';
import 'package:imechano/ui/provider/booking_list_provider.dart';
import 'package:imechano/ui/provider/brand_model_List_Provider.dart';
import 'package:imechano/ui/provider/cancel_car_booking_provider.dart';
import 'package:imechano/ui/provider/cancel_job_card_provider.dart';
import 'package:imechano/ui/provider/car_booking_provider.dart';
import 'package:imechano/ui/provider/car_brand_provider.dart';
import 'package:imechano/ui/provider/car_checkup_booking_provider.dart';
import 'package:imechano/ui/provider/carlist_provider.dart';
import 'package:imechano/ui/provider/categories_provider.dart';
import 'package:imechano/ui/provider/cust_job_list_provider.dart';
import 'package:imechano/ui/provider/customer_notification_list_provider.dart';
import 'package:imechano/ui/provider/delete_car_provide.dart';
import 'package:imechano/ui/provider/delete_parts_provider.dart';
import 'package:imechano/ui/provider/editecar_Provider.dart';
import 'package:imechano/ui/provider/forget_password_provider.dart';
import 'package:imechano/ui/provider/item_list_provider.dart';
import 'package:imechano/ui/provider/list_of_invoices_provider.dart';
import 'package:imechano/ui/provider/login_provider.dart';
import 'package:imechano/ui/provider/oilchange_provider.dart';
import 'package:imechano/ui/provider/otp_verify_provider.dart';
import 'package:imechano/ui/provider/register_provider.dart';
import 'package:imechano/ui/provider/reject_booking.dart';
import 'package:imechano/ui/provider/reset_password_provider.dart';
import 'package:imechano/ui/provider/schedule_booking_provider.dart';
import 'package:imechano/ui/provider/select-car-details_provider.dart';
import 'package:imechano/ui/provider/send_notification_admin_provider.dart';
import 'package:imechano/ui/provider/service_delete_provider.dart';
import 'package:imechano/ui/provider/upload_profile_provider.dart';
import 'package:imechano/ui/provider/user_profile_provider.dart';
import 'package:imechano/ui/provider/view_parts_provider.dart';
import 'package:imechano/ui/provider/view_services_provider.dart';
import 'package:imechano/ui/styling/global.dart';

import '../provider/car_checkup_booking_provider.dart';
import '../provider/car_detailing_booking.dart';
import '../provider/emergency_car_booking_provider.dart';
import '../provider/job_cards_list_provider.dart';
import '../provider/pickup_condition_list_provider.dart';
import '../provider/quick_service_booking_provider.dart';
import '../provider/reject_pickup_request_provider.dart';
import '../provider/view_items_provider.dart';

class Repository {
  final LoginApi loginapi = LoginApi();
  final UploadApi uploadapi = UploadApi();
  final UserRegisterDetailsApi registerFirstApi = UserRegisterDetailsApi();
  final AddCarApi addcarApi = AddCarApi();
  final AllCarBrandApi carbrandApi = AllCarBrandApi();
  final editecarapi editcarApi = editecarapi();
  final CategoriesApi categoriesApi = CategoriesApi();
  final OilchangeApi oilchnageapi = OilchangeApi();
  final CarListApi carlistapi = CarListApi();
  final CarDetailsApi cardetails = CarDetailsApi();
  final brandmodellistapi bradmodel = brandmodellistapi();
  final ItemListApi itemlistapi = ItemListApi();
  final UserProfileApi userprofileapi = UserProfileApi();
  final rejectbooking = RejectBookingApi();
  final ForgetPasswordApi forgetpasswordApi = ForgetPasswordApi();
  final OtpVerifyApi otpverifyApi = OtpVerifyApi();
  final ResetPasswordApi resetpasswordApi = ResetPasswordApi();
  final CarBookingApi carbooking = CarBookingApi();
  final EmergencyCarBookingApi emergencycarbooking = EmergencyCarBookingApi();
  final quickServiceBookingApis quickServices = quickServiceBookingApis();
  final carDetailingBookingApis carDetailings = carDetailingBookingApis();
  final carCheckupbookingApis carcheckup = carCheckupbookingApis();
  final CustomerJobListAPI customerJobListAPI = CustomerJobListAPI();
  final ApproveJobCardApi acceptbooking = ApproveJobCardApi();
  final CancelJobCardApi cancelJobCardApi = CancelJobCardApi();
  final BookingListApi bookingListApi = BookingListApi();
  final JobCardsListApi jobcardsListApi = JobCardsListApi();

  final DeleteCarApi deleteCarApi = DeleteCarApi();
  final CancelCarBookingApi cancelCarBookingApi = CancelCarBookingApi();
  final SendNotificationAdminApi sendNotificationAdminApi =
      SendNotificationAdminApi();
  final CustomerNotificationListApi notificationListApi =
      CustomerNotificationListApi();
  final ApprovedchargedcustomerApi approvedchargedcustomerApi =
      ApprovedchargedcustomerApi();
  final AcceptPickuprequestAPI acceptPickuprequestAPI =
      AcceptPickuprequestAPI();
  final RejectPickuprequestAPI rejectPickuprequestAPI =
      RejectPickuprequestAPI();
  final ViewPartsDataAPI viewPartsDataAPI = ViewPartsDataAPI();
  final ViewItemsDataAPI viewItemsDataAPI = ViewItemsDataAPI();
  final ViewServicesDataAPI viewServicesDataAPI = ViewServicesDataAPI();
  final ListOfInvoicesApi listOfInvoicesApi = ListOfInvoicesApi();

  Future<dynamic> onViewItemsAPI(String job_number) =>
      viewItemsDataAPI.onViewItemsDataApi(job_number);

  final DeleteServiceAPI deleteServiceAPI = DeleteServiceAPI();

  final DeletepartsAPI deletepartsAPI = DeletepartsAPI();

  final ConditionListApi conditionlistapi = ConditionListApi();

  final ScheduleBookingAPI scheduleBookingApi = ScheduleBookingAPI();
  Future<dynamic> cancelJobCardAPI(String jobNumber) =>
      cancelJobCardApi.onCancelJobCardApi(jobNumber);

  Future<dynamic> approveJobCardAPI(String job_Number) =>
      acceptbooking.onApproveJobCardApi(job_Number);

  Future<dynamic> onViewItems1API(String job_number) =>
      viewItemsDataAPI.onViewItemsDataApi(job_number);

  Future<dynamic> onListCondition(String booking_id) =>
      conditionlistapi.listPickupConditions(booking_id);
  Future<dynamic> onLogin(
          String mobileNumber, String password, String fcmToken) =>
      loginapi.onLoginApi(mobileNumber, password, fcmToken);

  Future<dynamic> onUpload(String userId, File image) =>
      uploadapi.onUploadApi(userId, image);

  Future<dynamic> onRegistration(
          String email,
          String mobileNumber,
          String name,
          String latitude,
          String longitude,
          String password,
          String fcmToken,
          String resendOTP) =>
      registerFirstApi.onUserRegisterAPI(email, mobileNumber, name, latitude,
          longitude, password, fcmToken, resendOTP);

  Future<dynamic> onaddcarApi(
          String carId,
          String user_id,
          String model,
          String cylinder,
          String mileage,
          String model_year,
          String plate_number,
          String chases_number,
          String fuel_type,
          String brandId,
          AddCarType type) =>
      addcarApi.onAddCarApi(carId, user_id, model, cylinder, mileage,
          model_year, plate_number, chases_number, fuel_type, brandId, type);
  Future<dynamic> oncarbrandListAPI() => carbrandApi.onCarBrandApi();

  Future<dynamic> onCategories(String brand_id) =>
      categoriesApi.onCategoriesApi(brand_id);
  Future<dynamic> onRejectBookingAPI(String booking_id) =>
      rejectbooking.onRejectBookingApi(booking_id);
  Future<dynamic> onOilChange(String category_id) =>
      oilchnageapi.onOilchangeApi(category_id);

  Future<dynamic> onaddCar(String user_id) => carlistapi.onCarListApi(user_id);
  Future<dynamic> onSelCarDetailsApi(String car_id) =>
      cardetails.onCarDetailsApi(car_id);
  Future<dynamic> brandmodelisAPI(String brand_id) =>
      brandmodeapi.onbrandmodel(brand_id);
  Future<dynamic> onitemlist(String sub_category_id) =>
      itemlistapi.onItemlistApi(sub_category_id);

  Future<dynamic> onUserprofile(String user_id, String name, String email,
          String mobile_number, String dob, String gender) =>
      userprofileapi.onUserProfileApi(
          user_id, name, email, mobile_number, dob, gender);
  Future<dynamic> editemodelAPI(
          String user_id,
          String model,
          String cylinder,
          String mileage,
          String model_year,
          String plate_number,
          String chases_number,
          String id) =>
      editemodelapi.oneditemodel(user_id, model, cylinder, mileage, model_year,
          plate_number, chases_number, id);

  Future<dynamic> onforget(String email, String mobileNumber) =>
      forgetpasswordApi.onForgetpasswordApi(email, mobileNumber);

  Future<dynamic> onotpAPI(String mobileNumber, String OTP, String flag) =>
      otpverifyApi.onOtpVerifyApi(mobileNumber, OTP, flag);

  Future<dynamic> onreset(String email, String mobileNumber, String password) =>
      resetpasswordApi.onResetpasswordApi(email, mobileNumber, password);

  Future<dynamic> carbookingAPI(
          String customerid,
          String categoryid,
          String subcategoryid,
          String itemid,
          String timedate,
          String address,
          String total,
          String carId) =>
      carbooking.oncarbooking(customerid, categoryid, subcategoryid, itemid,
          timedate, address, total, carId);

  Future<dynamic> emergencycarbookingAPI(String customerid, String timedate,
          String address, String carId, String workdone, List<XFile>? images) =>
      emergencycarbooking.emergencyoncarbooking(
          customerid, timedate, address, carId, workdone, images);
  Future<dynamic> carCheckupbookingApi(String customerid, String timedate,
          String address, String carId, String workdone, List<XFile>? images) =>
      carcheckup.carCheckupbooking(
          customerid, timedate, address, carId, workdone, images);
  Future<dynamic> quickServiceBookingApi(String customerid, String timedate,
          String address, String carId, String workdone, List<XFile>? images) =>
      quickServices.quickServicecarbooking(
          customerid, timedate, address, carId, workdone, images);
  Future<dynamic> carDetailingBookingApi(String customerid, String timedate,
          String address, String carId, String workdone, List<XFile>? images) =>
      carDetailings.carDeatilingoncarbookings(
          customerid, timedate, address, carId, workdone, images);
// ............

  Future<dynamic> scheduledelivery(String jobnumber, String timedate) =>
      scheduleBookingApi.onschedulebooking(jobnumber, timedate);

  Future<dynamic> BookingListAPI(String userid, String status, String search,
          String start_date, String end_date, String category) =>
      bookingListApi.onBookingListApi(
          userid, status, search, start_date, end_date, category);

  Future<dynamic> JobCardsListAPI(String userid, String status, String search,
          String start_date, String end_date, String category) =>
      jobcardsListApi.onJobCardsListApi(
          userid, status, search, start_date, end_date, category);

  Future<dynamic> DeleteCarAPI(String id) => deleteCarApi.onDeleteCarApi(id);

  Future<dynamic> onCancelBooking(String bookingId) =>
      cancelCarBookingApi.onCancelCarBookingApi(bookingId);

  Future<dynamic> onSendNotificationAdminAPI(String title, String message) =>
      sendNotificationAdminApi.onSendNotificationAdminApi(title, message);

  Future<dynamic> oncustomerNotificationListApi(String customer_id) =>
      notificationListApi.onCustomerNotificationListApi(customer_id);

  Future<dynamic> oncustomerApprovedApi(String booking_id) =>
      approvedchargedcustomerApi.onSendNotificationbycustomerApi(booking_id);
  Future<dynamic> onAcceptPickupApi(String booking_id) =>
      acceptPickuprequestAPI.onSendNotificationPickuprequestApi(booking_id);
  Future<dynamic> onRejectPickupApi(String booking_id) =>
      rejectPickuprequestAPI.onSendNotificationPickuprequestApi(booking_id);
  Future<dynamic> onCustJobListAPI(String job_number) =>
      customerJobListAPI.onCustomerJobListApi(job_number);

  Future<dynamic> onViewDataAPI(String job_number) =>
      viewPartsDataAPI.onViewpartsDataApi(job_number);

  Future<dynamic> onViewItemDataAPI(String job_number) =>
      viewItemsDataAPI.onViewItemsDataApi(job_number);

  Future<dynamic> onViewServicesAPI(String job_number) =>
      viewServicesDataAPI.onServicesDataApi(job_number);

  Future<dynamic> onDeleteservicedata(String id) =>
      deleteServiceAPI.onDeleteServiceListApi(id);

  Future<dynamic> onDeletepartdata(String id) =>
      deletepartsAPI.onDeletePartsListApi(id);

  Future<dynamic> onListOfInvoicesApi(
          String userid, String status, String startDate, String endDate) =>
      listOfInvoicesApi.onListOfInvoicesApi(userid, status, startDate, endDate);

  Future<dynamic> onListOfBookingInvoicesApi(
          String userid, String startDate, String endDate) =>
      BookingInvoicesApi()
          .onListOfBookingInvoicesApi(userid, startDate, endDate);
}
