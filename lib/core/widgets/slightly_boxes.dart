import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petapp/core/theme/colors.dart';

class SlightlyBorderBoxes extends StatelessWidget {
  const SlightlyBorderBoxes({super.key, required this.category, required this.data});
  final String category;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 100.w, // Minimum width
        maxWidth: double.infinity, // Allows it to expand if needed
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: lightgrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
