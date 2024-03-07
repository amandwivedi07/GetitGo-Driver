import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitgodriver/modules/auth/views/screens/bank_detail_view.dart';
import 'package:getitgodriver/modules/auth/views/screens/personal_detail_view.dart';
import 'package:getitgodriver/modules/auth/views/screens/vehicle_details_view.dart';
import 'package:getitgodriver/modules/auth/views/widgets/kyc_decoration_container.dart';

class VerificationInitialView extends StatelessWidget {
  const VerificationInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Column(children: [
        Container(
          // height: 50,
          width: Get.width,
          decoration: BoxDecoration(
            color: const Color(0xffDADADA),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            border: const Border(
              bottom: BorderSide(
                color: Color.fromARGB(
                    255, 139, 127, 127), // Set the color for the bottom border
                width: 2,
              ),
            ),
          ),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please complete all the steps to activate your account",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(const PersonalDetailView());
                },
                child: const MyKYCDecorationContainer(
                  headingText: 'Personal Detail',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const VehicleDetailView());
                },
                child: const MyKYCDecorationContainer(
                  headingText: 'Vehicle Detail',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const BankDetailView());
                },
                child: const MyKYCDecorationContainer(
                  headingText: 'Bank Detail',
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
