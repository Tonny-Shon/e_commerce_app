// import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
// import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
// import 'package:e_commerce_app/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EBillingAddressSection extends StatelessWidget {
//   const EBillingAddressSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final addressController = Get.put(AddressController());
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ESectionHeading(
//           title: 'Shipping Address',
//           buttonTitle: 'Change',
//           onPressed: () => addressController.selectNewAddressPopup(context),
//         ),
//         addressController.selectedAddress.value.id.isNotEmpty
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Shontian',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   const SizedBox(
//                     width: ESizes.spaceBtnItems / 2,
//                   ),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.phone,
//                         color: Colors.grey,
//                         size: 16,
//                       ),
//                       const SizedBox(
//                         width: ESizes.spaceBtnItems,
//                       ),
//                       Text(
//                         '+256 756 505146',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: ESizes.spaceBtnItems / 2,
//                   ),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_history,
//                         color: Colors.grey,
//                         size: 16,
//                       ),
//                       const SizedBox(
//                         width: ESizes.spaceBtnItems,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Bugembe',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                           softWrap: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : Text(
//                 'Select Address',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//       ],
//     );
//   }
// }
