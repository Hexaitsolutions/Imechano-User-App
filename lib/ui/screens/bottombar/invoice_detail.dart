// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/view_data_bloc.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/invoice_model.dart';
import 'package:imechano/ui/provider/invoice_balance_provider.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart'; // Import OpenFile class
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../bloc/view_services_bloc.dart';
import '../../modal/view_parts_model.dart';
import '../../modal/view_services_model.dart';
import '../../repository/repository.dart';

///Salman//
String value = '';
String deletejobid = '';
String deleteserviceid = '';
String value1 = '';

class InvoiceDetail extends StatefulWidget {
  final String? jobNo;
  final bool showTables;
  final InvoiceData? invoiceData;
  final bool showPaymentMethod;
  final int choice;

  const InvoiceDetail(
      {this.jobNo,
      this.invoiceData,
      this.showPaymentMethod = false,
      this.showTables = true,
      required this.choice});

  @override
  _InvoiceDetailState createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey previewContainer = GlobalKey();
  final scrollController = ScrollController();

  //bool loader = true;
  bool loader_download = false;
  dynamic appModelTheme;
  //CustomerInvoiceModel? widget.invoiceData;

  // Create a NumberFormat instance for formatting
  var numberFormat = NumberFormat('#,##0.00', 'en_US');
  String formattedGrossTotal = '';
  ValueNotifier<String> servicesTotal = ValueNotifier('0.00');

//  List<ServicesData> servicess = <ServicesData>[];
//   late ServicesDataSource servicesDataSource;

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  List<ServicesData> servicess = <ServicesData>[];
  late ServicesDataSource servicesDataSource;

  void initState() {
    super.initState();
    callingAPi();
  }

  Future<void> createAndSavePdf(BuildContext context) async {
    setState(() {
      loader_download = true;
    });
    String deliveryCharges = numberFormat
        .format(double.tryParse(widget.invoiceData!.delieveryCharges!) ?? 0);
    String totalParts =
        Provider.of<InvoiceBalanceProvider>(context, listen: false).partsTotal;
    String serviceTotal =
        Provider.of<InvoiceBalanceProvider>(context, listen: false)
            .serviceTotal;
    String service75Percent =
        Provider.of<InvoiceBalanceProvider>(context, listen: false)
            .service75Percent;
    String service25Percent =
        Provider.of<InvoiceBalanceProvider>(context, listen: false)
            .service25Percent;
    final pdf = pw.Document();
    final arabicFont =
        pw.Font.ttf(await rootBundle.load("fonts/Arabic-Regular.ttf"));
    final arabicTextStyle = pw.TextStyle(font: arabicFont);
    final ByteData imageAssetByteData = await rootBundle.load(
        'assets/images/signaturestampblur.png'); // Replace 'image.png' with the actual name of your image file.
    final Uint8List imageAssetUint8List =
        imageAssetByteData.buffer.asUint8List();
    final pdfImage1 = pw.MemoryImage(
        imageAssetUint8List); // Use MemoryImage to load the image data.

    pdf.addPage(pw.Page(
      build: (pw.Context cxt) {
        return pw.Center(
          child: pw.Container(
            margin: pw.EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.only(
                topRight: pw.Radius.circular(25.0),
                topLeft: pw.Radius.circular(25.0),
              ),
            ),
            child: pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10),
                child: pw.Stack(children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // pw.Image(logoimage,height: 40),

                      pw.Container(
                        width: double.infinity,
                        height: 64,
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(15.0),
                            topLeft: pw.Radius.circular(15.0),
                          ),
                        ),
                        margin: pw.EdgeInsets.only(left: 10, right: 10),
                        child: pw.Container(
                          width: double.infinity,
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              // CRNo(),
                              pw.Container(
                                child: pw.Text(
                                  getTranslated("CRNO", context) + "\n123456",
                                  style: arabicTextStyle,
                                  textDirection: pw.TextDirection.rtl,
                                  textAlign: pw.TextAlign.right,
                                ),
                                margin: pw.EdgeInsets.only(left: 10.w),
                              ),
                              pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    getTranslated("PoweredbyCompany", context),
                                    style: arabicTextStyle,
                                    textDirection: pw.TextDirection.rtl,
                                    textAlign: pw.TextAlign.right,
                                  ),
                                ],
                              ),
                              pw.Container(
                                margin: pw.EdgeInsets.only(
                                  right: 10.w,
                                ),
                                child: pw.Text(
                                  getTranslated('Telephone', context) +
                                      "\n+974-55929250",
                                  style: arabicTextStyle,
                                  textDirection: pw.TextDirection.rtl,
                                  textAlign: pw.TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 8),

                      pw.Padding(
                        padding: pw.EdgeInsets.all(8.0),
                        child: pw.Container(
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(20),
                              border: pw.Border.all(
                                width: 1,
                              ),
                              boxShadow: [
                                pw.BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                ),
                              ]),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(width: 5.w),
                                    pw.Text(
                                      getTranslated("OrderAt", context) +
                                          '\n${widget.invoiceData!.createdAt!.substring(0, 10)}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated('PaidAt', context) +
                                          '\n${widget.invoiceData!.updatedAt!.substring(0, 10)}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("OrderAt", context) +
                                          '\n${widget.invoiceData!.updatedAt!.substring(0, 10)}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.SizedBox(width: 5.w),
                                  ],
                                ),
                                pw.SizedBox(height: 5.h),
                                if (widget.showPaymentMethod)
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 5.w),
                                        pw.Text(
                                          getTranslated(
                                                  "paymentmethod", context) +
                                              '\n${widget.invoiceData!.paymentMethod!}',
                                          textDirection: pw.TextDirection.rtl,
                                          textAlign: pw.TextAlign.right,
                                          style: arabicTextStyle,
                                        ),
                                        pw.Spacer(),
                                        pw.Text(
                                          getTranslated("staffId", context) +
                                              '\n${widget.invoiceData!.staffId.toString()}',
                                          textDirection: pw.TextDirection.rtl,
                                          textAlign: pw.TextAlign.right,
                                          style: arabicTextStyle,
                                        )
                                      ]),
                                pw.Divider(),
                                pw.SizedBox(height: 5.h),
                                pw.Text(
                                  getTranslated("CustomerDetails", context),
                                  style: arabicTextStyle,
                                  textDirection: pw.TextDirection.rtl,
                                  textAlign: pw.TextAlign.right,
                                ),
                                pw.SizedBox(height: 5.h),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                        getTranslated("CXname", context) +
                                            '\n${profileData["name"]}',
                                        textDirection: pw.TextDirection.rtl,
                                        textAlign: pw.TextAlign.right,
                                        style: arabicTextStyle),
                                    pw.Spacer(),
                                    pw.Text(
                                        getTranslated("Address", context) +
                                            '\n${widget.invoiceData!.address!.substring(0, 20)}',
                                        textDirection: pw.TextDirection.rtl,
                                        textAlign: pw.TextAlign.right,
                                        style: arabicTextStyle),
                                    pw.Spacer(),
                                    pw.Text(
                                        getTranslated("mobileno.", context) +
                                            '\n${profileData['mobile_number']}',
                                        textDirection: pw.TextDirection.rtl,
                                        textAlign: pw.TextAlign.right,
                                        style: arabicTextStyle),
                                  ],
                                ),
                                pw.SizedBox(height: 5.h),
                                pw.Divider(),
                                pw.SizedBox(height: 5.h),
                                pw.Text(
                                  getTranslated("CarInformation", context),
                                  style: arabicTextStyle,
                                  textDirection: pw.TextDirection.rtl,
                                  textAlign: pw.TextAlign.right,
                                ),
                                pw.SizedBox(height: 10.h),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      getTranslated("Make", context) +
                                          '\n${widget.invoiceData!.car!.carBrand!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("Model", context) +
                                          '\n${widget.invoiceData!.car!.carModel!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("Year", context) +
                                          '\n${widget.invoiceData!.car!.carYear!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10.h),
                                pw.Row(
                                  children: [
                                    pw.Text(
                                      getTranslated("Mileage", context) +
                                          '\n${widget.invoiceData!.car!.carMileage!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("cylindertype", context) +
                                          '\n${widget.invoiceData!.car!.carCylinder!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("carplateno", context) +
                                          '\n${widget.invoiceData!.car!.plateNo!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                    pw.Spacer(),
                                    pw.Text(
                                      getTranslated("ChasisNo", context) +
                                          '\n${widget.invoiceData!.car!.carChasis!}',
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                      style: arabicTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      pw.SizedBox(height: 2),
                      pw.Container(
                        margin: pw.EdgeInsets.only(left: 10, right: 10),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 8),
                            pw.Container(
                              margin: pw.EdgeInsets.only(left: 10, right: 10),
                              child: pw.Text(
                                getTranslated("Service", context),
                                style: arabicTextStyle,
                                textDirection: pw.TextDirection.rtl,
                                textAlign: pw.TextAlign.right,
                              ),
                            ),
                            pw.SizedBox(height: 8),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < widget.invoiceData!.items!.length;
                                          i++)
                                        pw.Padding(
                                          padding: pw.EdgeInsets.only(
                                            left: 17,
                                            top: 5,
                                          ),
                                          child: pw.Row(
                                            children: [
                                              // pw.Icon(
                                              //   pw.Icons.circle,
                                              //   color: buttonBlue3b5999,
                                              //   size: 8,
                                              // ),

                                              pw.SizedBox(width: 10),
                                              widget.invoiceData!.items![i]
                                                          .subCategoryId ==
                                                      10013
                                                  ? pw.Text(
                                                      widget
                                                          .invoiceData!
                                                          .items![i]
                                                          .itemName!
                                                          .removeAllWhitespace,
                                                      style: arabicTextStyle,
                                                      textDirection:
                                                          pw.TextDirection.rtl,
                                                      textAlign:
                                                          pw.TextAlign.right,
                                                    )
                                                  : pw.Text(
                                                      getTranslated(
                                                        widget
                                                            .invoiceData!
                                                            .items![i]
                                                            .itemName!
                                                            .removeAllWhitespace,
                                                        context,
                                                      ),
                                                      style: arabicTextStyle,
                                                      textDirection:
                                                          pw.TextDirection.rtl,
                                                      textAlign:
                                                          pw.TextAlign.right,
                                                    ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 8),
                            pw.Divider(),
                            widget.showTables
                                ? pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                        pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Text(
                                              getTranslated("date", context) +
                                                  ': ${widget.invoiceData!.updatedAt!.substring(0, 10)}',
                                              style: arabicTextStyle,
                                              textDirection:
                                                  pw.TextDirection.rtl,
                                              textAlign: pw.TextAlign.right,
                                            )),
                                        pw.SizedBox(
                                            height: screenSize!.height * 0.02),
                                        pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: widget.choice == 1
                                                ? pw.Text(
                                                    getTranslated(
                                                            "partspricespaid",
                                                            context) +
                                                        " : " +
                                                        getTranslated(
                                                            "qr", context) +
                                                        '$totalParts',
                                                    style: arabicTextStyle,
                                                    textDirection:
                                                        pw.TextDirection.rtl,
                                                    textAlign:
                                                        pw.TextAlign.right,
                                                  )
                                                : widget.choice == 2
                                                    ? pw.Column(
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          pw.Text(
                                                            getTranslated(
                                                                    "TotalLabour:KWD10.000",
                                                                    context) +
                                                                " : " +
                                                                getTranslated(
                                                                    "qr",
                                                                    context) +
                                                                '$serviceTotal',
                                                            style:
                                                                arabicTextStyle,
                                                            textDirection: pw
                                                                .TextDirection
                                                                .rtl,
                                                            textAlign: pw
                                                                .TextAlign
                                                                .right,
                                                          ),
                                                          pw.SizedBox(
                                                              height: screenSize!
                                                                      .height *
                                                                  0.02),
                                                          pw.Text(
                                                            getTranslated(
                                                                    "75%balancepaid",
                                                                    context) +
                                                                " : " +
                                                                getTranslated(
                                                                    "qr",
                                                                    context) +
                                                                '$service75Percent',
                                                            style:
                                                                arabicTextStyle,
                                                            textDirection: pw
                                                                .TextDirection
                                                                .rtl,
                                                            textAlign: pw
                                                                .TextAlign
                                                                .right,
                                                          ),
                                                          pw.SizedBox(
                                                              height: screenSize!
                                                                      .height *
                                                                  0.02),
                                                          pw.Text(
                                                            "25% " +
                                                                getTranslated(
                                                                    "balanceremaining",
                                                                    context) +
                                                                " : " +
                                                                getTranslated(
                                                                    "qr",
                                                                    context) +
                                                                '$service25Percent',
                                                            style:
                                                                arabicTextStyle,
                                                            textDirection: pw
                                                                .TextDirection
                                                                .rtl,
                                                            textAlign: pw
                                                                .TextAlign
                                                                .right,
                                                          ),
                                                        ],
                                                      )
                                                    : widget.choice == 3
                                                        ? pw.Text(
                                                            getTranslated(
                                                                    "25%balancepaid",
                                                                    context) +
                                                                " : " +
                                                                getTranslated(
                                                                    "qr",
                                                                    context) +
                                                                '$service25Percent',
                                                            style:
                                                                arabicTextStyle,
                                                            textDirection: pw
                                                                .TextDirection
                                                                .rtl,
                                                            textAlign: pw
                                                                .TextAlign
                                                                .right,
                                                          )
                                                        : null),
                                      ])
                                : pw.Align(
                                    alignment: pw.Alignment.centerRight,
                                    child: pw.Text(
                                      getTranslated(
                                              "bookingwithdeliverycharges",
                                              context) +
                                          " : " +
                                          getTranslated("qr", context) +
                                          '$deliveryCharges',
                                      style: arabicTextStyle,
                                      textDirection: pw.TextDirection.rtl,
                                      textAlign: pw.TextAlign.right,
                                    ),
                                  ),
                            pw.Text(
                              getTranslated("electronicinvoice", context),
                              style: arabicTextStyle,
                              textDirection: pw.TextDirection.rtl,
                              textAlign: pw.TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.Positioned(
                    left: 320,
                    top: 200,
                    child: pw.Image(pdfImage1, height: 100, width: 100),
                  ),
                ])),
          ),
        );
      },
    ));

    final currentTime = DateFormat('HHmmss').format(DateTime.now());
    final currentDate = DateFormat('yyyyMMdd').format(DateTime.now());
    final fileName = 'ImechanoInvoice$currentTime$currentDate.pdf';

    final directory = (await getApplicationDocumentsDirectory()).path;
    final filePath = '$directory/$fileName';
    final file = File(filePath);

    print(file);

    await file.writeAsBytes(await pdf.save());

    final snackBar = SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor: Colors.green[400],
      content: Text('Saved to $filePath'),
      action: SnackBarAction(
        label: 'Open',
        textColor: Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          OpenFile.open(file.path);
        },
      ),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
    setState(() {
      loader_download = false;
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  callingAPi() async {
    if (widget.showTables) {
      viewPartsDataBloc.onViewPartsDataSink(widget.jobNo!);
      viewServicesDataBloc.onViewServicesDataSink(widget.jobNo!);
    }
  }

  var profileData;

  @override
  Widget build(BuildContext context) {
    profileData = json.decode(PrefObj.preferences!.get(PrefKeys.PROFILE_DATA));

    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      drawer: drawerpage(),
      key: _scaffoldKey,
      appBar: WidgetAppBar(
        title: getTranslated("InvoiceDetail", context),
        menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action2: 'assets/svg/ball.svg',
      ),
      backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Column(
          children: [
            appBarWidget(),
            if (widget.invoiceData != null)
              Expanded(
                child: Stack(
                  children: [
                    _blankContainer(),
                    RepaintBoundary(
                      key: previewContainer,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: appModelTheme.darkTheme
                                  ? darkmodeColor
                                  : white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (notification) {
                                notification.disallowGlow();
                                return true;
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 64.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              topLeft: Radius.circular(15.0)),
                                          image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: AssetImage(
                                                "assets/icons/My Vehicle/Group 9252.png"),
                                          )),
                                      margin: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CRNo(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  height: 30.h,
                                                  image: AssetImage(
                                                      "assets/icons/splash/logo.png"),
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  getTranslated(
                                                      "PoweredbyCompany",
                                                      context),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8.sp,
                                                      fontFamily: "Poppins1"),
                                                )
                                              ],
                                            ),
                                            mobileNumber(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    dataCard(),
                                    SizedBox(height: 8),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            indent: 10.w,
                                            endIndent: 10.w,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10.w, right: 10.w),
                                            child: Text(
                                              getTranslated("Service", context),
                                              style: TextStyle(
                                                fontFamily: "Poppins2",
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          widget.invoiceData!
                                                              .items!.length;
                                                      i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 17, top: 5),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            color:
                                                                buttonBlue3b5999,
                                                            size: 8,
                                                          ),
                                                          SizedBox(width: 10.w),
                                                          widget
                                                                      .invoiceData!
                                                                      .items![i]
                                                                      .subCategoryId ==
                                                                  10013
                                                              ? Text(
                                                                  widget
                                                                      .invoiceData!
                                                                      .items![i]
                                                                      .itemName!
                                                                      .removeAllWhitespace,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontFamily:
                                                                        'Poppins3',
                                                                  ),
                                                                )
                                                              : Text(
                                                                  getTranslated(
                                                                      widget
                                                                          .invoiceData!
                                                                          .items![
                                                                              i]
                                                                          .itemName!
                                                                          .removeAllWhitespace,
                                                                      context),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontFamily:
                                                                        'Poppins3',
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Container(
                                                child: Opacity(
                                                  opacity:
                                                      0.6, // Set the opacity value between 0.0 (completely transparent) and 1.0 (fully opaque)
                                                  child: Image.asset(
                                                    'assets/images/signaturestamp.png',
                                                    width: 170,
                                                    height: 170,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          widget.showTables
                                              ? Column(
                                                  children: [
                                                    Center(child: partsTable()),
                                                    SizedBox(height: 25.h),
                                                    Center(
                                                        child: servicetable()),
                                                    SizedBox(
                                                      height: 30.h,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        getTranslated("date",
                                                                context) +
                                                            ': ${widget.invoiceData!.updatedAt!.substring(0, 10)}',
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontFamily:
                                                                "Poppins1"),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                  ],
                                                )
                                              : invoice0(),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                                width: screenSize!.width * 0.5,
                                                child: widget.choice == 1
                                                    ? invoice1()
                                                    : widget.choice == 2
                                                        ? invoice2()
                                                        : widget.choice == 3
                                                            ? invoice3()
                                                            : null),
                                          ),
                                          SizedBox(height: 30.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const Center(
                child: Text('Invoice not available yet!'),
              )
          ],
        ),
      ),
    );
  }

  Widget appBarWidget() {
    return Container(
        height: 70.h,
        color: appModelTheme.darkTheme ? black : logoBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      getTranslated("bookingid", context) +
                          " : " +
                          widget.invoiceData!.bookingId!.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Poppins2'),
                    ),
                  ),
                  Container(
                    width: 120.w,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await createAndSavePdf(context);
                          } catch (e) {
                            log(e.toString());
                            snackBar(
                                'Something went wrong, try again', context);
                            setState(() {
                              loader_download = false;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            loader_download
                                ? Container(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Text(
                                    getTranslated("download", context),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins1',
                                        fontSize: 12.sp),
                                  ),
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _blankContainer() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? black : logoBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0.w),
            bottomRight: Radius.circular(100.0.w)),
      ),
    );
  }

  Widget servicetable() {
    return StreamBuilder<ViewServiceModel>(
        stream: viewServicesDataBloc.ViewServicesStream,
        builder: (context,
            AsyncSnapshot<ViewServiceModel> ViewServicesDataSnapshot) {
          if (!ViewServicesDataSnapshot.hasData) {
            return CircularProgressIndicator();
          }

          servicess = [];
          for (var i = 0;
              i < ViewServicesDataSnapshot.data!.data!.length;
              i++) {
            servicess.add(
              ServicesData(
                  ViewServicesDataSnapshot.data!.data![i].serviceName
                      .toString(),
                  ViewServicesDataSnapshot.data!.data![i].serviceDesc
                      .toString(),
                  ViewServicesDataSnapshot.data!.data![i].serviceCost
                      .toString(),
                  ViewServicesDataSnapshot.data!.data![i].total.toString(),
                  ViewServicesDataSnapshot.data!.data![i].id.toString()),
            );
            value1 = ViewServicesDataSnapshot.data!.data![i].id.toString();
            deleteserviceid =
                ViewServicesDataSnapshot.data!.data![i].jobNumber.toString();
          }
          Provider.of<InvoiceBalanceProvider>(context, listen: false)
              .setServiceTotals(
                  ViewServicesDataSnapshot.data!.mainTotal!,
                  ViewServicesDataSnapshot.data!.total75Percent!,
                  ViewServicesDataSnapshot.data!.total25Percent!);

          servicesDataSource =
              ServicesDataSource(servicesdata: servicess, context: context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  getTranslated('ServicesEstimate', context) + " : ",
                  style: TextStyle(fontFamily: "Poppins1", fontSize: 15),
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 350,
                child: SfDataGridTheme(
                  data:
                      SfDataGridThemeData(headerColor: const Color(0xff162e3f)),
                  child: SfDataGrid(
                    source: servicesDataSource,
                    isScrollbarAlwaysShown: true,
                    selectionMode: SelectionMode.multiple,
                    columnWidthMode: ColumnWidthMode.fill,
                    defaultColumnWidth: 97,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'Service Name',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('servicename', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'servicecharge',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated('servicecharge', context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'serviceDec',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('ServiceDec', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'Total',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('Total', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.center,
                    color: Colors.grey[200],
                    child: Text(
                      getTranslated('EstBalance:KWD2.000', context) +
                          getTranslated('qr', context) +
                          ": ${ViewServicesDataSnapshot.data!.mainTotal}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins4", fontSize: 11),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget partsTable() {
    return StreamBuilder<ViewPartsModel>(
        stream: viewPartsDataBloc.ViewpartsStream,
        builder:
            (context, AsyncSnapshot<ViewPartsModel> ViewpartsDataSnapshot) {
          if (!ViewpartsDataSnapshot.hasData) {
            return CircularProgressIndicator();
          }

          employees = [];
          for (var i = 0; i < ViewpartsDataSnapshot.data!.data!.length; i++) {
            employees.add(
              Employee(
                  ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
                  ViewpartsDataSnapshot.data!.data![i].partType.toString(),
                  ViewpartsDataSnapshot.data!.data![i].qty.toString(),
                  ViewpartsDataSnapshot.data!.data![i].estCost.toString(),
                  ViewpartsDataSnapshot.data!.data![i].partDesc.toString(),
                  ViewpartsDataSnapshot.data!.data![i].total.toString(),
                  ViewpartsDataSnapshot.data!.data![i].id.toString()),
            );
            value = ViewpartsDataSnapshot.data!.data![i].id.toString();
            deletejobid =
                ViewpartsDataSnapshot.data!.data![i].jobNumber.toString();
          }
          Provider.of<InvoiceBalanceProvider>(context, listen: false)
              .setPartsTotal(ViewpartsDataSnapshot.data!.mainTotal ?? '0.00');

          employeeDataSource =
              EmployeeDataSource(employeeData: employees, context: context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  getTranslated('Repairs-PartsEstimate', context) + " : ",
                  style: TextStyle(fontFamily: "Poppins1", fontSize: 15),
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 350,
                child: SfDataGridTheme(
                  data:
                      SfDataGridThemeData(headerColor: const Color(0xff162e3f)),
                  child: SfDataGrid(
                    isScrollbarAlwaysShown: true,
                    source: employeeDataSource,
                    selectionMode: SelectionMode.multiple,
                    columnWidthMode: ColumnWidthMode.fill,
                    defaultColumnWidth: 50,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'PartNO',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated('PartName', context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'PartType',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated('Parttype', context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'quantity',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('QTY', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'EstCost',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('EstCost', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'Discount',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('Discnt', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'Total',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(getTranslated('Total', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.center,
                    color: Colors.grey[200],
                    child: Text(
                      getTranslated('EstBalance:KWD2.000', context) +
                          getTranslated('qr', context) +
                          ": ${ViewpartsDataSnapshot.data!.mainTotal}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins4", fontSize: 11),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget dataCard() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? darkmodeColor : white,
            borderRadius: BorderRadius.circular(20),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              schedule(),
              SizedBox(height: 5.h),
              if (widget.showPaymentMethod) staffIdAndPaymentMethod(),
              Divider(),
              SizedBox(height: 5.h),
              Text(
                getTranslated("CustomerDetails", context),
                style: TextStyle(
                  fontFamily: "Poppins2",
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Image(
                      image:
                          AssetImage("assets/icons/My Vehicle/Group 9254.png"),
                      height: 50.h),
                  Spacer(),
                  carddivider(
                      getTranslated("CXname", context), profileData["name"]),
                  Spacer(),
                  carddivider(getTranslated("Address", context),
                      widget.invoiceData!.address!.substring(0, 20)),
                  Spacer(),
                  carddivider(getTranslated("mobileno.", context),
                      profileData['mobile_number']),
                ],
              ),
              SizedBox(height: 5.h),
              Divider(),
              SizedBox(height: 5.h),
              Text(
                getTranslated("CarInformation", context),
                style: TextStyle(fontFamily: "Poppins2", fontSize: 10.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Image(
                      image:
                          AssetImage("assets/icons/My Vehicle/Group 9253.png"),
                      height: 50.h),
                  Spacer(),
                  carddivider(getTranslated("Make", context),
                      widget.invoiceData!.car!.carBrand!),
                  Spacer(),
                  carddivider(getTranslated("Model", context),
                      widget.invoiceData!.car!.carModel!),
                  Spacer(),
                  carddivider(getTranslated("Year", context),
                      widget.invoiceData!.car!.carYear!),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  carddivider(
                      getTranslated("Mileage", context),
                      //"Milage",
                      widget.invoiceData!.car!.carMileage!),
                  Spacer(),
                  carddivider(
                      getTranslated("cylindertype", context),
                      // "Cylinder",
                      widget.invoiceData!.car!.carCylinder!),
                  Spacer(),
                  carddivider(
                      getTranslated("carplateno", context),
                      //"Car Plate",
                      widget.invoiceData!.car!.plateNo!),
                  Spacer(),
                  carddivider(
                      getTranslated("ChasisNo", context),
                      //"Chasis No (Optional)",
                      widget.invoiceData!.car!.carChasis!)
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget schedule() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 5.w),
        carddivider(getTranslated("OrderAt", context),
            widget.invoiceData!.createdAt!.substring(0, 10)),
        Spacer(),
        carddivider(getTranslated('PaidAt', context),
            widget.invoiceData!.updatedAt!.substring(0, 10)),
        Spacer(),
        carddivider(getTranslated("date", context),
            '${widget.invoiceData!.updatedAt!.substring(0, 10)}'),
        SizedBox(width: 5.w),
      ],
    );
  }

  Widget staffIdAndPaymentMethod() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 5.w),
        carddivider(getTranslated("paymentmethod", context),
            widget.invoiceData!.paymentMethod!),
        Spacer(),
        carddivider(getTranslated("staffId", context),
            widget.invoiceData!.staffId.toString()),
        SizedBox(width: 5.w),
      ],
    );
  }

  Widget CRNo() {
    return Container(
      child: Text(
        getTranslated("CRNO", context) + ".\n123456",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
      margin: EdgeInsets.only(left: 10.w),
    );
  }

  Widget mobileNumber() {
    return Container(
      margin: EdgeInsets.only(
        right: 10.w,
      ),
      child: Text(
        getTranslated('Telephone', context) + "\n+974-55929250",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget estBalance() {
    String total =
        numberFormat.format(double.tryParse(widget.invoiceData!.total!) ?? 0);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 40.h,
        width: 200.w,
        padding: EdgeInsets.only(right: 10.w),
        alignment: Alignment.centerRight,
        color: appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
        child: Text(
          getTranslated("EstBalance:KWD2.000", context) +
              " : " +
              getTranslated("qr", context) +
              '$total',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
        ),
      ),
    );
  }

  Widget invoice0() {
    String deliveryCharges = numberFormat
        .format(double.tryParse(widget.invoiceData!.delieveryCharges!) ?? 0);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: screenSize!.width * 0.5,
        padding: EdgeInsets.only(right: 10.w),
        alignment: Alignment.centerRight,
        color: appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
        child: Text(
          getTranslated("bookingwithdeliverycharges", context) +
              " : " +
              getTranslated("qr", context) +
              '$deliveryCharges',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
        ),
      ),
    );
  }

  Widget invoice1() {
    return Container(
      padding: EdgeInsets.only(right: 10.w),
      alignment: Alignment.centerRight,
      color: appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
      child: Consumer<InvoiceBalanceProvider>(
        builder: (context, value, child) {
          return Text(
            getTranslated("partspricespaid", context) +
                " : " +
                getTranslated("qr", context) +
                '${value.partsTotal}',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
          );
        },
      ),
    );
  }

  Widget invoice2() {
    return Consumer<InvoiceBalanceProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10.w),
              alignment: Alignment.centerRight,
              color: appModelTheme.darkTheme
                  ? Color(0xff252525)
                  : Color(0xffdde2f5),
              child: Text(
                getTranslated("TotalLabour:KWD10.000", context) +
                    " : " +
                    getTranslated("qr", context) +
                    '${value.serviceTotal}',
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
              ),
            ),
            SizedBox(height: screenSize!.height * 0.02),
            Container(
              padding: EdgeInsets.only(right: 10.w),
              alignment: Alignment.centerRight,
              color: appModelTheme.darkTheme
                  ? Color(0xff252525)
                  : Color(0xffdde2f5),
              child: Text(
                getTranslated("75%balancepaid", context) +
                    " : " +
                    getTranslated("qr", context) +
                    '${value.service75Percent}',
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
              ),
            ),
            SizedBox(height: screenSize!.height * 0.02),
            Container(
              padding: EdgeInsets.only(right: 10.w),
              alignment: Alignment.centerRight,
              color: appModelTheme.darkTheme
                  ? Color(0xff252525)
                  : Color(0xffdde2f5),
              child: Text(
                "25% " +
                    getTranslated("balanceremaining", context) +
                    " : " +
                    getTranslated("qr", context) +
                    '${value.service25Percent}',
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget invoice3() {
    return Consumer<InvoiceBalanceProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10.w),
              alignment: Alignment.centerRight,
              color: appModelTheme.darkTheme
                  ? Color(0xff252525)
                  : Color(0xffdde2f5),
              child: Text(
                getTranslated("25%balancepaid", context) +
                    " : " +
                    getTranslated("qr", context) +
                    '${value.service25Percent}',
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}

///////////////Parts table//////////////
class Employee {
  Employee(this.partno, this.parttype, this.partdesc, this.quantity,
      this.estcost, this.total, this.remove);

  final String partno;
  final String parttype;
  final String partdesc;
  final String quantity;
  final String estcost;
  final String total;
  final String remove;
}

class EmployeeDataSource extends DataGridSource {
  final String? id;
  final BuildContext context;
  EmployeeDataSource(
      {required List<Employee> employeeData, this.id, required this.context}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'Remove', value: e.remove),
              DataGridCell<String>(columnName: 'partno', value: e.partno),
              DataGridCell<String>(columnName: 'parttype', value: e.parttype),
              DataGridCell<String>(columnName: 'partdesc', value: e.partdesc),
              DataGridCell<String>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'estcost', value: e.estcost),
              DataGridCell<String>(columnName: 'total', value: e.total),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  final _repository = Repository();

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          // color: getRowBackgroundColor(),
          alignment: Alignment.center,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }
}

////////////////////////Service Table/////////////////////////////

class ServicesData {
  ServicesData(this.serviceName, this.serviceDec, this.servicecharge,
      this.total, this.remove);
  final String serviceName;
  final String serviceDec;
  final String servicecharge;
  final String total;
  final String remove;
}

class ServicesDataSource extends DataGridSource {
  final BuildContext context;
  ServicesDataSource(
      {required List<ServicesData> servicesdata, required this.context}) {
    _ServicesData = servicesdata
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'Remove', value: e.remove),
              DataGridCell<String>(
                  columnName: 'Service Name', value: e.serviceName),
              DataGridCell<String>(
                  columnName: 'serviceDec', value: e.serviceDec),
              DataGridCell<String>(
                  columnName: 'servicecharge', value: e.servicecharge),
              DataGridCell<String>(columnName: 'total', value: e.total),
            ]))
        .toList();
  }

  List<DataGridRow> _ServicesData = [];
  final _repository = Repository();

  @override
  List<DataGridRow> get rows => _ServicesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
      // if (dataGridCell.columnName == 'servicecharge') {
      //   final int index = effectiveRows.indexOf(row);
      //   return Padding(
      //     padding: const EdgeInsets.only(left: 10),
      //     child: Container(
      //         alignment: Alignment.centerLeft,
      //         child: Text('KWD : ${dataGridCell.value.toString()}',
      //             style: TextStyle(fontSize: 11))),
      //   );
      // }
      // if (dataGridCell.columnName == 'serviceDec') {
      //   final int index = effectiveRows.indexOf(row);
      //   return Padding(
      //     padding: const EdgeInsets.only(right: 5),
      //     child: Container(
      //         alignment: Alignment.centerLeft,
      //         child: Text(dataGridCell.value.toString(),
      //             style: TextStyle(fontSize: 11))),
      //   );
      // }
      return Container(
          alignment: Alignment.center,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }
}
