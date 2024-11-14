import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/pickup_condition_list_bloc.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/accept_pickup_model.dart';
import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/modal/pickup_conditions_list_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../styling/image_enlarge.dart';

class ConfirmPayDetail extends StatefulWidget {
  ItemData data;
  int selectedindex;
  ConfirmPayDetail({Key? key, required this.data, required this.selectedindex})
      : super(key: key);

  @override
  State<ConfirmPayDetail> createState() => _ConfirmPayDetailState();
}

class _ConfirmPayDetailState extends State<ConfirmPayDetail> {
  var grossTotal = 0.00;
  // Create a NumberFormat instance for formatting
  var numberFormat = NumberFormat('#,##0.00', 'en_US');
  String formattedGrossTotal = '';
  @override
  void initState() {
    super.initState();
    getTotal();
  }

  getTotal() {
    var total = widget.data.total;
    var deliveryCharges = widget.data.deliveryCharges;
    if (total != null && deliveryCharges != null) {
      grossTotal = ((double.tryParse(total) ?? 0.00) +
          (double.tryParse(deliveryCharges) ?? 0.00));

      // Format the grossTotal value with commas and two decimal places
      formattedGrossTotal = numberFormat.format(grossTotal);
    }
  }

  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    pickupConditionsListBloc
        .pickupConditionsListSink(widget.data.bookingId.toString());
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      backgroundColor: Color(0xff70BDF1),
      appBar: WidgetAppBar(
        title: getTranslated("confirmpickup", context),
        //menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action2: 'assets/svg/ball.svg',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 100,
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        _cardList(widget.data),
                        SizedBox(height: 15),
                        _delChange(),
                        SizedBox(height: 15),
                        _customDivider(),
                        SizedBox(height: 15),
                        _delTotal(widget.data),
                        SizedBox(
                          height: 15,
                        ),
                        _acceptRejectBox(
                            context, widget.data, widget.selectedindex),
                        SizedBox(height: 15),
                        dynamicBottomCard(),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardList(ItemData data) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.items?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 23, right: 23),
                  child: data.items![index].subCategoryId == "10013"
                      ? Text(
                          data.items![index].item!.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Poppins1',
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          getTranslated(
                              data.items![index].item!
                                  .toString()
                                  .removeAllWhitespace,
                              context),
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Poppins1',
                            color: Colors.grey,
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: presenting,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins1',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '250 Ratings',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17, top: 15, right: 17),
                  child: Text(
                    DateFormat('hh:mm a dd-MM-yy')
                        .format(DateTime.parse(data.updatedAt!)),
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Poppins1',
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _delChange() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated('deliverycharges', context),
            // ========================by jenish==========================
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins1',
            ),
          ),
          // ========================by jenish==========================
          Text(
            widget.data.deliveryCharges == null
                ? 'QR 0.00'
                : widget.data.deliveryCharges!.isEmpty
                    ? 'QR 0.00'
                    : 'QR ${widget.data.deliveryCharges}.00',
            //getTranslated('qr', context)!,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins2',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customDivider() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Divider(
          // color: appModelTheme.darkTheme ? white : Colors.black38,
          ),
    );
  }

  Widget _delTotal(ItemData data) {
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
            // ========================by jenish==========================
            // 'KWD ${widget.selectedService['total']}',
            widget.data.total == null
                ? 'QR 0'
                : widget.data.total!.isEmpty
                    ? 'QR 0'
                    : 'QR $formattedGrossTotal',
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

  Widget _acceptRejectBox(
      BuildContext context, ItemData data, int selectedindex) {
    Repository repository = Repository();
    return Padding(
        padding: const EdgeInsets.only(left: 27, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 6.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent, // This is what you need!
                ),
                child: Text(
                  getTranslated('approve', context),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins2',
                    color: white,
                  ),
                ),
                onPressed: () async {
                  await AcceptPickupcall(
                      data.bookingId.toString(), context, repository);
                  data.confirmedpickup = false;
                  selectedindex = 4;
                  currentBookingTab = 3;
                  Get.offAll(() => BottomBarPage(1));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.0, right: 6.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // This is what you need!
                ),
                child: Text(
                  getTranslated("reject", context),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 13, fontFamily: 'Poppins2', color: white),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                  RejectPickupcall(
                      data.bookingId.toString(), context, repository);
                },
              ),
            ),
            // Spacer(),
            // Padding(
            //   padding: EdgeInsets.only(left: 6.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.red, // This is what you need!
            //     ),
            //     child: Text(
            //       getTranslated('close', context)!,
            //       textAlign: TextAlign.end,
            //       style: TextStyle(
            //           fontSize: 13, fontFamily: 'Poppins2', color: white),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ),
          ],
        ));
  }

  Widget dynamicBottomCard() {
    return StreamBuilder<PickupConditionsListModel>(
        stream: pickupConditionsListBloc.ConditionsListStream,
        builder: (context,
            AsyncSnapshot<PickupConditionsListModel> conditionsListsnapshort) {
          if (!conditionsListsnapshort.hasData) {
            return Center(
                child: conditionsListsnapshort.data == null
                    ? CircularProgressIndicator()
                    : Text(
                        getTranslated('NoDataSelected', context),
                        style: TextStyle(fontFamily: 'Poppins1', fontSize: 18),
                      ));
          }
          return Container(
            key: UniqueKey(),
            child: NotificationListener<OverscrollIndicatorNotification>(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: conditionsListsnapshort.data!.data!.length,
                  // reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          // height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0))),
                          child: Frontbumber(
                              "${conditionsListsnapshort.data!.data![index].label}",
                              "${conditionsListsnapshort.data!.data![index].carCondition}",
                              "${conditionsListsnapshort.data!.data![index].workNeeded}",
                              "${conditionsListsnapshort.data!.data![index].carImage}"),
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }

  Widget Frontbumber(
      String label, String carCondition, String workNeeded, String image) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10),
            child: Text(
              "$label",
              style: TextStyle(fontFamily: "Poppins1", fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100, // Adjust the height as needed
                    child: carImage(image),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              bottomCard(carCondition, workNeeded),
            ],
          )
        ],
      ),
    );
  }

  Widget carImage(String images) {
    if (images.contains(',')) {
      final split = images.split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };
      var containers = "";

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: values.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => ImageDialog(
                  imageUrl: Config.imageurl + values[index]!,
                ),
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              margin: EdgeInsets.all(8), // Adjust margins as needed
              child: Image.network(
                Config.imageurl + values[index]!,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Image.network(
          Config.imageurl + images,
          fit: BoxFit.fitWidth,
        ),
      );
    }
    // return Container(
    //   width: 100,
    //   height: 100,
    //   color: Colors.grey,
    //   child: Image.network(
    //     Config.imageurl+image,
    //     fit: BoxFit.fitWidth,
    //   ),
    // );
  }

  Widget bottomCard(String carCondition, String workNeeded) {
    return Expanded(
        child: Column(
      children: [
        Material(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: cardgreycolor2,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              title: Text(
                getTranslated("pickupcondition", context),
                style: TextStyle(
                    color: greycolorfont, fontSize: 9, fontFamily: "Poppins3"),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text("$carCondition",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontFamily: "Poppins3")),
              ),
            ),
          ),
        ),
        Material(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: cardgreycolor2,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              title: Text(
                getTranslated('typeofworkneeded', context),
                style: TextStyle(
                    color: greycolorfont, fontSize: 9, fontFamily: "Poppins3"),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text("$workNeeded",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontFamily: "Poppins3")),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget cardPoint(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 3),
      child: Row(
        children: [
          Image(
              height: 10,
              image: AssetImage("assets/icons/My Account/Ellipse 27.png")),
          Text(title)
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Payment"),
              content: Text("Payment gateway will appear here."),
              actions: [
                new TextButton(
                  child: const Text("Pay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Thank you"),
                              content: Text(
                                  "We will contact you to visit and collect data of car before pickup!"),
                              actions: [
                                new TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                ),
              ],
            ));
  }

  AcceptPickupcall(
      String bookingId, BuildContext context, Repository repository) async {
    Loader().showLoader(context);
    final AcceptpickuprequestModel ispickrequest =
        await repository.onAcceptPickupApi(bookingId);
    print("COde");
    print(ispickrequest.code);
    if (ispickrequest.code != '0') {
      Loader().hideLoader(context);
      showSnackBar(
          context, ispickrequest.message ?? '"Pickup Confirmation Accepted"');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarPage(1)),
          (Route<dynamic> route) => false);
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          ispickrequest.message != null ? ispickrequest.message! : '');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarPage(1)),
          (Route<dynamic> route) => false);
    }
  }

  RejectPickupcall(
      String bookingId, BuildContext context, Repository repository) async {
    Loader().showLoader(context);
    final AcceptpickuprequestModel ispickrequest =
        await repository.onRejectPickupApi(bookingId);
    if (ispickrequest.code != '0') {
      Loader().hideLoader(context);
      showSnackBar(
          context, ispickrequest.message ?? '"Pickup Confirmation Rejected"');

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarPage(1)),
          (Route<dynamic> route) => false);
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          ispickrequest.message != null ? ispickrequest.message! : '');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarPage(1)),
          (Route<dynamic> route) => false);
    }
  }
}
