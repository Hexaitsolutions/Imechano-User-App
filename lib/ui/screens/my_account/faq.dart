import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FAQsPage();
  }
}

/// Main example page
class FAQsPage extends StatefulWidget {
  FAQsPage({Key? key}) : super(key: key);

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);

  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);

  final _contentStyle = const TextStyle(
    color: Color(0xff999999),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 300.0, // adjust this value as needed
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.offset - 300.0, // adjust this value as needed
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomBarPage(2)),
              (Route<dynamic> route) => false);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: WidgetAppBar(
          title: "IMechano FAQs",
          menuItem: 'assets/svg/Menu.svg',
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          home: 'assets/svg/homeicon.svg',
          action2: 'assets/svg/ball.svg',
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Listener(
            onPointerMove: (PointerMoveEvent event) {
              // event.position.dy > 0 ? _scrollUp() : _scrollDown();
              if (sqrt(pow(event.delta.dy, 2) + pow(event.delta.dx, 2)) > 1) {
                event.delta.dy > 0 ? _scrollUp() : _scrollDown();
              }
              print(sqrt(pow(event.delta.dy, 2) + pow(event.delta.dx, 2)));
            },
            child: Accordion(
              maxOpenSections: 2,
              headerBackgroundColorOpened: Colors.black54,
              // scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,

              children: [
                AccordionSection(
                  isOpen: true,
                  scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                  leftIcon:
                      const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text(getTranslated("diveinto", context),
                      style: _headerStyle),
                  contentBorderColor: const Color(0xffffffff),
                  headerBackgroundColorOpened: Colors.amber,
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        cardone(),
                        Accordion(
                          maxOpenSections: 1,
                          headerBackgroundColorOpened: Colors.black54,
                          headerPadding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          children: [
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              header: Text(getTranslated("faqq1", context),
                                  style: _headerStyle),
                              content: SingleChildScrollView(
                                  child: Text(
                                getTranslated("faqa1", context),
                                style: _contentStyle,
                              )),
                              contentHorizontalPadding: 20,
                              contentBorderColor: Colors.black54,
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(getTranslated("faqq2", context),
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(getTranslated("faqa2", context),
                                      style: _contentStyle),
                                  Text(getTranslated("faqa2a", context),
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(getTranslated("faqq3", context),
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Text(getTranslated("faqa3", context),
                                  style: _contentStyle),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '4.	Why should I have my cooling system flushed?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Text(
                                  "It is best to have the cooling system flushed at the intervals recommended by the manufacturer. Having the system flushed once a year is commonly recommended if the vehicle is driven regularly. Coolant breaks down over time, becoming corrosive which can cause premature failure of gaskets and seals. The idea is to replace the coolant before it gets contaminated to avoid costly repairs.",
                                  style: _contentStyle),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '5.	Why should I have my tires rotated and balanced?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Text(
                                  "Rotating your tires every 3rd oil change or 9,000 miles (based on tire application) helps insure the life of the tire and its warranty. Avoidance of this can cause tire damage (cupping) and may make the steering of the vehicle difficult. Pay close attention to the tread depth of your tires to observe that the wear patterns are equal.",
                                  style: _contentStyle),
                            ),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '6.	Why should I have my differential and transfer case fluids changed?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "It is best to have the differential and transfer case fluids replaced at the intervals recommended by the manufacturer under normal driving conditions. Under severe conditions, it may be advisable to have the fluids changed more often. The fluids in these units do become contaminated over time, and during normal use can lose their lubrication qualities.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '7.	Why should I have my transmission fluid flushed at regular intervals?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "It is best to have the transmission fluid flushed at the intervals recommended by the manufacturer under normal driving conditions. Under severe service, it may be advisable to have it flushed more often. Transmission fluid breaks down over time due to 4extreme temperatures during operation. The idea is to replace the fluid before it looks dark or smells burned so the transmission can operate at its best. This will prolong the life of the transmission and head off costly repairs and inconvenience for you.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '8.	What Should I Do When My Check Engine Lights Come On?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " When your check engine light comes on, there could be several issues. It could be something basic, like a loose gas cap, or it could be something serious. The best way to ensure that you are safe behind the wheel is to bring your vehicle into our shop for a multi-point inspection. We can find the issue and make you aware of it so you can choose whether or not you want to take the next steps to get your vehicle back to peak conditions.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '9.	What Happens If I Ignore My Low Tire Pressure Warning Light?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " If your tire pressure is low, then it can cause uneven wear on your tires. That means that one tire may wear faster than another forcing you to have to replace all of your tires sooner. This can be quite costly. Low tire pressure also puts you at risk of popping your tire sooner. When you drive down the highway you may also feel your vehicle pulling to one side of the road because of this. Also, low tire pressure forces your vehicle to use more power to generate the same amount of speed, costing you more gas and money!",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '10.	How Often Should I Have My Brakes Checked?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " It is important to have your brakes checked often. Most folks have their brakes checked when they have their tires rotated. One of the mechanics at our service center can check the thickness of your brake pads to ensure that they are running in peak condition. Your brake pads are essential for maintaining stopping power, so be sure to have them checked every chance that you get.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '11. 	How Often Should I Have My Brake Pads Replaced?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " Your brake pads should be replaced when they are worn down. If you don't replace your brake pads in a timely fashion then it can severely reduce your stopping power. This puts you and the folks around you in danger. Not replacing your brake pads also means that your brakes will wear on your brake discs. This will wear them out and cause more costly repairs down the line.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '12.	 What Type of Oil Filter Do I Need?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "The type of filter that your vehicle needs depend on the type of oil that it needs. Conventional oil needs to be changed about every 3,000 miles and only requires a conventional filter. Synthetic oil, on the other hand, lasts much longer. It can last anywhere between 6,000 and 12,000 miles.  ",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text('13.	What Type of Oil Do I Need?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "There are a few distinct types of oil. The best way to check to see what oil your vehicle uses is to check the owner's manual. This will tell you whether your vehicle uses synthetic or conventional oil. Conventional oil wears out sooner and needs to be changed more frequently than synthetic oil so be sure to know the distinction.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    "14.	What Happens When I Don't Change My Oil?",
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " Oil is the lubricant that keeps your vehicle running. If you choose not to change your oil then it will completely break down and leave sludge in your vehicle's engine. This will wear your engine over time and cause it to break down much sooner.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text('15.  Do I Need Winter Tires?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "In a one-word answer? Yes. Winter tires provide more traction in slippery conditions which can help keep you on the road and away from the side of the road. They also help you get up slippery hills. That means while others are left on the side of the road, you will be cruising to your destination with complete peace of mind.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '16. 	What is the Point of a Tire Rotation?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    "A tire rotation… well… rotates your tires. This causes the wear on your tires to be redistributed to other parts, which will extend the life of your tires. If you don't rotate your tires then the wear on them will be centralized to one spot, forcing it to be replaced sooner. With centralized wear, your tires may even pop sooner so be sure to rotate your tires!",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '17.	Why Does My Vehicle Need Coolant Flush?',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Text(
                                    " Your coolant is what helps keep your vehicle from overheating. It, just like your vehicle's oil, can break down and cause sludge. This wears down your vehicle and could cause it to overheat. This is not good. A coolant flush allows you to get rid of all of that broken-down coolant and replace it with clean coolant. It also allows you to clean out a bit of that broken-down coolant, preventing it from causing further damage to your engine.",
                                    style: _contentStyle)),
                            AccordionSection(
                                isOpen: true,
                                leftIcon: const Icon(Icons.compare_rounded,
                                    color: Colors.white),
                                header: Text(
                                    '18.	Why is My Check Engine Light On? ',
                                    style: _headerStyle),
                                headerBackgroundColor: Colors.black38,
                                headerBackgroundColorOpened: Colors.black54,
                                contentBorderColor: Colors.black54,
                                content: Column(
                                  children: [
                                    Text(
                                        "We have all been there before. You are driving along when you notice a yellow light out of the corner of your eye. A glance at the dash confirms your fear. It is the check engine light. If you are like most car owners, you are not sure if you should continue to panic or not, and you have little idea what that light is trying to tell you or how you should react.",
                                        style: _contentStyle),
                                    Text(
                                        "\nThe often-misunderstood check engine light or “service engine soon” message can mean many different things. It could be a misfiring engine, a broken oxygen sensor, or simply a loose gas cap.",
                                        style: _contentStyle),
                                    Text(
                                        "\nWhen you see the check engine light it doesn’t necessarily mean you need to pull the car over to the side of the road and call a tow truck. It does mean you should get the car checked out as soon as possible. If you ignore the warning, you could end up causing further damage. It could also be a sign that you are getting poor fuel economy and emitting elevated levels of pollutants.",
                                        style: _contentStyle),
                                    Text("\nBut what can you do yourself?",
                                        style: _contentStyle),
                                    Text(
                                        "\nIf your check engine light is on, the first thing to do is look for a serious problem that requires immediate attention. Check your dashboard gauges and lights for indications of low oil pressure or overheating. These conditions mean you should pull over and shut off the engine as soon as you can find a safe place to do so. On some cars, a yellow “check engine” means investigate the problem, while a red “check engine” means stop right now.",
                                        style: _contentStyle),
                                    Text(
                                        "\nNext, try tightening your gas cap. This often solves the problem. Keep in mind that it may take several trips before the light resets. Some vehicles have a separate indicator that warns of a loose gas cap before the condition sets off the “check engine” light.",
                                        style: _contentStyle),
                                    Text(
                                        "\nReduce your speed and, if possible, the weight you’re carrying. If the “check engine” light is blinking or you notice any serious performance problems, such as a loss of power, reduce your speed and try to reduce the load on the engine. For example, it would be a good idea to stop towing a trailer. Have the car checked as soon as possible to prevent expensive damage.",
                                        style: _contentStyle),
                                    Text(
                                        "\nEven if you don’t notice an extreme problem, you should still have the check engine code read and the problem fixed. If you want to diagnose the malfunction yourself, you can buy a scan tool at most auto parts stores. Prices range from about \$40 to several hundred, depending on the model and the features. These tools will give you instructions on how to decipher the engine codes. If you do not have to mechanical skills already to diagnose and fix the problem, it’s a more cost-effective decision to go directly to a service Centre. At our service Centre, we have factory-trained technicians who can easily check and diagnose what is behind your check engine light message, at a cost that is nearly always lower than a private garage.",
                                        style: _contentStyle),
                                    Text(
                                        "\nCall Us Today at (204) 272-6125 to get the best of the fixes!",
                                        style: _contentStyle),
                                  ],
                                )),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '19.	How Do I Check My Engine Oil Level?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Checking your car’s oil level is one of the most vital things that you can do to extend the life of your engine. Not only is it important, but it is a very fast and simple task to complete as well.",
                                      style: _contentStyle),
                                  Text(
                                      "\nFollow the steps below to check your oil level…",
                                      style: _contentStyle),
                                  Text(
                                      "\nFirst, make sure that you are parked on level ground, for the most accurate reading.",
                                      style: _contentStyle),
                                  Text(
                                      "\nNext, safely prop your hood open and find the dipstick (which generally has a brightly colored handle, usually orange, and has the word OIL labeled on it).",
                                      style: _contentStyle),
                                  Text(
                                      "\nPull the dipstick out and wipe it down with a towel or rag, and then replace it with the engine, making sure that it goes all the way in.",
                                      style: _contentStyle),
                                  Text(
                                      "\nNow, pull the dipstick back out and be sure NOT to turn the stick upside down to read as the oil will run and you will not have an accurate reading. The dipstick will have two marks on the bottom (usually lines or holes in the stick), and you can read the oil level by looking to see where the oily section and dry section meet. If you find this mark between the two then you are all set!",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf it is below the bottom mark that means that you need to fill the oil. When you do this, be sure to never fill it more than a quart at a time without checking the level again, as you do not want to overfill the engine.",
                                      style: _contentStyle),
                                  Text(
                                      "\nMost manufacturers consider normal oil consumption to be 1 liter per 1,600 kilometers, if you find you are using much more than this you might want to schedule a service appointment. Our service professionals will check to see if a little preventative maintenance can save you from having any major issues down the road.",
                                      style: _contentStyle),
                                  Text(
                                      "\nCall Our Service Team at (204) 272-6125 to schedule your next oil change.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '20.	How Often Should I Change My Oil?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Changing your vehicle’s oil at the recommended intervals is the best thing you can do to ensure it has a long life. As simple as this task may sound, many people are confused about exactly how often their car’s oil needs to be changed.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIn the past, it was standard for oil changes to occur every 5,000 kilometers, or three months, whichever came first. Now, that standard does not always apply. Oil quality has improved over the years, and the automotive industry has begun to take drivers’ travel and driving habits into account when making recommendations. As such, how often you change your oil should depend on your personal driving habits.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you use the car only for short trips on city streets, particularly in freezing weather, you probably should have the oil changed every three months. Why? On a short trip, the engine doesn’t reach its proper operating temperature, which can cause condensation of water inside the crankcase and oil can be diluted by gasoline.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you mostly use your car for occasional longer trips, it is acceptable to wait six months or more to change the oil.",
                                      style: _contentStyle),
                                  Text(
                                      "\nWhile you can always change your oil on your own, at our dealership we offer a fast oil change service at a fair price, allowing you to go about your day without breaking your wallet. ",
                                      style: _contentStyle),
                                  Text(
                                      "\nAnother thing you should consider when deciding when your oil needs to be changed is your car warranty. Many manufacturers specifically require warranty holders to change the oil based on time. If this is the case for you, it is worth it to change the oil according to the guidelines until the warranty expires. If your engine needs a warranty-covered repair in the future, your manufacturer might decline to cover it if you did not follow their recommended timeline for oil changes. To avoid a headache, follow their recommendations.",
                                      style: _contentStyle),
                                  Text(
                                      "\nOne more reason why the manufacturer’s recommendations are worth considering is that the automaker has done extensive testing on your vehicle’s engine to define the recommendation. Their recommendations are based on lab and real-world driving to determine how it performs under many conditions. Through that testing, they have developed a set of guidelines for maintenance and the frequency of oil changes.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you have lost your owner’s manual, you can give us a call at (204) 272-6125",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you’re still unsure about when it’s the right time to change your oil, feel free to contact our service department. Our certified technicians will be happy to help.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('21.	How Do I Change a Tire?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Sooner or later, it happens to the best of us, we get a flat tire. Most of us have a roadside assistance membership of some kind but it is always good to know how to do this.",
                                      style: _contentStyle),
                                  Text("\n1.	Safety First:",
                                      style: _contentStyle),
                                  Text(
                                      "\nFind a safe spot to pull over. If you’re on the highway, getting off is the safest bet, even if you have to drive on a blown tire. Otherwise, pull as far onto the shoulder as possible.\n\nDon’t park in the middle of a curve, where approaching cars can’t see you.\n\nChoose a flat spot, jacking up your car on a hill can be a disaster.\n\nIf you have a manual transmission, leave your car in gear.\n\nBe sure to set your parking brake!",
                                      style: _contentStyle),
                                  Text("\n2.	Turn on your hazard lights.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Get the jack, wrench, and spare tire from the trunk of the car and bring them over to the flat tire. Use other tools or supplies if needed.",
                                      style: _contentStyle),
                                  Text("\n4.	Loosening the Lug Nuts:",
                                      style: _contentStyle),
                                  Text(
                                      "\nUse the wrench to loosen the lug nuts.\n\nYou may need to remove the hubcap. Do not remove the lug nuts at this point; simply loosen them by turning the wrench to the left (counterclockwise).\n\nIf the lug nuts are tight, try placing the wrench on the nut and standing on the wrench arm to use your full weight on it.\n\nYou can also try hitting the wrench arm with a rock.",
                                      style: _contentStyle),
                                  Text(
                                      "\n5.	Jack Up the Car and Remove the lug Nuts:",
                                      style: _contentStyle),
                                  Text(
                                      "\nUse the jack to lift the vehicle off the ground.\n\nDifferent car models may have various places to put the jack; consult your owner’s manual for specific locations.\n\nOnce the jack is securely in the correct spot, jack up the car until the tire is about six inches off the ground.\n\nRemove the lug nuts and pull the tire off the car.\n\nMake sure to place the lug nuts in a place where they won’t get scattered, and pull the tire straight toward yourself to remove it from the wheelbase.",
                                      style: _contentStyle),
                                  Text("\n6.	Attach the Spare Tire:",
                                      style: _contentStyle),
                                  Text(
                                      "\nPlace the spare in the car.\n\nLine up the lug nut posts with the holes in the spare and push the spare onto the wheelbase until it can’t go any farther.",
                                      style: _contentStyle),
                                  Text("\n7.	Put on the lug nuts.",
                                      style: _contentStyle),
                                  Text(
                                      "\nDo not put them on tightly, just make sure they’re on enough for the spare to stay in the car for a moment.",
                                      style: _contentStyle),
                                  Text("\n8.	Lower the car back to the ground.",
                                      style: _contentStyle),
                                  Text(
                                      "\nUse the jack to bring the car back down to ground level.",
                                      style: _contentStyle),
                                  Text("\n9.	On the Ground:",
                                      style: _contentStyle),
                                  Text(
                                      "\nMake sure the lug nuts are tightened.\n\nWith the car back on the ground, you can now tighten the lug nuts.\n\nRather than tightening them one by one in order, start with one lug nut, tighten it about 50%, move to the opposite nut (across the circle), and tighten that one about the same amount.\n\nKeep tightening opposite lug nuts gradually in turn until each lug nut is as tight as it can be.",
                                      style: _contentStyle),
                                  Text("\n10.	Clean Up", style: _contentStyle),
                                  Text(
                                      "\nPut your flat tire and tools back in your trunk.\n\nMake sure you do not leave anything on the side of the road.\n\nIf you are lucky enough that your tire is not destroyed when it goes flat. If the flat is caused by a nail or other sharp object, and you cannot or don’t want to change your tire you may be able to give yourself a few kilometers of leeway by using a flat-fix type spray. Simply follow the manufacturer’s directions. In ideal situations, the spray foam will allow you to at least find a close off-ramp and pull into a service station or a rest stop before you have to change your tire.\n\nIf your tires appear worn or you have had a flat tire and need it fixed or replaced, contact our service department for a fast and cost-efficient solution.\n\nCall Our Tire Experts at (204) 272-6125 to quickly get you back on the road.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '22.	How Do I Sync Bluetooth with my iPhone?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "The process of synchronizing your car’s Bluetooth with your iPhone varies depending on the vehicle you drive. However, on the phone, it is generally the same.",
                                      style: _contentStyle),
                                  Text("\n1.	Go to the home screen.",
                                      style: _contentStyle),
                                  Text("\n2.	Choose settings.",
                                      style: _contentStyle),
                                  Text("\n3.	General", style: _contentStyle),
                                  Text("\n4.	Bluetooth", style: _contentStyle),
                                  Text(
                                      "\nIf your phone is currently synced to a different system, tap on the system it is connected to disconnect from it, and then choose the system that you want it to be synced to. \n\nTo find out what you need to do specifically to your vehicle you may want to visit the manufacturer’s website, or there are many forums that you can find online.\n\nIf you find you require some assistance with synchronizing your Bluetooth with your iPhone, you can always drop by our dealership and one of our helpful sales representatives or service technicians will be glad to help. \n\nCall Our Tire Experts at (204) 272-6125 to assist you with everything you need!",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '23.	How Do I Change Windshield Wipers?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Replacing your windshield wipers is a quick, relatively easy task. You can find wipers at most automotive retail stores. If you are unsure of what kind to use, see your owner’s manual or ask a representative at the store.",
                                      style: _contentStyle),
                                  Text(
                                      "\nBut what if you know the kind, then what?",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	To start, the old wipers must be removed. To do this, pull the entire wiper away from the windshield and it should hold itself up. (The arm is made of metal. Be sure not to scratch the glass of the windshield!)",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Use one hand to hold the arm, and the other to depress the small tab located on the underside of the wiper where it meets the metal arm.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Slide it off by pulling from the Centre toward the bottom of the arm.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	Once removed, gently place the arm against the windshield. To prevent any damage, make sure that it does not snap itself back.",
                                      style: _contentStyle),
                                  Text(
                                      "\nNow it is time to put the new wipers on…",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	First, line the two pieces up to ensure that it simply clicks on.",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Look at the side of the wiper that attaches to the arm. You will see that it is flat and has a curve across the top. Rotate this clip until the curve is pointing towards the wiper blade.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Hold the wiper upside down next to the arm where they match up and put the arm in between the sides of the wiper.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	Make sure that the open end of the curve is facing the clip and pull the wiper upward so that the rounded edge slides into the hook. Pull it on tightly to click it into place.",
                                      style: _contentStyle),
                                  Text(
                                      "\nRepeat the process on the other side and you’re done!",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you find you require some assistance with changing your windshield wipers, you could always drop by our dealership and one of our helpful sales representatives or service technicians will be glad to help.",
                                      style: _contentStyle),
                                  Text(
                                      "\nCall Our Service Team at (204) 272-6125 to Order and Install New Wipers",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '24.	How Do I Change My Car Battery?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "No car batteries last forever. Things to take note of are your headlights dimming, how old is your battery, does your car need a jump-start; then maybe it’s time for a new battery. You should bring your car to an experienced and trusted mechanic but if you have to do it yourself here are some rules.\n\nChanging a battery is a quick and easy job in most cars and vans and can be done with minimal tools.",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	The most important thing before you begin is to make sure the battery needs to be replaced!",
                                      style: _contentStyle),
                                  Text(
                                      "\nLook for build-up in the form of a whitish or blue residue around the terminal – removing this can sometimes solve issues. Note: do not touch this powder, it can often contain dried sulfuric acid, which will corrode your skin.\n\nVerify that the battery has been given the chance to recharge by driving constantly for 30 minutes (with minimal electrical usage, including not running the air conditioner).\n\nCheck the alternator. Some cars also have a battery meter, and with the engine running, the alternator usually maintains a charge close to 13.8-14.2 volts in a properly functioning charging system. The battery should have 12.4-12.8 volts with the engine off, and with no accessory load.\n\nSchedule to Get Your New Battery Installed Now! Call (204) 272-6125",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	After all of this, should you need a new battery, be sure to buy the correct replacement battery.",
                                      style: _contentStyle),
                                  Text(
                                      "\nWhen you purchase a battery from any authorized retailer, you will have to pay a “core” charge. In most instances, when you bring in your old battery at the time of purchase, you will not get charged this fee. Although, some retailers will refund you the core charge if you bring in your receipt within a specified amount of time.",
                                      style: _contentStyle),
                                  Text("\n3.	Before Removing the Battery:",
                                      style: _contentStyle),
                                  Text(
                                      "\n•	Set up a secure working environment. Park on a flat, level surface at a safe distance from traffic sparks or open flames. Put on the parking brake. Put on gloves and safety goggles.\n\n•	Remove the cigarette lighter and plug the memory keeper into the socket. If you don’t have a memory keeper, make sure you have all the PINs for your electronic equipment before you start. Check your car manual to see what devices might be affected.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	Remove the Old Battery and Install the New One:",
                                      style: _contentStyle),
                                  Text(
                                      "\n•	Locate the battery: The battery should be located in an accessible part on either side of the car’s frame. The battery is a rectangular box with two cables attached to it. In some cars, the battery is under the matting in the trunk, or inside the fender of the wheel well.\n\n•	Identify battery terminals: Locate the positive and the negative terminals. The positive terminal will have a plus sign and the negative terminal will have a minus sign.\n\n•	Disconnect the negative terminal:  Loosen the negative clamp with a wrench and slide it off of the terminal. It is important that you disconnect the negative terminal socket before the positive terminal socket. Otherwise, you may short-circuit the positive terminal to a grounded part of the car.\n\n•	Disconnect the positive terminal.\n\n•	Remove the car battery and put in the new battery.\n\n•	Reconnect the positive and negative terminals.\n\n•	Tighten the clamps using a wrench.\n\n•	Close the hood – Shut the hood of your car firmly and start your car.\n\n•	Check that all the electronic devices are working properly.\n\n•	Remember to properly dispose of the old battery.\n\nIf you are uncomfortable replacing the battery yourself or you are experiencing any other issue with your vehicle, please contact our service department for a fast and cost-efficient solution.\n\nSchedule to Get Your New Battery Installed Now! Call (204) 272-6125.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '25.	Does Your Car Need High Octane Fuel?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Octane gas is available in several different grades, with each number representing the resistance to burning the fuel; the higher the rating, the slower the burn. The most generic form of octane gas is 87-octane. Generally speaking, octane gas increases the cost of fuel, and the higher the grade you purchase the more money you will spend.",
                                      style: _contentStyle),
                                  Text(
                                      "\nYou can determine what type is needed for your vehicle by…",
                                      style: _contentStyle),
                                  Text("\nLooking at the owner’s manual.",
                                      style: _contentStyle),
                                  Text(
                                      "\nChecking the manufacturer’s website. Most find higher-level octane gas to be desirable because they feel that it keeps their car engines running smoother and because they feel it is a cleaner fuel. The truth though is that although it may be cleaner, most engines will notice minimal difference with the higher gas grade.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you have questions or concerns about your vehicle, please contact us or our service department to get answers and fast, cost-efficient solutions.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '26.	How Do I Increase Fuel Efficiency?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Gasoline prices continue to rise and fall. There are many ways that new or used car owners can improve overall fuel economy by as much as 20 percent.",
                                      style: _contentStyle),
                                  Text(
                                      "\nThe first thing that affects fuel economy is how you drive the car!",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	Plan your trips: Try to accomplish multiple things in one trip. You can also try to carpool or walk to your destination. This won’t decrease fuel consumption but will help you drive less, which means less gas.",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Do Not Speed: If you are on the highway driving 100kph instead of 110kph will save you 1-2 kilometers per liter over the duration of your trip. Try using your cruise control, it reduces fuel consumption by maintaining a constant speed.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Throttle Less: Accelerate and brake with ease. You will save on fuel as well as wear and tear on your brakes.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	Do not warm up: Thanks to recent technology most modern cars only really need 30 seconds to get warm.",
                                      style: _contentStyle),
                                  Text(
                                      "\n5.	Windows up: Having the windows down on the highway can decrease fuel economy by up to 10 percent.\n\nThe other major thing that affects fuel economy is the maintenance of your car!",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	Oil: Using only the manufacturer’s specified motor oil, and changing it per factory recommendations, can improve fuel economy as well.",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Weight: The less weight in your vehicle the better fuel economy. An extra forty-five kilograms increases fuel consumption by 1 to 2 percent.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Tires: Make sure your tires are set to recommended pressure at all times this can increase fuel economy by as much as 3.3 percent.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	Filters: A clean air filter and fuel filter will allow the air and fuel to flow unencumbered and can help you save up to 10 percent on fuel costs.",
                                      style: _contentStyle),
                                  Text(
                                      "\n5.	Sensors: The oxygen sensors, engine emissions system, and evaporative emissions control systems if damaged can all decrease fuel mileage by 20 percent or more.",
                                      style: _contentStyle),
                                  Text(
                                      "\n6.	Gas: The owner’s manual will list the correct octane gasoline you should use for your car. Purchasing recommended grade of fuel, premium-grade fuel will not improve the economy in cars designed for regular.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf you take care of your car, it will take care of you. ",
                                      style: _contentStyle),
                                  Text(
                                      "\nIs it time to schedule your vehicle for regular maintenance? Would you like your vehicle checked before making that weekend trip? If so, then please feel free to contact our service department. Our certified technicians will be happy to help.",
                                      style: _contentStyle),
                                  Text(
                                      "\nCall Our Service Team at (204) 272-6125 for your scheduled maintenance.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '27.	How Do I Check the Coolant Level?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Checking the coolant level in your car is a fairly effortless process.\n\nThe first thing to remember is to check the coolant level when the car is cold. In most cars today, there is an opaque coolant overflow tank located next to the radiator. The opaque tank is made of white plastic, which allows you to see the inside and be sure that the coolant is at a safe level.\n\nYou will also find that there are markings on the side to tell you how high or low the level is.\n\nYou should be checking your coolant level a few times per year to make sure that there are no leaks in your system.\n\nIf you find that you are low on coolant you will need to top it off. Engines take a 50/50 mixture of coolant and water, which allows your radiator the optimum boiling or freeze protection that your engine needs. You can generally purchase this pre-mixed.\n\nTo add the coolant, just unscrew the cap of the opaque overflow reservoir and add the mixture until it reaches the full mark.\n\nAfter that, all you need to do is replace the cap, make sure that it is on tight, and you’re ready to roll!\n\nBe sure to change your coolant every couple of years (following the manufacturer’s recommendations).\n\nTime to Replace Your Coolant? Call Our Service Team at (204) 272-6125",
                                      style: _contentStyle),
                                  Text("\nWARNING!!", style: _contentStyle),
                                  Text(
                                      "\nPlease keep in mind that most coolants are toxic and can be fatal to those who come in contact with them.\n\nIf you spill any on the ground you should make sure that you wipe it up.\n\nDo not leave the container lying around!\n\nFollow the recommendations on the container to dispose of it properly.",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	If you find that you are consistently filling your coolant and levels continue to be low, this may mean that you have a leak. This may be a minor fix (such as replacing the radiator hose) or it could be more serious.",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	If you think there may be a leak in your cooling system or if you feel it is time to change your coolant, please feel free to schedule a service appointment. Our service professionals will check to see if a little preventative maintenance can save you from having any significant issues down the road.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '28.	How Do I Check The Transmission Fluid Level?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Checking the transmission fluid in your car is a relatively simple procedure and should be done about once per month. ",
                                      style: _contentStyle),
                                  Text(
                                      "\nTo get the most accurate reading you should check the transmission with the engine running and properly warmed up, on a level service.",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	First, remove the dipstick from under the hood (if you are unsure as to where it is located, check your owner’s manual). The handle is usually a bright color (generally yellow or red).",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Remove the stick, wipe it clean, replace, and then remove it again.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	There are labels for “Warm” and “Cold”- check the warm readings.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	If it is not full, slowly fill the fluid up a little at a time and continue to measure with the dipstick.",
                                      style: _contentStyle),
                                  Text(
                                      "\n5.	To fill the fluid, you should use a funnel and pour it into the hole where you pulled the dipstick. After filling, replace the dipstick, and after a few moments remove it to confirm that it has been done correctly.",
                                      style: _contentStyle),
                                  Text(
                                      "\nGet Your Transmission Flushed Today. Call Our Service Team at (204) 272-6125",
                                      style: _contentStyle),
                                  Text("\nPRO-TIP:", style: _contentStyle),
                                  Text(
                                      "\nWhen checking your transmission fluid be sure to check its color. Transmission fluid is a pinkish/red color. If your fluid is brown that is a sign that there may be something wrong with the car. ",
                                      style: _contentStyle),
                                  Text(
                                      "\nIf this is the case, schedule a service appointment, where our experienced technicians are more than happy to help!",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '29.	Why is my air conditioning not blowing chilly air?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "Several reasons may explain why your air conditioning system is blowing warm instead of cool air.",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	Another reason that your air conditioner may not be blowing cool air is that the compressor has gone bad. The compressor pressurizes the refrigerant and pumps it throughout the AC’s necessary components. Because everything revolves around the compressor, if it is faulty then the air conditioning will not work correctly. Usually, there will be a loud noise when you attempt to turn on your air conditioner if the compressor is broken.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Finally, another problem that may be occurring with your air conditioning system is that there is a clogged orifice tube. This is located between the condenser in the front of the radiator, and the evaporator in the passenger compartment. If there is an obstruction in the tube then it will stop the refrigerant from reaching the evaporator, causing your system to blow warm air.",
                                      style: _contentStyle),
                                  Text(
                                      "\nWhatever the reason your air conditioner is not working, we are more than happy to assist you! Bring your car to our service Centre today and our experienced technicians will assist you in diagnosing and fixing any problem.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('30.	Why is My Engine Idling Rough?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "One thing to keep in mind is that rough idling is not the problem – it is a symptom of an engine issue that has yet to be diagnosed. Your engine could be idling roughly due to several varied reasons.\n\nOne reason for a rough idle is it could be time to clean out the fuel injectors or it could be time to change out the spark plugs.\n\nCall (403) 214-2500 and our team will find your engine issues.\n\nOther reasons for the rough idling include:",
                                      style: _contentStyle),
                                  Text("\n1.	Exhaust problems.",
                                      style: _contentStyle),
                                  Text("\n2.	Holes in the air intake valve.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	A general loss of power in the car.",
                                      style: _contentStyle),
                                  Text(
                                      "\n4.	It may also occur in the winter months when cars have a tough time starting and may shake when the engine is turned over.\n\nTo prevent this problem from happening, you want to regularly schedule tune-ups for your vehicle. During a tune-up, the mechanic reviews several areas within the engine to make sure that everything is working properly.\n\nIf your vehicle has already begun to experience this issue it is recommended that you run a diagnostic check to pinpoint the exact cause of the rough idle. It is recommended that you take your car to a trusted mechanic to review and diagnose the problem. You can also go to an auto parts store and use a code-reading device that they have available and proceed from there with repairs. A rough idle should be addressed right away; the longer this symptom occurs, the more damage could be done to your vehicle, which will ultimately be more expensive to repair.\n\nOf course, you can always bring your car to our service Centre and our experienced technicians will be happy to assist you in diagnosing and fixing any problems.",
                                      style: _contentStyle),
                                  Text("\n", style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('31.	What is Wrong with My Brakes?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "The brakes are one of the most important parts of your vehicle and they go a long way to keep you safe behind the wheel. However, it is often hard to determine whether the noises we hear our brakes making are the result of something simple, like air in the brake line, or if they are a warning sign of imminent brake failure.",
                                      style: _contentStyle),
                                  Text(
                                      "\nRemember, when your service technician recommends any brake repair, it should be completed as soon as possible to avoid danger. Whether you need a simple brake inspection, brake replacement, brake pad replacement, or work on the brake discs, brake pads, or rotors, we can help. Our technicians are trained to work on specific makes and models, and our prices are often lower than you can find at an independent garage.",
                                      style: _contentStyle),
                                  Text(
                                      "\nFor a better idea of what could be causing your brake trouble, read on for answers to common brake questions.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('32.	Why are my brakes pulsing?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "If you experience a pulsing or jerking from the brake, it is far more likely that it was caused by a defect in the brake rotor or drum than by the anti-lock system. A warped rotor or out-of-round drum can cause pronounced pulsating in the brake pedal.\n\nThe failure of the pad to retract is not uncommon. In older drum systems, the brake shoes are pulled back from the drum by strong springs. But in a disk brake system, the pads are pulled back from the rotor (or disc) by the resiliency of rubber seals. As these seals age or are damaged by contaminated brake fluid, they can fail to do their job. The result is that the pad will ride against the rotor and wear out prematurely.\n\nIf your rotor is warped, it can cause the pad to wear out even without a failure of the rubber seal. A warped rotor will wobble as it rotates, thereby scraping the pad as it turns. Eventually, the pad wears out and the metal backing plate will damage the metal rotor.\n\nGet Your Brakes Checked Today. Call Our Service Team at (403) 214-2500",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '33.	Why is the brake pedal sinking to the floor?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "If your brakes are not as responsive as they should be or if the pedal “sinks” toward the floor, this could be an indication of a leak in the braking system. It could be an air leak (in the brake hose) or a brake fluid leak. One telltale sign of a brake fluid leak is the presence of a small puddle of fluid when the car is parked. Brake fluid looks similar to fresh motor oil, but with a less “slimy” texture.\n\nAnother possible problem is the master cylinder. The master cylinder’s cup seals or the cylinder bore itself may be worn. Internal leaking or bypassing cup seals must be considered any time vehicle’s brake pedal is fading to the floor. This fading pedal with no external leak found is a common master cylinder symptom caused by these cup seals. The result will be a loss of hydraulic pressure. The vehicle will creep at stop lights as the brake pedal fades toward the floorboard.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('34.	Why are my brakes grinding?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "This loud metallic sound means that you have worn down the pads completely. The grinding or growling noise is caused by the two pieces of metal (the disc and the caliper) rubbing together. This can “score” or scratch your rotors, creating an uneven surface. If this happens, do not be surprised if your mechanic tells you that the brakes and rotors need to be “turned” (a process that evens out the rotor surface), or even replaced.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('35.	Why are my brakes vibrating?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "A vibration or pulsating brake pedal is often a symptom of warped rotors (but can also indicate that your vehicle is out of alignment). The vibration can feel similar to the feedback in the brake pedal during a panic stop in a vehicle equipped with anti-lock brakes.",
                                      style: _contentStyle),
                                  Text(
                                      "\nIt is a sign of warped rotors if the vibration occurs during braking situations when the anti-lock brakes are not engaged. Warped rotors are caused by severe braking for extended periods, such as when driving down a steep mountain or when towing. Tremendous amounts of friction are created under these conditions, heating the rotors and causing them to warp. The vibration is felt because the brake pads are not able to grab the surface evenly. If you drive in these conditions, make sure to stop periodically to allow your brakes to cool off.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '36.	How much does a brake job cost?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "The cost of repairing your brakes depends largely on what is wrong with your brakes, and which garage you choose to have them repaired at. There are often costs associated with the initial inspection of your brakes, repairing the damaged brake system, and replacing brake parts. If your entire brake system needs to be replaced, this is commonly a more expensive procedure. It is a common myth that a dealership service department is more expensive than a private garage. However, at our service Centre we offer affordable and professional service performed by factory-trained technicians. Contact us today to get started on your brake repair.\n\nGet a Quote for Your Brake Job! Call Us at (403) 214-2500\n\nFor many owners, brake repair and a brake change are something that is often overlooked. But keeping your brakes properly calibrated and in good working order can prevent costly repairs down the line, and more importantly, help you avoid a collision.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text('37.	What is a Powertrain Warranty?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "A warranty is a statement made by either the seller or the manufacturer of a product or service promising that it will perform in a specified manner for a specific period. When shopping for a vehicle you often hear the term “powertrain warranty”. A powertrain warranty is generally a promise to repair or fix an issue with the parts of the powertrain should a malfunction arise based on the agreement signed by the buyer.",
                                      style: _contentStyle),
                                  Text(
                                      "\nThe powertrain of a car consists of multiple components.",
                                      style: _contentStyle),
                                  Text("\n1.	Engine", style: _contentStyle),
                                  Text("\n2.	Transmission",
                                      style: _contentStyle),
                                  Text("\n3.	Driveshaft", style: _contentStyle),
                                  Text(
                                      "\n4.	Any of the internal workings of the engine",
                                      style: _contentStyle),
                                  Text(
                                      "\nSimply put, the powertrain provides power to the car…\n\nPower is created by the engine and then transmitted to the driveshaft through the transmission.\n\nThe sensors that are generally included in a powertrain warranty provide input and output to and from the powertrain control module (PCM).\n\nSome sensors send computer information, which transcribes the information and sends it to output sensors.\n\nThey all work together to make the car run cleanly, smoothly, and efficiently. The power-train warranty is often used as a marketing tool. If a mechanical problem arises within the powertrain and it is covered under the terms of the warranty, either the manufacturer or dealership will have to pay for the repairs to the powertrain. What is covered under the warranty, however, varies greatly between vehicles, manufacturers, and dealerships. When looking to purchase a vehicle you should review this carefully and be sure to understand all of the terms and conditions within the warranty.\n\nIf you believe you may be having powertrain problems, please contact our service Centre and we will be happy to check on your warranty status and get your issues fixed so that you can drive safely and worry-free.\n\nCall Our Team at (403) 214-2500 to Get Your Powertrain Warranty Quote",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Icons.compare_rounded,
                                  color: Colors.white),
                              header: Text(
                                  '38.	What do Extended Warranties Cover?',
                                  style: _headerStyle),
                              headerBackgroundColor: Colors.black38,
                              headerBackgroundColorOpened: Colors.black54,
                              contentBorderColor: Colors.black54,
                              content: Column(
                                children: [
                                  Text(
                                      "An extended warranty is like an insurance policy on your car, it is a safeguard against unforeseen repairs.\n\nAn extended warranty may be purchased at the time you buy your vehicle; it is also possible to purchase one later. If you’re the type who likes to be prepared for all possibilities, an extended auto warranty may be just what you’re looking for. With the ever-increasing cost of vehicle repairs, these can make a lot of sense.\n\nIn deciding whether an extended warranty is right for you, and in selecting the best plan, you’ll need to consider some things.",
                                      style: _contentStyle),
                                  Text(
                                      "\n1.	To what extent is the car already under warranty and do you plan to keep the car past this period?",
                                      style: _contentStyle),
                                  Text(
                                      "\n2.	How reliable is the vehicle make and model? Do your research.",
                                      style: _contentStyle),
                                  Text(
                                      "\n3.	Is the extended warranty from the factory, the dealer, or a third-party provider? While these aftermarket warranties are cheaper, they can be known for shady or dishonest practices.\n\nThere are differences in deductibles – you can pay per visit or repair. Be sure you understand the difference before you buy.\n\nSome extended warranties are transferable should you decide to sell the car before the end of the warranty. Find out the details.\n\nWhat exactly is covered? Does it cover breakdown as well as wear and tear? Under a “breakdown” warranty, coverage is extended only to parts that break. Additionally, some “entry-level” contracts do not cover ABS brakes, so if your vehicle has this feature, you should consider upgrading to this level. And overheating – regardless of its cause – isn’t covered in many warranties. Thus, if overheating occurred due to problems with an expensive part such as your radiator, you would be stuck with a hefty repair bill. Before committing to a warranty, take the time to fully explore the ins and outs of its coverage implications. The distinctions between the various plans might seem slight, but they can prove quite important.\n\nWe may be able to provide you with an extended warranty that meets all of your needs. Please contact us and one of our friendly sales representatives will be happy to answer all of your questions.",
                                      style: _contentStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text("Get answers to all your APP-related questions!",
                      style: _headerStyle),
                  content: Accordion(
                    maxOpenSections: 1,
                    headerBackgroundColorOpened: Colors.black54,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    children: [
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text('1.	How does the IMechano app work?',
                            style: _headerStyle),
                        content: Text(
                          "Users request service from the app, and a certified mobile mechanic or auto technician, nearest to the destination, will arrive onsite.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text('2.	How can I refer IMechano to someone?',
                            style: _headerStyle),
                        content: Text(
                          "The app name is unique, just tell them to download the IMechano app. ",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '3.	What is the detailed mechanism of IMechano?',
                            style: _headerStyle),
                        content: Text(
                          "When you book service appointments with IMechano, you pick a convenient date and time for the car service/repair and specify a preferred location for the work to be performed, which could be your home or work location. We will send a fully qualified mechanic directly to your preferred location and complete the work. It's never been easier to get your car serviced or fixed.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '4.	I am having technical difficulties, and/or need further assistance using the app. Whom do I contact?',
                            style: _headerStyle),
                        content: Text(
                          "Please email us at info@IMechano.com.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text(
                      "IMechano answering your service-related questions quickly!",
                      style: _headerStyle),
                  content: Accordion(
                    maxOpenSections: 1,
                    headerBackgroundColorOpened: Colors.black54,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    children: [
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text('1.	How do I pay for service?',
                            style: _headerStyle),
                        content: Text(
                          "Users add their preferred card or bank information to their accounts during registration or signup. You can pay via bank card, POS, or cash.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "2.	What services are offered by IMechano?",
                            style: _headerStyle),
                        content: Text(
                          "We offer Diagnostic Services i.e., complete checkups, problem diagnosis, quick service, car detailing, general service, technical service, the body works, istemara services, battery services, and check by test drive service.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("3.	Is there a warranty for services?",
                            style: _headerStyle),
                        content: Text(
                          "Yes. All services rendered by IMechano are covered under a 12,000-mileage or 12-month warranty, whichever occurs first. Our limited warranty covers faulty parts or technician errors, via our dispute resolution.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "4.	Are your mechanics certified and what is the vetting process for new mechanics?",
                            style: _headerStyle),
                        content: Text(
                          "We take immense pride in building community and working with the absolute best in the industry. Our mobile mechanics and auto technicians are experienced and go through regulations and training in their field to maintain their job. We also use a third party as the normal protocol to conduct background checks, to further ensure safety, trust, and value are honored at every level of service.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("5.	What vehicles do you work on?",
                            style: _headerStyle),
                        content: Text(
                          "Our mobile mechanics can operate any vehicle with wheels! If you are unsure, please call us at (310) 526-2280, or email us at info@IMechano.com.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "6.	Does IMechano provide services for the aviation or trucking industry, besides auto or vehicle maintenance services?",
                            style: _headerStyle),
                        content: Text(
                          "We may potentially offer services here, feel free to call us at (310) 526-2280 or email us at  info@IMechano.com, to discuss further.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "7.	How old do I have to be to use IMechano services?",
                            style: _headerStyle),
                        content: Text(
                          "Typically, you’d have to be at least 16 years of age. If you have earned your driver’s license, and can fully and legally operate a vehicle, you can use IMechano at your discretion and will. Minors are considered to be people under the age of 18. If you are a parent or guardian of a minor and have other questions regarding IMechano services or client usage, feel free to email us at  info@IMechano.com, for more info.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("8.	How do I pay for my vehicle services?",
                            style: _headerStyle),
                        content: Text(
                          "All payments are handled through Stripe via our App. No payment will be taken out of the customer's account until the completion of services is confirmed.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("9.	How qualified are your mechanics?",
                            style: _headerStyle),
                        content: Text(
                          "Our mechanics are fully qualified and fully trained, are either ASE or MSE certified, and most have a minimum of 3 years of work experience and can service most vehicle makes and models. IMechano instantly identifies your vehicle through our unique databases, using your VIN number.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("10.	How does payment work?",
                            style: _headerStyle),
                        content: Text(
                          "No payment is charged or collected at the time of booking. However, we securely request your payment details at the time of booking to enable us to seamlessly process payment once your car has been serviced or repaired by one of our mechanics.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "11.	How does cancellation of services work?",
                            style: _headerStyle),
                        content: Text(
                          "Customers can cancel already booked appointments within 24 hours of scheduled service. For cancellation of service after the designated timeframe, IMechano can only issue a refund of up to 50% of the total payment. No payment will be taken out of the customer's account until the completion of services is confirmed.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("12.	What vehicles do you service?",
                            style: _headerStyle),
                        content: Text(
                          "All passenger cars, 4WDs, light trucks, RVs, etc. We can service cars irrespective of how they are powered - diesel, petrol, LPG/electric, or hybrid.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("13.	What are your operating hours?",
                            style: _headerStyle),
                        content: Text(
                          "We are running 24x7.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("14.	Do you do home pick-up?",
                            style: _headerStyle),
                        content: Text(
                          "Imechano has got you covered from start to finish - they'll pick up, repair, and drop off",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "15.	I need an enterprise solution. I am a fleet owner, another business party, corporation, dealership, or another auto vendor, who can I contact for more information?",
                            style: _headerStyle),
                        content: Text(
                          "Please email us at  info@IMechano.com, or leave us a message under “Sign Up” via our website at www.IMechano.com. You may also wish to call (310) 526-2280 and leave us a message about your inquiry. We will be in touch shortly!",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text(
                      "Curious about our car repair mechanisms? Take a look at the questions we've answered below!",
                      style: _headerStyle),
                  content: Accordion(
                    maxOpenSections: 1,
                    headerBackgroundColorOpened: Colors.black54,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    children: [
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '1.	Do I need to pick up or drop off my vehicle?',
                            style: _headerStyle),
                        content: Text(
                          "No. IMechano is an end-to-end solution for all of your vehicle maintenance. Our mobile mechanics meet clients at their door. Once service is completed, clients are notified and can drive off",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '2.	What happens if the mechanic discovers extra repair is needed?',
                            style: _headerStyle),
                        content: Text(
                          "The mechanic will have to report the additional repair needed to IMechano. The estimate for the additional repair would be sent to you (the vehicle owner) for approval. Additional work would be solely based upon your prior consent and approval. IMechano will provide all necessary notifications or facilitate all communications for services on our platform.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text('3.	How does a mechanic get parts?',
                            style: _headerStyle),
                        content: Text(
                          "IMechano is currently collaborating with a major retailer so that our mechanics could create a rewards account and purchase discounted parts directly for their work sessions.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text('4.	Can I supply my own parts?',
                            style: _headerStyle),
                        content: Text(
                          "We allow customers to provide their own parts if they wish to. Our warranty does not cover the parts supplied by the customer.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '5.	How can you fix my car in my driveway?',
                            style: _headerStyle),
                        content: Text(
                          "Believe it or not, up to 90% of car services and minor repairs can be done outside of an auto shop, with handheld tools or equipment that can fit into regular-sized vehicles. So, unless you are thinking of getting your entire engine replaced, we should be able to service or fix your car at your preferred location!",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            '6.	What if I do not know what is the issue with my car? Which repair type should I select?',
                            style: _headerStyle),
                        content: Text(
                          "In cases where your vehicle's issues or diagnosis are unknown to you or unavailable, you can choose to book a diagnostic service where you can describe your issue in more detail during the booking process, all in our mobile app. Our mechanics will conduct a thorough diagnostic on your vehicle to identify the issue and will present you with an obligation-free estimate to repair your vehicle once the issue has been identified. If you decide to proceed with the repair, we will arrange for our mechanic to complete the repair for your vehicle.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon:
                      const Icon(Icons.compare_rounded, color: Colors.white),
                  header: Text(
                      "Curious about our car repair mechanisms? Take a look at the questions we've answered below!",
                      style: _headerStyle),
                  content: Accordion(
                    maxOpenSections: 1,
                    headerBackgroundColorOpened: Colors.black54,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    children: [
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("1.	What is your website?",
                            style: _headerStyle),
                        content: Text(
                          "Please visit us at www.IMechano.com ",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text("2.	What is your phone number?",
                            style: _headerStyle),
                        content: Text(
                          "Please call us at (310) 526-2280.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "3.	What are your Terms of Use and Privacy Policy?",
                            style: _headerStyle),
                        content: Text(
                          "Please review these documents in the app.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "4.	How do I sign up to be a mechanic with IMechano?",
                            style: _headerStyle),
                        content: Text(
                          "This service is not available yet, but we will offer it in the future. ",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                      AccordionSection(
                        isOpen: true,
                        leftIcon: const Icon(Icons.compare_rounded,
                            color: Colors.white),
                        headerBackgroundColor: Colors.black38,
                        headerBackgroundColorOpened: Colors.black54,
                        header: Text(
                            "5.	Who do I contact for more information, press, careers, etc.?",
                            style: _headerStyle),
                        content: Text(
                          "Please use the Talk to us option in the app, also you can email us at info@support.com.",
                          style: _contentStyle,
                        ),
                        contentHorizontalPadding: 20,
                        contentBorderColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardone() {
    return Column(
      children: [
        Text(
          getTranslated("faqcard1", context),
          style: _contentStyle,
          textAlign: TextAlign.justify,
        ),
        Text(
          getTranslated("faqcard2", context),
          style: _contentStyle,
          textAlign: TextAlign.justify,
        ),
        Text(
          getTranslated("faqcard3", context),
          style: _contentStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
} //__