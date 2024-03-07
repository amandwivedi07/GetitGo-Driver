import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getitgodriver/modules/auth/controllers/auth_controller.dart';
import 'package:getitgodriver/modules/auth/views/screens/kyc_introdcution.dart';
import 'package:getitgodriver/modules/auth/views/widgets/vehicle_selector_widget.dart';
import 'package:getitgodriver/modules/home/view/home_view.dart';
import 'package:getitgodriver/shared/constants/color.dart';
import 'package:getitgodriver/shared/constants/constant.dart';
import 'package:getitgodriver/shared/constants/dimensions.dart';
import 'package:getitgodriver/shared/constants/font_family.dart';
import 'package:getitgodriver/shared/helper/utils/helper.dart';
import 'package:getitgodriver/shared/helper/widgets/buttons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authcontroller = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formfieldKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;
  final UploadHelper uploadHelper = UploadHelper();

  Future<String?> uploadSingleImage(XFile rawFile) async {
    Helper.showLoading('Uploading image');
    try {
      final String? uploadedImage =
          await uploadHelper.uploadFile(rawFile, quality: 40);
      if (uploadedImage != null) {
        Helper.hideLoading();
        return uploadedImage;
      }
      return null;
    } catch (e) {
      // Handle any exceptions that may occur during the upload process.
      print("Error uploading image: $e");
      log(e.toString());
      return null;
    }
  }

  String vehicleType = '';
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
                  Get.offAll(const KYCIntroductionView());
                  // registerAction();
                },

                //  loginAction,
                buttonTitle: 'Next',
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: Dimensions.pagePadding,
            child: SingleChildScrollView(
              child: Form(
                key: _formfieldKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Create Account'.tr,
                          textAlign: TextAlign.center,
                          style: kManropeBold.copyWith(
                            color: AppColors.blackColor,
                            fontSize: kFont17,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            final cameraImage = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                            setState(() {
                              pickedFile = cameraImage;
                            });
                          } catch (e) {
                            print("Error picking image: $e");
                            // Handle the error gracefully, e.g., display an error message to the user.
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: pickedFile == null
                              ? const Icon(
                                  Icons.camera_alt_sharp,
                                  color: Colors.white,
                                  size: 50,
                                )
                              : Image.file(
                                  File(pickedFile!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Enter your name',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 120),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: GoogleFonts.poppins()),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter your email',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 120),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: GoogleFonts.poppins()),
                        )),
                    const SizedBox(height: Dimensions.padding16),
                    const SizedBox(height: Dimensions.padding16),
                    const Text(
                      'Choose Vehicle Type',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: Dimensions.padding16),
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        children: vehicleSelector
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child: VehicleSelector(
                                    imageKey: e['img']!,
                                    isSelected: vehicleType == e['key'],
                                    label: e['label']!,
                                    onTap: () {
                                      setState(() {
                                        vehicleType = e['key']!;
                                      });
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: Dimensions.padding16),
                    const SizedBox(height: Dimensions.padding12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerAction() async {
    String? imageUrl = await uploadSingleImage(pickedFile!);
    log(imageUrl.toString());
    if (_nameController.text.isNotEmpty && imageUrl != null) {
      try {
        final body = {
          "name": _nameController.value.text,
          "email": _emailController.value.text,
          "profile_pic": imageUrl,
          "address": authcontroller.address,
          "vehicle_type": vehicleType,
          "coordinates": [
            authcontroller.userCurrentLongitude,
            authcontroller.userCurrentLatitude,
          ]
        };
        await authcontroller.registerUser(body);
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
