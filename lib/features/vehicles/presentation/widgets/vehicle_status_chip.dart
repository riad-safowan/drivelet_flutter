import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class VehicleStatusChip extends StatelessWidget {
  final String status;

  const VehicleStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isAvailable = status == "available";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAvailable ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: isAvailable ? Colors.green.shade700 : Colors.red.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
