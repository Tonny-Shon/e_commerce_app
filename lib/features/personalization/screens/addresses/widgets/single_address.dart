import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/colors.dart';

class ESingleAddress extends StatelessWidget {
  const ESingleAddress({super.key, required this.selectedAddress});
  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return ERoundedContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(ESizes.md),
      showBorder: true,
      backgroundColor: selectedAddress
          ? EColors.primaryColor.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? EColors.darkerGrey
              : EColors.grey,
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtnItems),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                      ? EColors.light
                      : EColors.black
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   '02383, Timmy Coves, South Liana, Maine, 89374, USA',
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Text(
                'John Doe',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: ESizes.sm / 2,
              ),
              const Text(
                '(+123) 245 7383',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: ESizes.sm / 2,
              ),
              const Text(
                '02383, Timmy Coves, South Liana, Maine, 89374, USA',
                //maxLines: 1,
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
                // style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
