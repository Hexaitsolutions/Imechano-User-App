import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/screens/on_boarding/model/on_boarding_info.dart';

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo(
      'assets/svg/Say.svg',
      getTranslated('SayGoodbyeToYourCarTroubles', Get.context!),
      getTranslated('LoremIpsumissimplydummytextoftheprintingandtypesetting',
          Get.context!),
    ),
    OnBoardingInfo(
      'assets/svg/Provider.svg',
      getTranslated('ProvideyouButterExpertforyourCar', Get.context!),
      getTranslated('LoremIpsumissimplydummytextoftheprintingandtypesetting',
          Get.context!),
    ),
    OnBoardingInfo(
      'assets/svg/Relax.svg',
      getTranslated('Relaxuntilyourcarisdone', Get.context!),
      getTranslated('LoremIpsumissimplydummytextoftheprintingandtypesetting',
          Get.context!),
    ),
  ];
}
