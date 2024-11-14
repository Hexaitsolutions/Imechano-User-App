// ignore_for_file: deprecated_member_use



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/cust_job_list_bloc.dart';
import 'package:imechano/ui/bloc/view_data_bloc.dart';
import 'package:imechano/ui/bloc/view_services_bloc.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/approve_jobcard_model.dart';
import 'package:imechano/ui/modal/cancel_jobcard_model.dart';
import 'package:imechano/ui/modal/cust_joblist_model.dart';
import 'package:imechano/ui/modal/part_data_delete_model.dart';
import 'package:imechano/ui/modal/service_data_delete.model.dart';
import 'package:imechano/ui/modal/view_parts_model.dart';
import 'package:imechano/ui/modal/view_services_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/car_checkout.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/shared/widgets/form/lable_list_tile.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


import '../../modal/send_notification_admin_modal.dart';


String value = '';
String deletejobid = '';
String deleteserviceid = '';
String value1 = '';

class MyJobCardDetails extends StatefulWidget {
  const MyJobCardDetails({this.job_number});
  final String? job_number;

  @override
  _MyJobCardDetailsState createState() => _MyJobCardDetailsState();
}

class _MyJobCardDetailsState extends State<MyJobCardDetails>
    with WidgetsBindingObserver {
  bool isSwitch = true;
  TextEditingController jobno = TextEditingController();
  TextEditingController jobdate = TextEditingController();
  TextEditingController carregist = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController milage = TextEditingController();
  TextEditingController datetime = TextEditingController();
  TextEditingController carmake = TextEditingController();
  TextEditingController carmodel = TextEditingController();
  TextEditingController custname = TextEditingController();
  TextEditingController customercontact = TextEditingController();
  TextEditingController vinno = TextEditingController();
  TextEditingController garagname = TextEditingController();

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  List<ServicesData> servicess = <ServicesData>[];
  late ServicesDataSource servicesDataSource;

  List partNo = [
    '1',
    '2',
    '3',
  ];
  List partType = [
    'New Org',
    'Used Org',
    'New Org',
  ];
  List partDesc = ['Breack Liner', 'Spiring Liner', 'Ball Joint Cuvk'];
  List qty = ['4', '2', '1'];
  List estCost = ['2000', '1000', '4000'];
  dynamic appModelTheme;
  final _repository = Repository();
  var grossTotal = 0.00;
  // Create a NumberFormat instance for formatting
  var numberFormat = NumberFormat('#,##0.00', 'en_US');
  String formattedGrossTotal = '';
  String servicesTotal = '0.00';
  String partsTotal = '0.00';

  @override
  void initState() {
    super.initState();
    custJobListAPIBloc.oncustomerjobblocSink(widget.job_number.toString());
    viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _updateState() {
    Future.microtask(() {
      setState(() {
        // update your state here
      });
    });
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    // _tabController?.animateTo(currentBookingTab);

    viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
    setState(() {});
  }

  void onPaused() {
    print("~~~~~~~ onPaused");
  }

  void onInactive() {
    print("~~~~~~~ onInactive");
  }

  void onDetached() {
    print("~~~~~~~ onDetached");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    custJobListAPIBloc.oncustomerjobblocSink(widget.job_number.toString());
    viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;

    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        appBar: WidgetAppBar(
          title: getTranslated('JobCard', context),
          menuItem: 'assets/svg/Menu.svg',
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          action: 'assets/svg/shopping-cart.svg',
          action2: 'assets/svg/ball.svg',
        ),
        drawer: drawerpage(),
        backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
        body: Column(children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowGlow();
                      return true;
                    },
                    child: StreamBuilder<CustomerJobListModel>(
                        stream: custJobListAPIBloc.CustomerJobListStream,
                        builder: (context,
                            AsyncSnapshot<CustomerJobListModel>
                                custjoblistSnapshot) {
                          viewPartsDataBloc.onViewPartsDataSink(
                              widget.job_number.toString());
                          viewServicesDataBloc.onViewServicesDataSink(
                              widget.job_number.toString());
                          if (!custjoblistSnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].jobNumber
                                            .toString(),
                                        title: getTranslated(
                                            'jobnumber', context)),
                                    LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].dateTime!
                                            .split(' ')[0],
                                        title:
                                            '${getTranslated('JobCard', context)} ${getTranslated('date', context)}'),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].carRegNumber
                                            .toString(),
                                        title: getTranslated(
                                            'carplateno', context)),
                                    LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].year
                                            .toString(),
                                        title: getTranslated(
                                            'ModelYear', context)),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].mileage
                                            .toString(),
                                        title:
                                            getTranslated('Mileage', context)),
                                    LabelListTile(
                                      subtitle: custjoblistSnapshot
                                          .data!.data![0].bookingId!,
                                      title:
                                          getTranslated('bookingid', context),
                                    )
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    LabelListTile(
                                      subtitle: custjoblistSnapshot
                                          .data!.data![0].carMake!,
                                      title: getTranslated('Make', context),
                                    ),
                                    LabelListTile(
                                      subtitle: custjoblistSnapshot
                                          .data!.data![0].carModel!
                                          .split(' ')[0],
                                      title:
                                          getTranslated('ModelName', context),
                                    )
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].customerName!,
                                        title: getTranslated(
                                            'customername', context),
                                      ),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].customerContactNo!
                                            .split(' ')[0],
                                        title:
                                            getTranslated('mobileno.', context),
                                      )
                                    ]),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].dateTime!
                                            .split('.')[0],
                                        title:
                                            '${getTranslated('JobCard', context)} ${getTranslated('date', context)} ${getTranslated('time', context)}',
                                        widthFactor: 0.87,
                                      ),
                                    ]),
                                SizedBox(height: size.height * 0.02),
                                // //==============DATA NOT COMING FROM API========
                                // LabelListTile(
                                //   subtitle: '',
                                //   title: 'Report Defect Type',
                                //   widthFactor: 0.87,
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey[100],
                                  thickness: 11,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(child: table()),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey[100],
                                  thickness: 11,
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: servicetable(),
                                ),
                                SizedBox(height: 10.h),
                                Divider(
                                  color: Colors.grey[100],
                                  thickness: 11,
                                ),
                                // SizedBox(height: 15.h),
                                // _delTotal(),
                                SizedBox(height: 30.h),
                                custjoblistSnapshot.data!.data![0].status
                                            .toString() ==
                                        "0"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 165,
                                            child: ElevatedButton(
                                              child: Text(getTranslated(
                                                  'PayandConfirm', context)),
                                              onPressed: () {
                                                // _asyncConfirmDialog(
                                                //     context,
                                                //     custjoblistSnapshot.data!
                                                //         .data![0].jobNumber
                                                //         .toString());
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CheckOut(
                                                          jobNo:
                                                              custjoblistSnapshot
                                                                  .data!
                                                                  .data![0]
                                                                  .jobNumber
                                                                  .toString(),
                                                          choice: 2)),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(logoBlue),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ))),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 165,
                                            child: TextButton(
                                              child: Text(
                                                  getTranslated(
                                                      'Canceljob', context),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: "Poppins1")),
                                              style: TextButton.styleFrom(
                                                primary: Colors.black,
                                                onSurface: Colors.yellow,
                                                side: BorderSide(
                                                    color: Color(0xff374049),
                                                    width: 2),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                              onPressed: () async {
                                                Loader().showLoader(context);
                                                final CancelJobCardModel
                                                    isCancelJobCard =
                                                    await _repository
                                                        .cancelJobCardAPI(
                                                            custjoblistSnapshot
                                                                .data!
                                                                .data![0]
                                                                .jobNumber
                                                                .toString());
                                                if (isCancelJobCard.code !=
                                                    '0') {
                                                  Loader().hideLoader(context);
                                                  snackBar(
                                                      isCancelJobCard.message ??
                                                          'Job Card Cancelled');
                                                  Get.offAll(
                                                      () => BottomBarPage(3));
                                                  currentJobcardTab = 2;
                                                } else {
                                                  Loader().hideLoader(context);
                                                  showpopDialog(
                                                      context,
                                                      'Error',
                                                      isCancelJobCard.message !=
                                                              null
                                                          ? isCancelJobCard
                                                              .message!
                                                          : '');
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : custjoblistSnapshot.data!.data![0].status
                                                .toString() ==
                                            "2"
                                        ? Center(
                                            child: Text(
                                                getTranslated('cancelledat',
                                                        context) +
                                                    ' : ' +
                                                    custjoblistSnapshot
                                                        .data!.data![0].dateTime
                                                        .toString()
                                                        .substring(0, 19),
                                                style: TextStyle(
                                                    fontFamily: "Poppins1",
                                                    fontSize: 15)))
                                        : Center(
                                            child: Text(
                                                getTranslated(
                                                        'paidat', context) +
                                                    ' : ' +
                                                    custjoblistSnapshot
                                                        .data!.data![0].dateTime
                                                        .toString()
                                                        .substring(0, 19),
                                                style: TextStyle(
                                                    fontFamily: "Poppins1",
                                                    fontSize: 15)),
                                          ),
                                SizedBox(height: 35.h)
                              ],
                            ),
                          );
                        }),
                  ),
                )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future _asyncConfirmDialog(BuildContext context, String jobnumber) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Gateway'),
          content: const Text(
              'You will be asked to pay via Card at this page. Please Click on Pay & Confirm for sandbox test. Thanks'),
          actions: [
            // FlatButton(
            //   child: const Text('CANCEL'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              child: const Text('Pay & Confirm'),
              onPressed: () async {
                Navigator.of(context).pop();
                onSendNotificationAdminAPI();
                acceptbookingApiCall(jobnumber);

                setState(() {
                  print("I m rebuild");
                });
              },
            )
          ],
        );
      },
    );
  }

  Widget VINTextfiled(String image) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 89,
      child: SizedBox(
        width: 175,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Image(height: 50, image: AssetImage("$image")),
        ),
      ),
    );
  }

  Widget card(String title) {
    return Expanded(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 9, right: 9, top: 7, bottom: 7),
        padding: EdgeInsets.only(bottom: 15, top: 15),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(margin: EdgeInsets.only(left: 15), child: Text(title)),
      ),
    );
  }

  Widget table() {
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
                    showCheckboxColumn: true,
                    selectionMode: SelectionMode.multiple,
                    checkboxColumnSettings: DataGridCheckboxColumnSettings(
                      showCheckboxOnHeader: true,
                      width: 50,
                    ),
                    columnWidthMode: ColumnWidthMode.none,
                    defaultColumnWidth: 50,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'Remove',
                          label: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,

                            child: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.white,
                            ),
                            // child: Text('',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 11,
                            //         color: Colors.white))
                          )),
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
                      // ViewpartsDataSnapshot.data!.mainTotal.toString(),
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
                  // ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
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
                    showCheckboxColumn: true,
                    isScrollbarAlwaysShown: true,
                    selectionMode: SelectionMode.multiple,
                    checkboxColumnSettings: DataGridCheckboxColumnSettings(
                      showCheckboxOnHeader: true,
                      width: 50,
                    ),
                    columnWidthMode: ColumnWidthMode.none,
                    defaultColumnWidth: 97,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'Remove',
                          label: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,

                            child: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.white,
                            ),
                            // child: Text('',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 11,
                            //         color: Colors.white))
                          )),
                      GridColumn(
                          columnName: 'Service Name',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.only(right: 30),
                              alignment: Alignment.centerLeft,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    getTranslated('servicename', context),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.white)),
                              ))),
                      GridColumn(
                          columnName: 'servicecharge',
                          label: Container(
                              padding: EdgeInsets.only(right: 20),
                              // alignment: Alignment.center,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  getTranslated('servicecharge', context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white),
                                ),
                              ))),
                      GridColumn(
                          columnName: 'serviceDec',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.only(right: 30),
                              alignment: Alignment.center,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    getTranslated('ServiceDec', context),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.white)),
                              ))),
                      GridColumn(
                          columnName: 'Total',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
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

  Widget _customDivider() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Divider(
        color: appModelTheme.darkTheme ? white : Colors.black38,
      ),
    );
  }

  Widget _delTotal() {
    return Padding(
      // ========================by jenish==========================
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // ========================by jenish==========================
            getTranslated('total', context),
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins1',
            ),
          ),
          Text(
            '',
            // // ========================by jenish==========================
            // // 'KWD ${widget.selectedService['total']}',
            // widget.data.total == null
            //     ? getTranslated("qr", context)! + ' 0.00'
            //     : widget.data.total!.isEmpty
            //         ? getTranslated("qr", context)! + ' 0.00'
            //         : getTranslated("qr", context)! + '$formattedGrossTotal',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins2',
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  acceptbookingApiCall(String jobNumber) async {
    Loader().showLoader(context);
    final ApproveJobCardModel isapprovejobcard =
        await _repository.approveJobCardAPI(jobNumber);
    if (isapprovejobcard.code != '0') {
      Loader().hideLoader(context);
      snackBar(isapprovejobcard.message ?? 'Accept Booking');
      setState(() {});
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      // incomingBookingsBloc.onincomingBookSink(
      //     '2', formatter.format(fromDate), formatter.format(toDate));
      // onSendNotificationAPI();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isapprovejobcard.message != null ? isapprovejobcard.message! : '');
    }
  }

  dynamic onSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin =
        await _repository.onSendNotificationAdminAPI('Payment Confirmed',
            'User has paid for All Tasks. Please start work and update when any work completed');
    Loader().hideLoader(context);
    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfully Paid'),
            content: const Text(
                'Admin has been notified that User had paid for all Work. You will be informed when all work will be completed. Thanks'),
            actions: [
              // FlatButton(
              //   child: const Text('CANCEL'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // onSendNotificationAdminAPI();
                },
              )
            ],
          );
        },
      );
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isAdmin.message != null ? isAdmin.message! : '');
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

Widget textFiled(String title, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 10, top: 10),
    height: 60,
    width: 175,
    decoration: BoxDecoration(
      color: cardgreycolor,
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: title,
          hintStyle: TextStyle(fontSize: 13, fontFamily: 'Poppins3'),
          fillColor: cardgreycolor,
          filled: true),
    ),
  );
}

// ==================================================== PARTS   DATA   TABLE  1 =========================================================
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
              DataGridCell<String>(columnName: 'Remove', value: e.remove),
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
      if (dataGridCell.columnName == 'Remove') {
        return StatefulBuilder(
          builder: (context, setState1) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                setState1(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            Text('Are you sure you want to remove this item?'),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              ondeletepartsapi(value);
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  //
                });
              },
              child: Container(
                child: Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
      }

      return Container(
          // color: getRowBackgroundColor(),
          alignment: Alignment.center,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }

  dynamic ondeletepartsapi(remove) async {
    // show loader
    // Loader().showLoader(context!);
    final DeletepartsModel isDeleteparts =
        await _repository.onDeletepartdata(remove);

    if (isDeleteparts.code != 'true') {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
      viewPartsDataBloc.onViewPartsDataSink(deletejobid.toString());
      // Loader()ideLoader(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(isDeleteparts.message ?? '')));
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isDeleteparts.message != null ? isDeleteparts.message! : '');
    }
  }
}

// class Employee {
//   /// Creates the employee class with required details.
//   Employee(this.partno, this.parttype, this.partdesc, this.quantity,
//       this.estcost, this.total, this.remove);

//   final String partno;
//   final String parttype;
//   final String partdesc;
//   final String quantity;
//   final String estcost;
//   final String total;
//   final String remove;
// }

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   final String? id;
//   final BuildContext context;

//   /// Creates the employee data source class with required details.
//   EmployeeDataSource(
//       {required List<Employee> employeeData, this.id, required this.context}) {
//     _employeeData = employeeData
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'Remove', value: e.remove),
//               DataGridCell<String>(columnName: 'partno', value: e.partno),
//               DataGridCell<String>(columnName: 'parttype', value: e.parttype),
//               DataGridCell<String>(columnName: 'partdesc', value: e.partdesc),
//               DataGridCell<String>(columnName: 'quantity', value: e.quantity),
//               DataGridCell<String>(columnName: 'estcost', value: e.estcost),
//               DataGridCell<String>(columnName: 'total', value: e.total),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _employeeData = [];
//   final _repository = Repository();

//   @override
//   List<DataGridRow> get rows => _employeeData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     // Color getRowBackgroundColor() {
//     //   final int index = effectiveRows.indexOf(row);
//     //   if (index % 2 == 0) {
//     //     return Color(0xffF5FAFF);
//     //   }
//     //   return Colors.transparent;
//     // }

//     return DataGridRowAdapter(
//         // color: getRowBackgroundColor(),
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       if (dataGridCell.columnName == 'Remove') {
//         // ignore: unused_local_variable
//         final int index = effectiveRows.indexOf(row);
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: GestureDetector(
//             // onTap: () => ondeletepartsapi(),
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     content: Text('Are you sure you want to remove this item?'),
//                     actions: [
//                       TextButton(
//                         child: Text("Yes"),
//                         onPressed: () {
//                           ondeletepartsapi(value);
//                         },
//                       ),
//                       TextButton(
//                         child: Text("No"),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//               // ondeletepartsapi(value);
//               // rows.removeAt(index);
//               // print('dfsbfjfhjf === ${index}');
//             },
//             child: Container(
//               child: Icon(
//                 Icons.restore_from_trash_rounded,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         );
//       }

//       return Container(
//           // color: getRowBackgroundColor(),
//           alignment: Alignment.center,
//           child: Text(dataGridCell.value.toString(),
//               style: TextStyle(fontSize: 11)));
//     }).toList());
//   }

//   dynamic ondeletepartsapi(remove) async {
//     // show loader
//     // Loader().showLoader(context!);
//     final DeletepartsModel isDeleteparts =
//         await _repository.onDeletepartdata(remove);

//     if (isDeleteparts.code != 'true') {
//       Navigator.pop(context);
//       FocusScope.of(context).requestFocus(FocusNode());
//       // viewPartsDataBloc.onViewPartsDataSink(deletejobid.toString());
//       // Loader()ideLoader(context);

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(isDeleteparts.message ?? '')));
//     } else {
//       Loader()ideLoader(context);
//       showpopDialog(context, 'Error',
//           isDeleteparts.message != null ? isDeleteparts.message! : '');
//     }
//   }

//   // dynamic ondeletepartsapi() async {
//   //   // show loader
//   //   // Loader().showLoader(context!);
//   //   final DeletepartsModel isDeleteparts =
//   //       await _repository.onDeletepartdata('6');

//   //   if (isDeleteparts.code == true) {
//   //     FocusScope.of(context).requestFocus(FocusNode());
//   //     // Loader()ideLoader(context);

//   //     ScaffoldMessenger.of(context)
//   //         .showSnackBar(SnackBar(content: Text(isDeleteparts.message ?? '')));
//   //   } else {
//   //     Loader()ideLoader(context);
//   //     showpopDialog(context, 'Error',
//   //         isDeleteparts.message != null ? isDeleteparts.message! : '');
//   //   }
//   // }
// }

// ==================================================== Service   DATA  =>  TABLE  2 =========================================================
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
              DataGridCell<String>(columnName: 'Remove', value: e.remove),
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
      if (dataGridCell.columnName == 'Remove') {
        // final int index = effectiveRows.indexOf(row);
        return StatefulBuilder(
          builder: (context, setState2) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            Text('Are you sure you want to remove this item?'),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              ondeleteserviceapi(value1);
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      }
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
          alignment: Alignment.centerLeft,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }

  dynamic ondeleteserviceapi(remove) async {
    // show loader
    // Loader().showLoader(context!);
    final DeleteServiceModel isDeleteservice =
        await _repository.onDeleteservicedata(remove);

    if (isDeleteservice.code != 'true') {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
      viewServicesDataBloc.onViewServicesDataSink(deletejobid.toString());
      // Loader()ideLoader(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(isDeleteservice.message ?? '')));
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isDeleteservice.message != null ? isDeleteservice.message! : '');
    }
  }
}

// class ServicesData {
//   ServicesData(this.serviceDec, this.servicecharge, this.remove);

//   final String serviceDec;

//   final String servicecharge;

//   final String remove;
// }

// class ServicesDataSource extends DataGridSource {
//   final BuildContext context;
//   ServicesDataSource(
//       {required List<ServicesData> servicesdata, required this.context}) {
//     _ServicesData = servicesdata
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'Remove', value: e.remove),
//               DataGridCell<String>(
//                   columnName: 'serviceDec', value: e.serviceDec),
//               DataGridCell<String>(
//                   columnName: 'servicecharge', value: e.servicecharge),
//               // DataGridCell<String>(columnName: 'total', value: e.total),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _ServicesData = [];
//   final _repository = Repository();

//   @override
//   List<DataGridRow> get rows => _ServicesData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         // color: getRowBackgroundColor(),
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       if (dataGridCell.columnName == 'Remove') {
//         final int index = effectiveRows.indexOf(row);
//         return Padding(
//           padding: const EdgeInsets.only(right: 30),
//           child: GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     content: Text('Are you sure you want to remove this item?'),
//                     actions: [
//                       TextButton(
//                         child: Text("Yes"),
//                         onPressed: () {
//                           ondeleteserviceapi(value1);
//                         },
//                       ),
//                       TextButton(
//                         child: Text("No"),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//               // ondeleteserviceapi(value1);
//             },
//             child: Icon(
//               Icons.restore_from_trash_rounded,
//               color: Colors.red,
//             ),
//           ),
//         );
//       }
//       if (dataGridCell.columnName == 'servicecharge') {
//         final int index = effectiveRows.indexOf(row);
//         return Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Container(
//               alignment: Alignment.centerLeft,
//               child: Text('KWD : ${dataGridCell.value.toString()}',
//                   style: TextStyle(fontSize: 11))),
//         );
//       }
//       if (dataGridCell.columnName == 'serviceDec') {
//         final int index = effectiveRows.indexOf(row);
//         return Padding(
//           padding: const EdgeInsets.only(right: 5),
//           child: Container(
//               alignment: Alignment.centerLeft,
//               child: Text(dataGridCell.value.toString(),
//                   style: TextStyle(fontSize: 11))),
//         );
//       }
//       return Container(
//           alignment: Alignment.centerLeft,
//           child: Text(dataGridCell.value.toString(),
//               style: TextStyle(fontSize: 11)));
//     }).toList());
//   }

//   dynamic ondeleteserviceapi(removes) async {
//     // show loader
//     // Loader().showLoader(context!);
//     final DeleteServiceModel isDeleteservice =
//         await _repository.onDeleteservicedata(removes);

//     if (isDeleteservice.code == 1) {
//       Navigator.pop(context);
//       FocusScope.of(context).requestFocus(FocusNode());
//       viewServicesDataBloc.onViewServicesDataSink(deleteserviceid.toString());
//       // Loader()ideLoader(context);

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(isDeleteservice.message ?? '')));
//     } else {
//       Loader()ideLoader(context);
//       showpopDialog(context, 'Error',
//           isDeleteservice.message != null ? isDeleteservice.message! : '');
//     }
//   }
// }
