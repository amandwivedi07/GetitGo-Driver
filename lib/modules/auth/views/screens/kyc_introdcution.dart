import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getitgodriver/modules/auth/views/screens/verification_initial_view.dart';
import 'package:getitgodriver/shared/constants/font_family.dart';
import 'package:getitgodriver/shared/helper/widgets/buttons.dart';

class KYCIntroductionView extends StatelessWidget {
  const KYCIntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                fontSize: kFont19,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Get.offAll(const VerificationInitialView());
                },
                buttonTitle: 'Next',
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('KYC Introduction View'),
      ),
      body: const Column(children: [
        Text(
          'We Will take your some documents for verification',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
