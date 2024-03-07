import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getitgodriver/modules/auth/controllers/auth_controller.dart';
import 'package:getitgodriver/modules/auth/models/user.dart';
import 'package:getitgodriver/modules/auth/views/screens/kyc_introdcution.dart';
import 'package:getitgodriver/modules/auth/views/widgets/my_image_container.dart';
import 'package:getitgodriver/shared/constants/font_family.dart';
import 'package:getitgodriver/shared/helper/utils/helper.dart';
import 'package:getitgodriver/shared/helper/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/constants/constant.dart';

class BankDetailView extends StatefulWidget {
  const BankDetailView({super.key});

  @override
  State<BankDetailView> createState() => _BankDetailViewState();
}

class _BankDetailViewState extends State<BankDetailView> {
  final AuthController authcontroller = Get.find();

  XFile? _passbook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                fontSize: kFont19,
                fontWeight: FontWeight.w600,
                onPressed: () async {
                  submitPersonalDetail();
                },

                //  loginAction,
                buttonTitle: 'Next',
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Bank Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Upload Bank Passbook',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomImageContainer(
                width: Get.width * 0.46,
                height: Get.height * 0.18,
                hasImage: _passbook != null ? true : false,
                imagePath: _passbook == null ? '' : _passbook!.path,
                onImagePicked: (XFile imagePath) {
                  setState(() {
                    _passbook = imagePath;
                  });
                  print('Image Path: ${imagePath.path}');
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  final UploadHelper uploadHelper = UploadHelper();
  Future<String?> uploadSingleImage(XFile rawFile) async {
    Helper.showLoading('Uploading image');
    try {
      final String? uploadedImage =
          await uploadHelper.uploadFile(rawFile, quality: 50);
      return uploadedImage;
      // if (uploadedImage != null) {
      //   Helper.hideLoading();
      //   return uploadedImage;
      // }
      // return null;
    } catch (e) {
      // Handle any exceptions that may occur during the upload process.
      print("Error uploading image: $e");
      log(e.toString());
      return null;
    }
  }

  void submitPersonalDetail() async {
    String? passbook = await uploadSingleImage(_passbook!);

    if (passbook!.isNotEmpty) {
      try {
        final registrationData = BankDetail(
          passBook: {
            'value': passbook,
            'status': 'created',
            'number': 'string',
          },
        );

        await authcontroller.bankDetail(registrationData);
        Get.offAll(const KYCIntroductionView());
      } on Exception catch (e) {
        e.printError();
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Mandatory",
        message: 'Please fill all details',
      ));
    }
  }
}
