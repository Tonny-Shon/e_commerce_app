import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/ratings/rating_bar_indicator.dart';
import '../widgets/product_rating.dart';
import 'reviews/user_review_card.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EAppBar(
        title: Text(
          'Revviews & Ratings',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use'),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),

              //overall product ratings
              const EOverallProductRating(),
              const ERatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                '121',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: ESizes.spaceBtnSections,
              ),

              //User reviews list
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
