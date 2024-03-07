import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class MyKYCDecorationContainer extends StatelessWidget {
  final String headingText;
  const MyKYCDecorationContainer({
    Key? key,
    required this.headingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // height: 100,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffDADADA), // Set the shadow color to DADADA
            blurRadius: 10, // Adjust the blur radius as needed
            offset: Offset(0, 5), // Adjust the shadow offset as needed (X, Y)
          ),
        ],
      ),
      child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headingText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Upload Now',
              style: TextStyle(
                  color: Color(0xff1A7FC1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ]),
    );
  }
}
