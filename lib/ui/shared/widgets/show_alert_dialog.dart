import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/approve_jobcard_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/car_checkout.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:imechano/ui/styling/text_styles.dart';

class ShowAlertDialog extends StatelessWidget {
  final String jobNo;
  final ValueNotifier<String> _selectedOption = ValueNotifier('Cash');
  ShowAlertDialog({Key? key, required this.jobNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please choose your payment method',
          style:
              TextStyles.regular20Black.copyWith(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _selectedOption,
              builder: (context, value, child) {
                return Column(
                  children: [
                    RadioListTile(
                      title: const Text('Cash'),
                      value: 'Cash',
                      groupValue: _selectedOption.value,
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                    RadioListTile(
                      title: const Text('POS'),
                      value: 'POS',
                      groupValue: _selectedOption.value,
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                    RadioListTile(
                      title: const Text('Online Payment'),
                      value: 'Online Payment',
                      groupValue: _selectedOption.value,
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            log(('Selected payment method: ${_selectedOption.value}'));
            if (_selectedOption.value == 'Online Payment') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CheckOut(choice: 4, jobNo: jobNo)));
            } else {
              bool response = await acceptbookingApiCall(context);
              if (response) {
                currentJobcardTab = 1;
                Get.offAll(() => BottomBarPage(3));
              }
            }
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: logoBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Submit', style: TextStyles.regular16White)),
        ),
      ],
    );
  }

  Future<bool> acceptbookingApiCall(BuildContext context) async {
    Loader().showLoader(context);
    final ApproveJobCardModel? isapprovejobcard =
        await Repository().approveJobCardAPI(jobNo);
    if (isapprovejobcard == null || isapprovejobcard.code != '0') {
      Loader().hideLoader(context);
      snackBar(isapprovejobcard!.message ?? 'Accept Booking', context);
      return true;
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isapprovejobcard.message != null ? isapprovejobcard.message! : '');
      return false;
    }
  }
}
