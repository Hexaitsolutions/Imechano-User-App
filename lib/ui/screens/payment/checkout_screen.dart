// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imechano/ui/screens/payment/widgets/custom_divider.dart';
// import 'package:imechano/ui/screens/payment/widgets/custom_tag.dart';
// import 'package:imechano/ui/screens/payment/widgets/delivery_address.dart';
// import 'package:imechano/ui/screens/payment/widgets/payment_method.dart';
// import 'package:provider/provider.dart';

// import '../../../localization/language_constrants.dart';
// import '../../provider/theme_provider.dart';
// import '../../shared/widgets/appbar/custom_appbar_widget.dart';
// import '../../styling/colors.dart';

// class Checkout extends StatelessWidget {
//   Checkout({Key? key}) : super(key: key);
//   dynamic appModelTheme;
//   @override
//   Widget build(BuildContext context) {
//     final appModel = Provider.of<AppModel>(context);
//     final appModelTheme = appModel;
//     return Scaffold(
//         backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
//         appBar: WidgetAppBar(
//           title: 'Checkout',
//           imageicon: 'assets/svg/Arrow_alt_left.svg',
//           // action: 'assets/svg/shopping-cart.svg',
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: appModelTheme.darkTheme ? Color(0xff252525) : white,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(25.0),
//                 topLeft: Radius.circular(25.0)),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//             child: Column(
//               children: [
//                 SizedBox(height: 15.h),
//                 DeliveryAddress(),
//                 SizedBox(height: 15.h),
//                 CustomDivider(),
//                 SizedBox(height: 15.h),
//                 PaymentMethod()
//               ],
//             ),
//           ),
//         ));
//   }
// }
