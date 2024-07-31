// import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
// import 'package:e_commerce_app/utils/constants/sizes.dart';
// import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../../common/common_shapes/containers/circular_container.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../models/address_model.dart';

// class ESingleAddress extends StatelessWidget {
//   const ESingleAddress({super.key, required this.address, required this.onTap});

//   final AddressModel address;
//   final VoidCallback onTap;
//   @override
//   Widget build(BuildContext context) {
//     final controller = AddressController.instance;
//     final dark = EHelperFunctions.isDarkMode(context);
//     return Obx(() {
//       final selectedAddressId = controller.selectedAddress.value.id;
//       final selectedAddress = selectedAddressId == address.id;
//       return InkWell(
//         onTap: onTap,
//         child: ERoundedContainer(
//           width: double.infinity,
//           padding: const EdgeInsets.all(ESizes.md),
//           showBorder: true,
//           backgroundColor: selectedAddress
//               ? EColors.primaryColor.withOpacity(0.5)
//               : Colors.transparent,
//           borderColor: selectedAddress
//               ? Colors.transparent
//               : dark
//                   ? EColors.darkerGrey
//                   : EColors.grey,
//           margin: const EdgeInsets.only(bottom: ESizes.spaceBtnItems),
//           child: Stack(
//             children: [
//               Positioned(
//                 right: 10,
//                 top: 0,
//                 child: Icon(
//                   selectedAddress ? Iconsax.tick_circle5 : null,
//                   color: selectedAddress
//                       ? dark
//                           ? EColors.light
//                           : EColors.black
//                       : null,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Text(
//                   //   '02383, Timmy Coves, South Liana, Maine, 89374, USA',
//                   //   maxLines: 1,
//                   //   overflow: TextOverflow.ellipsis,
//                   //   style: Theme.of(context).textTheme.titleLarge,
//                   // ),
//                   Text(
//                     address.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(
//                     height: ESizes.sm / 2,
//                   ),
//                   Text(
//                     address.phoneNumber,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(
//                     height: ESizes.sm / 2,
//                   ),
//                   Text(
//                     address.toString(), //maxLines: 1,
//                     softWrap: true,
//                     // overflow: TextOverflow.ellipsis,
//                     // style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
