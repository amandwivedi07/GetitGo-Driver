import 'package:flutter/material.dart';

import 'package:getitgodriver/shared/constants/color.dart';

class VehicleSelector extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onTap;
  final String imageKey;

  const VehicleSelector({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.imageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kPrimaryColor : Colors.white,
          border: isSelected
              ? Border.all(color: AppColors.kPrimaryColor, width: 1)
              : Border.all(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageKey,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
