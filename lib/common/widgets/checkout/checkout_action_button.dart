import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CheckoutActionButton extends StatelessWidget {
  const CheckoutActionButton({super.key, required this.onPressed, required this.label});
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: ESizes.lg, vertical: ESizes.md),
        backgroundColor: EColors.primaryColor,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius:
         BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
