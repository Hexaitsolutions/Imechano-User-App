// // ignore_for_file: non_constant_identifier_names, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imechano/ui/provider/theme_provider.dart';
// import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
// import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
// import 'package:imechano/ui/styling/colors.dart';
// import 'package:provider/provider.dart';

// class RejectDelivery extends StatefulWidget {
//   const RejectDelivery({Key? key}) : super(key: key);

//   @override
//   _RejectDeliveryState createState() => _RejectDeliveryState();
// }

// class _RejectDeliveryState extends State<RejectDelivery> {
//   dynamic appModelTheme;

//   @override
//   Widget build(BuildContext context) {
//     final appModel = Provider.of<AppModel>(context);
//     appModelTheme = appModel;
//     return Scaffold(
//       appBar: WidgetAppBar(
//         title: 'Reject Delivery',
//         menuItem: 'assets/svg/Menu.svg',
//         imageicon: 'assets/svg/Arrow_alt_left.svg',
//         action2: 'assets/svg/ball.svg',
//       ),
//       drawer: drawerpage(),
//       backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
//       body: ScreenUtilInit(
//           designSize: Size(414, 896),
//           builder: () => Material(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: _ItemsList(),
//                 ),
//               )),
//     );
//   }
// }
