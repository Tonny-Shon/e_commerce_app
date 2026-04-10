import 'package:e_commerce_app/common/styles/spacing_styles.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onPressed,
    this.buttonText = ETexts.proceed,
    this.showBackToHome = true,
    this.showContinueShopping = false,
  });

  final String image;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  final String buttonText;
  final bool showBackToHome;
  final bool showContinueShopping;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingwithAppBarHeight,
          child: Column(
            children: [
              // Success Animation/Image
              Container(
                width: EHelperFunctions.screenWidth() * 0.7,
                height: EHelperFunctions.screenWidth() * 0.7,
                padding: const EdgeInsets.all(ESizes.lg),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      EColors.primaryColor.withValues(alpha:0.1),
                      EColors.secondaryColor.withValues(alpha:0.1),
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(ESizes.xl),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: EColors.primaryColor.withValues(alpha:0.08),
                    ),
                    child: _buildImageWidget(context),
                  ),
                ),
              ),
              const SizedBox(height: ESizes.spaceBtnSections * 1.5),

              // Success Title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ESizes.spaceBtnItems),

              // Success Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ESizes.xl),
                child: Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: dark ? Colors.white70 : EColors.darkGrey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtnSections * 2),

              // Success Icon Badge
              Container(
                padding: const EdgeInsets.all(ESizes.md),
                decoration: BoxDecoration(
                  color: EColors.success.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.tick_circle,
                  size: 40,
                  color: EColors.success,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtnSections),

              // Primary Action Button
              if (onPressed != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: ESizes.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ESizes.borderRadiusLg),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          buttonText,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: ESizes.sm),
                        const Icon(Iconsax.arrow_right_3, size: 20, color: Colors.white),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: ESizes.spaceBtnItems),

              // Secondary Actions
              if (showBackToHome || showContinueShopping) ...[
                if (showBackToHome)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.offAll(() => const NavigationMenu()),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: ESizes.lg),
                        side: BorderSide(color: EColors.primaryColor.withValues(alpha:0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ESizes.borderRadiusLg),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.home, size: 20, color: EColors.primaryColor),
                          const SizedBox(width: ESizes.sm),
                          Text(
                            'Back to Home',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: EColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                if (showContinueShopping)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Get.to(() => const NavigationMenu()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.shop, size: 20, color: EColors.primaryColor),
                          const SizedBox(width: ESizes.sm),
                          Text(
                            'Continue Shopping',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: EColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],

              // Decorative Bottom Elements
              const SizedBox(height: ESizes.spaceBtnSections * 2),
              _buildDecorativeElements(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    // Check if image is Lottie animation
    if (image.endsWith('.json')) {
      return Lottie.asset(
        image,
        width: EHelperFunctions.screenWidth() * 0.3,
        height: EHelperFunctions.screenWidth() * 0.3,
        fit: BoxFit.contain,
      );
    }
    
    // Check if image is SVG
    if (image.endsWith('.svg')) {
      // Use flutter_svg if you have the package
      // return SvgPicture.asset(
      //   image,
      //   width: EHelperFunctions.screenWidth() * 0.4,
      //   height: EHelperFunctions.screenWidth() * 0.4,
      // );
      return Image.asset(
        image,
        width: EHelperFunctions.screenWidth() * 0.3,
        height: EHelperFunctions.screenWidth() * 0.3,
      );
    }
    
    // Regular image
    return Image.asset(
      image,
      width: EHelperFunctions.screenWidth() * 0.3,
      height: EHelperFunctions.screenWidth() * 0.3,
    );
  }

  Widget _buildDecorativeElements(BuildContext context) {
    return Column(
      children: [
        // Decorative Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: EColors.primaryColor.withValues(alpha:0.3),
              ),
            ),
          ),
        ),
        const SizedBox(height: ESizes.spaceBtnItems),
        
        // Thank You Message
        Container(
          padding: const EdgeInsets.all(ESizes.md),
          decoration: BoxDecoration(
            color: EColors.primaryColor.withValues(alpha:0.05),
            borderRadius: BorderRadius.circular(ESizes.borderRadiusLg),
            border: Border.all(color: EColors.primaryColor.withValues(alpha:0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.heart,
                size: 16,
                color: EColors.primaryColor,
              ),
              const SizedBox(width: ESizes.sm),
              Text(
                'Thank you for choosing us!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: EColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}