import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return AccordionPage();
    return Scaffold(
      
    );
  }
}

/// Main example page
// class AccordionPage extends StatelessWidget {
//   const AccordionPage({Key? key}) : super(key: key);

//   final headerColor = const Color(0xff222e50);

//   final _headerStyle = const TextStyle(
//       color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
//   final _contentStyleHeader = const TextStyle(
//       color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
//   final _contentStyle = const TextStyle(
//     color: Color(0xff999999),
//     fontSize: 14,
//     fontWeight: FontWeight.normal,
//   );
//   final _loremIpsum =
//       '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (Navigator.of(context).canPop()) {
//           Navigator.pop(context);
//         } else {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => BottomBarPage(2)),
//               (Route<dynamic> route) => false);
//         }
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.blueGrey[100],
//         appBar: WidgetAppBar(
//           title: getTranslated('privacypolicy', context),
//           menuItem: 'assets/svg/Menu.svg',
//           imageicon: 'assets/svg/Arrow_alt_left.svg',
//           home: 'assets/svg/homeicon.svg',
//           action2: 'assets/svg/ball.svg',
//         ),
//         body: Accordion(
//           maxOpenSections: 2,
//           headerBackgroundColor: Colors.blue,
//           headerBackgroundColorOpened: Colors.black54,
//           // scaleWhenAnimating: true,
//           openAndCloseAnimation: true,
//           headerPadding:
//               const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//           sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//           sectionClosingHapticFeedback: SectionHapticFeedback.light,
//           children: [
//             AccordionSection(
//               isOpen: true,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text('Definitions', style: _headerStyle),
//               // contentBorderColor: Color.fromARGB(15, 188, 17, 17),
//               headerBackgroundColorOpened: headerColor,
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     reusableText("1.1. ",
//                         "“Company” means IMechano, a corporation duly registered and incorporated in accordance with the lawsof the state of Qatar."),
//                     reusableText("1.2. ",
//                         "“Services” means the services sold through the application ‘IMechano’, whose services are mentioned in the application."),
//                     reusableText("1.3. ",
//                         "“These Terms” means the terms and conditions of use contained herein."),
//                     reusableText("1.4. ",
//                         "“User” or “You” means the person or legal entity who makes use of the services."),
//                     reusableText("1.5 ",
//                         "“User Accounts” means the account that you will be required to open when registering for the use of the \n services. The account shall contain personal information, including, but not limited to, your full legalname, contact details, payment information, and so on of each user of the service registered on such account."),
//                     reusableText(
//                         "Please read these terms carefully before accessing or using the services.",
//                         null)
//                   ],
//                 ),
//               ),
//             ),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text("Contractual relationship", style: _headerStyle),
//                 headerBackgroundColorOpened: headerColor,
//                 content: Column(
//                   children: [
//                     Text('''
// 2.1. These terms govern the access or use by you, an individual, sole proprietorship, partnership, commercial entity, nonprofit organization, company, or incorporation, and their respective equivalents from within the State of Qatar, where the services are made available by the company.\n
// 2.2. Your access and use of the services constitute your agreement to be bound by these terms, establishing a contractual relationship between you and the company. If you do not agree to these terms, you may not access or use the services. These terms expressly supersede prior agreements or arrangements with you. The company may immediately terminate these terms or any services with respect to you or, generally, cease offering or deny access to the services or any portion thereof at any time for any reason.
// 2.3. Supplemental terms may apply to certain services. Supplemental terms are in addition to and shall be deemed a part of the terms for the purposes of the applicable services. Supplemental terms shall prevail over these terms in the event of a conflict with respect to the applicable services.
// 2.4. The company may amend the terms related to the services from time to time. Amendments will be effective upon the company’s posting of such updated terms at this location or the amended policies or supplemental terms on the applicable service. Your continued access or use of the services after such posting constitutes your consent to be bound by the terms, as amended.
// 2.5. Our collection and use of personal information in connection with the services is provided in the company's privacy policy below. The company may provide a claims processor or an insurer with any necessary information (including your contact information) if there is a complaint, dispute, or conflict and such information or data is necessary to resolve the complaint, dispute, or conflict.
// ''')
//                     // reusableText("2.1. ",
//                     //     "These terms govern the access or use by you, an individual, sole proprietorship, partnership, commercial entity, nonprofit organization, company, or incorporation, and their respective equivalents from within the State of Qatar, where the services are made available by the company."),
                    
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text("Payment and payment terms", style: _headerStyle),
//                 headerBackgroundColorOpened: headerColor,
//                 content: Column(
//                   children: [
//                     reusableText("3.1. ",
//                         "In order to access the services, you will be required to create a free user account and make payment in accordance with the service, or any portion thereof you have been granted access to, and invoiced for by the company, if applicable, free of any set-off, deduction, and, inclusive of any applicable taxes."),
//                     reusableText("3.2. ",
//                         "As of the date of these terms, payment may be made in the following methods credit or debit cards (Visa, MasterCard, annex)."),
//                     reusableText("3.3. ",
//                         "Third-party access: Depending on your payment method, payments may be facilitated with third parties that the company does not control. You acknowledge that different terms of use and privacy policies may apply to your use of such third-party services and content. The company does not endorse such third-party services and content and in no event shall it be responsible or liable for any products or services of such providers. These third parties are not parties to this contract and are not responsible for the provision or support of the services in any manner, accordingly, and without any limitation to any other provision of these terms, the company shall be indemnified and held harmless against any loss or damage occasioned from the use of such services, to the full extent of any applicable law."),
//                     reusableText("3.4. ",
//                         "You further agree that by using our services, the third parties made reference to under paragraph 3.3 may be granted access to all relevant information contained in your user account, for the purposes of facilitating any payment. Should you not consent to make such information available as needed herein, then you shall not be given access to the services."),
//                     reusableText("3.5. ",
//                         "Each additional user on any user account shall be charged separately in accordance with the pricing related to additional users at the time the subscription is purchased."),
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text("Renewal", style: _headerStyle),
//                 headerBackgroundColorOpened: headerColor,
//                 content: Column(
//                   children: [
//                     reusableText("4.1. ",
//                         "The subscription period shall automatically be renewed for the same period in which it was initially purchased."),
//                     reusableText("4.2. ",
//                         "Should you wish to opt out of access to the services with the company at the end of the subscription period, then you may do so subject to the company receiving written notice within 30 days prior to the expiration of the subscription period.")
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 headerBackgroundColorOpened: headerColor,
//                 header: Text("License", style: _headerStyle),
//                 content: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     reusableText("5.1. ",
//                         "Subject to your compliance with these terms, the Company grants you a limited, non-exclusive, non-sublicensable, revocable, non-transferable license to :"),
//                     reusableText("(i).     ",
//                         "access and use the services on your personal device solely in connection with your use of the services"),
//                     reusableText(("(ii).     "),
//                         "access and use any content, information, and related materials that may be made available through the services. Any rights not expressly granted herein are reserved by the company and the company’ slicensors."),
//                     reusableText("5.2. Restrictions: ", "\n      You may not"),
//                     reusableText("(i)  ",
//                         "remove any copyright, trademark, or other proprietary notices from any portion of the services;"),
//                     reusableText("(ii)  ",
//                         "reproduce, modify, prepare derivative works based upon, distribute, license, lease, sell, resell, transfer, publicly display, publicly perform, transmit, stream, broadcast, or otherwise exploit the services except as expressly permitted by the company;"),
//                     reusableText("(iii)  ",
//                         "decompile, reverse engineer or disassemble the services except as may be permitted by applicable law; "),
//                     reusableText("(iv)  ",
//                         "link to, mirror, or frame any portion of the services;"),
//                     reusableText("(v)  ",
//                         "cause or launch any programs or scripts for the purpose of scraping, indexing, surveying, or otherwise data mining any portion of the services or unduly burdening or hindering the operation and/or functionality of any aspect of the services; or"),
//                     reusableText("(vi)  ",
//                         "attempt to gain unauthorized access to or impair any aspect of the services or its related systems or networks."),
//                     reusableText("5.3. Ownership: ",
//                         "\n      The services and all rights therein are and shall remain the company’s property or the property of the company’s licensors. Neither these Terms nor your use of the services conveys or grants to you any rights:"),
//                     reusableText("(i)  ",
//                         "in or related to the services except for the limited license granted above; or"),
//                     reusableText("(ii)  ",
//                         "to use or reference in any manner the company‘s company names, logos, product and service names, trademarks or services marks, or those of the company’s licensors."),
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text("Your Use of the Services", style: _headerStyle),
//                 headerBackgroundColorOpened: headerColor,
//                 content: Column(
//                   children: [
//                     reusableText("6.1 User accounts:",
//                         "\n      To use most aspects of the services, you must register for and maintain an active user account. You must be at least 18 years of age, or the age of the legal majority in your jurisdiction (if different than 18), to obtain a user account. User account registration requires you to submit to the company certain personal information, such as yourname, address, mobile phone number, and age, as well as one valid payment method, where the company charges for access to the service as referred to under paragraph 3 above. You agree to maintain accurate, complete, and up-to-date information on your account. Your failure to maintain accurate, complete, and up-to-date account information, including having an invalid or expired payment method on file, may result in your inability to access and use theservices or the company‘s termination of these terms with you. You are responsible for all activity that occurs under your user account, and you agree to always maintain the security and secrecy of your user account username and password."),
//                     reusableText("6.2 Conduct and restrictions:",
//                         "\n      The service is not available for use by people under the age of 18. You may not authorize third parties to use your user account, and you may not allow persons under the age of 18 to request the services. You may not assign or otherwise transfer your user account to any other person or entity. You agree to comply with all applicable laws when using the services, and you may only use the services for lawful purposes."),
//                     reusableText("6.3 Warranty of authority:",
//                         "\n      Where the user account is for a legal entity, then the party agreeing to these terms warrants that they are possessed of the necessary rights, power, and authority to legally bind the legal entity to these terms.")
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 headerBackgroundColorOpened: headerColor,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text("Personal information", style: _headerStyle),
//                 content: Column(
//                   children: [
//                     reusableText("7.1. ",
//                         "Personal information collected, uploaded, and stored through the service is governed by the company’s privacy policy, the terms of which can be located here"),
//                     reusableText("7.2. ",
//                         "The privacy policy also encompasses your right to opt out of any communications from the company related to marketing and newsletters, however, it excludes the right to opt out ofadministrative messages and service announcements."),
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 header:
//                     Text("Termination and refund policy", style: _headerStyle),
//                 headerBackgroundColorOpened: headerColor,
//                 content: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     reusableText("8.1. ",
//                         "Your user account may be restricted or terminated, without any further notice, on thefollowing basis: \n "),
//                     reusableText("8.1.1 ",
//                         "The user account be flagged for any illegal or suspicious activity bythe company, its duly authorized representative responsible for data security, or any governmental organization;"),
//                     reusableText("8.1.2 ",
//                         "Should the user account be flagged for any illegal or suspicious activity, bythe company, its duly authorized representative responsible for data security, or any governmental organization;"),
//                     reusableText("8.1.3 ",
//                         "Where there are extended periods of inactivity; or"),
//                     reusableText("8.1.4 ",
//                         "Where the company, in its sole and absolute discretion, determines that there is a material breach of these terms."),
//                     reusableText("8.2 ",
//                         "The user shall be entitled to cancel the service within 7 days from the date of acceptance of these terms with respect to a monthly subscription period."),
//                     reusableText("8.3 ",
//                         "Should these terms be canceled for any reason whatsoever, including for the reasons as set out in this paragraph 8, or the user failing to access or use the services, then the user shall not be entitled to any reimbursement or refund, in whole or in part for the sei vices.")
//                   ],
//                 )),
//             AccordionSection(
//                 isOpen: false,
//                 leftIcon:
//                     const Icon(Icons.compare_rounded, color: Colors.white),
//                 headerBackgroundColorOpened: headerColor,
//                 header: Text("Force Majeure", style: _headerStyle),
//                 content: Column(
//                   children: [
//                     reusableText("9.1. ",
//                         "The company will not be held liable for any loss, damage, or misuse of the personal information of the users due to force majeure. A “force majeure event“ for the purposes of these terms shall mean any event that is beyond the reasonable control of the company and shallinclude, without limitation, sabotage, fire, flood, explosion, acts of god, civil commotion, strikes or industrial action of any kind, riots, insurrection, war, acts of government, computer hacking, unauthorized access to computer data and storage device, computer viruses breach of security and encryption or any other cause beyond the control of the company.")
//                   ],
//                 )),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text("Disclaimers; limitation of liability; indemnity",
//                   style: _headerStyle),
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('1.	How does the IMechano app work?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('2.	How can I refer IMechano to someone?',
//                         style: _headerStyle),
//                     content: Text(
//                       "The app name is unique, just tell them to download the IMechano app. ",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '3.	What is the detailed mechanism of IMechano?',
//                         style: _headerStyle),
//                     content: Text(
//                       "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Please email us at info@IMechano.com.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text("Governing Law: Arbitration", style: _headerStyle),
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('1.	How does the IMechano app work?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('2.	How can I refer IMechano to someone?',
//                         style: _headerStyle),
//                     content: Text(
//                       "The app name is unique, just tell them to download the IMechano app. ",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '3.	What is the detailed mechanism of IMechano?',
//                         style: _headerStyle),
//                     content: Text(
//                       "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Please email us at info@IMechano.com.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text("Other Provisions", style: _headerStyle),
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('1.	How does the IMechano app work?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('2.	How can I refer IMechano to someone?',
//                         style: _headerStyle),
//                     content: Text(
//                       "The app name is unique, just tell them to download the IMechano app. ",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '3.	What is the detailed mechanism of IMechano?',
//                         style: _headerStyle),
//                     content: Text(
//                       "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Please email us at info@IMechano.com.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text("IMechano Privacy Policy", style: _headerStyle),
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('1.	How does the IMechano app work?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('2.	How can I refer IMechano to someone?',
//                         style: _headerStyle),
//                     content: Text(
//                       "The app name is unique, just tell them to download the IMechano app. ",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '3.	What is the detailed mechanism of IMechano?',
//                         style: _headerStyle),
//                     content: Text(
//                       "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Please email us at info@IMechano.com.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//             AccordionSection(
//               isOpen: false,
//               leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//               header: Text("Our Cookies Policy", style: _headerStyle),
//               content: Accordion(
//                 maxOpenSections: 1,
//                 headerBackgroundColorOpened: Colors.black54,
//                 headerPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                 children: [
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('1.	How does the IMechano app work?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text('2.	How can I refer IMechano to someone?',
//                         style: _headerStyle),
//                     content: Text(
//                       "The app name is unique, just tell them to download the IMechano app. ",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '3.	What is the detailed mechanism of IMechano?',
//                         style: _headerStyle),
//                     content: Text(
//                       "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                   AccordionSection(
//                     isOpen: true,
//                     leftIcon:
//                         const Icon(Icons.compare_rounded, color: Colors.white),
//                     headerBackgroundColor: Colors.black38,
//                     headerBackgroundColorOpened: Colors.black54,
//                     header: Text(
//                         '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
//                         style: _headerStyle),
//                     content: Text(
//                       "Please email us at info@IMechano.com.",
//                       style: _contentStyle,
//                     ),
//                     contentHorizontalPadding: 20,
//                     contentBorderColor: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget cardone() {
//     return Column(
//       children: [
//         Text(
//           'Anyone who has ever dabbled in DIY auto repair can tell you: you’re probably going to have some questions (and say some swear words) along the way.',
//           style: _contentStyle,
//           textAlign: TextAlign.justify,
//         ),
//         Text(
//           '\nOur family has been in the automotive business for a long time, and, throughout the years, we’ve noticed that customers often have questions about the same things. To save you time and make us look smart, we created this all-in-one resource filled with answers to the most common questions we hear or have dealt with ourselves.',
//           style: _contentStyle,
//           textAlign: TextAlign.justify,
//         ),
//         Text(
//           '\nRead on for helpful tips and tutorials from our team of automotive experts on everything from the dreaded check engine light to brakes, DIY oil changes, wipers, batteries, changing your tires, and more. There are no stupid questions. There are, however, bad DIY jobs—and we would like it if your car didn’t blow up.',
//           style: _contentStyle,
//           textAlign: TextAlign.justify,
//         ),
//       ],
//     );
//   }

//   Widget reusableText(String? boldText, String? text) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5.0),
//         child: RichText(
//           textAlign: TextAlign.start,
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: boldText,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//               TextSpan(
//                 text: text,
//                 style: _contentStyle,
//               ),
//             ],
//           ),
//         ));
//   }
// } //__
