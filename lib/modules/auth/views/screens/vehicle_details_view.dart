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

class VehicleDetailView extends StatefulWidget {
  const VehicleDetailView({super.key});

  @override
  State<VehicleDetailView> createState() => _VehicleDetailViewState();
}

class _VehicleDetailViewState extends State<VehicleDetailView> {
  final AuthController authcontroller = Get.find();

  XFile? _vehicleFront;
  XFile? _vehicleBack;
  XFile? _rc;
  XFile? _insurance;
  XFile? _cpp;

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
        title: const Text('Upload Vehicle Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Upload Vehicle',
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
                        hasImage: _vehicleFront != null ? true : false,
                        imagePath:
                            _vehicleFront == null ? '' : _vehicleFront!.path,
                        onImagePicked: (XFile imagePath) {
                          setState(() {
                            _vehicleFront = imagePath;
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
                        hasImage: _vehicleBack != null ? true : false,
                        imagePath:
                            _vehicleBack == null ? '' : _vehicleBack!.path,
                        onImagePicked: (imagePath) {
                          setState(() {
                            _vehicleBack = imagePath;
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
              height: 20,
            ),
            const Text(
              'Upload RC',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomImageContainer(
                width: Get.width * 0.46,
                height: Get.height * 0.18,
                hasImage: _rc != null ? true : false,
                imagePath: _rc == null ? '' : _rc!.path,
                onImagePicked: (XFile imagePath) {
                  setState(() {
                    _rc = imagePath;
                  });
                  print('Image Path: $imagePath');
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Upload Insurance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomImageContainer(
                width: Get.width * 0.46,
                height: Get.height * 0.18,
                hasImage: _insurance != null ? true : false,
                imagePath: _insurance == null ? '' : _insurance!.path,
                onImagePicked: (XFile imagePath) {
                  setState(() {
                    _insurance = imagePath;
                  });
                  print('Image Path: $imagePath');
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Upload CPP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomImageContainer(
                width: Get.width * 0.46,
                height: Get.height * 0.18,
                hasImage: _cpp != null ? true : false,
                imagePath: _cpp == null ? '' : _cpp!.path,
                onImagePicked: (XFile imagePath) {
                  setState(() {
                    _cpp = imagePath;
                  });
                  print('Image Path: $imagePath');
                },
              ),
            ),
            const SizedBox(
              height: 100,
            )
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
  //   XFile? _vehicleFront;
  // XFile? _vehicleBack;
  // XFile? _rc;
  // XFile? _insurance;
  // XFile? _cpp;

  void submitPersonalDetail() async {
    String? vehicleFront = await uploadSingleImage(_vehicleFront!);
    String? vehicleBack = await uploadSingleImage(_vehicleBack!);
    String? rc = await uploadSingleImage(_rc!);
    String? insurance = await uploadSingleImage(_insurance!);
    String? cpp = await uploadSingleImage(_cpp!);

    if (vehicleFront!.isNotEmpty &&
        vehicleBack!.isNotEmpty &&
        rc!.isNotEmpty &&
        insurance!.isNotEmpty &&
        cpp!.isNotEmpty) {
      try {
        final registrationData = VehicleDetail(
          rc: {
            'value': rc,
            'status': 'created',
            'number': 'string',
          },
          insurance: {
            'value': insurance,
            'status': 'created',
            'number': 'string',
          },
          ccp: {
            'value': cpp,
            'status': 'created',
            'number': 'string',
          },
          vehicleFront: {
            'value': vehicleFront,
            'status': 'created',
            'number': 'string',
          },
          vehicleBack: {
            'value': vehicleBack,
            'status': 'created',
            'number': 'string',
          },
        );

        await authcontroller.vehicleDetail(registrationData);
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
