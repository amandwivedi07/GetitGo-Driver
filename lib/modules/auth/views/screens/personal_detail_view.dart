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

class PersonalDetailView extends StatefulWidget {
  const PersonalDetailView({super.key});

  @override
  State<PersonalDetailView> createState() => _PersonalDetailViewState();
}

class _PersonalDetailViewState extends State<PersonalDetailView> {
  final AuthController authcontroller = Get.find();

  XFile? _addharFront;
  XFile? _addharBack;
  XFile? _dlPhoto;
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
                  // Get.offAll(const KYCIntroductionView());
                  // String? aadharfrontUrl =
                  //     await uploadSingleImage(_addharFront!);
                  // log(aadharfrontUrl.toString());

                  // String? aadharBackUrl = await uploadSingleImage(_addharBack!);
                  // String? dlPhotoUrl = await uploadSingleImage(_dlPhoto!);
                  // log(aadharBackUrl.toString());
                  // log(dlPhotoUrl.toString());
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
        title: const Text('Personal Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Upload Aadhar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Front',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CustomImageContainer(
                        width: Get.width * 0.46,
                        height: Get.height * 0.18,
                        hasImage: _addharFront != null ? true : false,
                        imagePath:
                            _addharFront == null ? '' : _addharFront!.path,
                        onImagePicked: (XFile imagePath) {
                          setState(() {
                            _addharFront = imagePath;
                          });
                          print('Image Path: ${imagePath.path}');
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Back',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CustomImageContainer(
                        width: Get.width * 0.46,
                        height: Get.height * 0.18,
                        hasImage: _addharBack != null ? true : false,
                        imagePath: _addharBack == null ? '' : _addharBack!.path,
                        onImagePicked: (imagePath) {
                          setState(() {
                            _addharBack = imagePath;
                          });
                          print('Image Path: $imagePath');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Upload DL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomImageContainer(
                width: Get.width * 0.46,
                height: Get.height * 0.18,
                hasImage: _dlPhoto != null ? true : false,
                imagePath: _dlPhoto == null ? '' : _dlPhoto!.path,
                onImagePicked: (XFile imagePath) {
                  setState(() {
                    _dlPhoto = imagePath;
                  });
                  print('Image Path: $imagePath');
                },
              ),
            ),
            const SizedBox(
              height: 100,
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

      // return null;
    } catch (e) {
      print("Error uploading image: $e");
      log(e.toString());
      return null;
    }
  }

  void submitPersonalDetail() async {
    String? aadharfrontUrl = await uploadSingleImage(_addharFront!);
    log(aadharfrontUrl.toString());
    String? aadharBackUrl = await uploadSingleImage(_addharBack!);
    String? dlPhotoUrl = await uploadSingleImage(_dlPhoto!);
    log(aadharBackUrl.toString());
    log(dlPhotoUrl.toString());
    if (aadharfrontUrl!.isNotEmpty &&
        aadharBackUrl!.isNotEmpty &&
        dlPhotoUrl!.isNotEmpty) {
      try {
        final registrationData = PersonalDetail(
          aadharFront: {
            'value': aadharfrontUrl,
            'status': 'created',
            'number': 'string',
          },
          aadharBack: {
            'value': aadharBackUrl,
            'status': 'created',
            'number': 'string',
          },
          drivingLicence: {
            'value': dlPhotoUrl,
            'status': 'created',
            'number': 'string',
          },
        );

        await authcontroller.personalDetail(registrationData);
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
