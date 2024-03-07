import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getitgodriver/modules/auth/views/widgets/phone_field.dart';
import 'package:getitgodriver/shared/constants/color.dart';
import 'package:getitgodriver/shared/constants/dimensions.dart';
import 'package:getitgodriver/shared/helper/widgets/buttons.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/constants/assets.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();
  late String phoneNumber;

  bool isError = false;

  void loginAction() async {
    await controller.verifyPhoneNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Row(
          children: [
            Expanded(
                child: CustomButton(
                    onPressed: () {
                      loginAction();
                      // Get.to(const OtpVerificationView(
                      //   phoneNumber: '7272803133',
                      // ));
                    },
                    buttonTitle: 'Send')),
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.padding32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 10,
                  ),
                  Center(
                    child: Image.asset(
                      Assets.imageLogin,
                      fit: BoxFit.cover,
                      height: 230,
                      // width: 157,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.padding20,
                  ),
                  Text("Let's get Started",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Driver App",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500)),
                  Text('verify your account using OTP',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w300)),
                  const SizedBox(
                    height: Dimensions.padding32,
                  ),

                  // Container(
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           spreadRadius: 0.5,
                  //           blurRadius: 4,
                  //           offset: const Offset(
                  //               0, 4), // changes position of shadow
                  //         ),
                  //       ],
                  //       color: AppColors.whiteColor,
                  //       borderRadius:
                  //           BorderRadius.circular(Dimensions.padding20)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     child: TextFormField(
                  //         // onSaved: (value) => phone = value!,
                  //         // controller: mobnumcontroller,
                  //         keyboardType: TextInputType.phone,
                  //         decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText: 'Enter your mobile number',
                  //             hintStyle: GoogleFonts.poppins(
                  //                 fontSize: 18,
                  //                 color: AppColors.lightGreyColor))),
                  //   ),
                  // ),

                  LoginTextField(
                    inputType: TextInputType.phone,
                    onChanged: (enteredPhone) {
                      final isValid = enteredPhone.isNumericOnly &&
                          enteredPhone.length == 10;
                      setState(() {
                        isError = !isValid;
                      });
                      if (isValid) {
                        phoneNumber = enteredPhone;
                      }
                    },
                    onSaved: (enteredPhone) {
                      setState(() {
                        isError = enteredPhone?.length != 10;
                      });
                      if (enteredPhone?.length == 10) {
                        phoneNumber = enteredPhone!;
                      }
                    },
                    prefix: '+91 | ',
                    hintText: 'Mobile number'.tr,
                    hintTextColor: AppColors.blackColor,
                    radius: 17,
                  ),

                  // if (isError)
                  //   Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'Invalid phone number'.tr,
                  //       style: const TextStyle(color: Colors.red),
                  //     ),
                  //   ),
                  const SizedBox(
                    height: Dimensions.padding24,
                  ),
                  // CustomButton(
                  //   isDisabled: isError,
                  //   onPressed: loginAction,
                  //   buttonTitle: 'Send OTP'.tr,
                  //   borderRadius: 20,
                  //   fontSize: kFont19,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
