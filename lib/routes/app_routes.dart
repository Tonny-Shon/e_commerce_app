import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/features/authentication/screens/onBoarding/widgets/onboarding.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/sign_up.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce_app/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/check_out.dart';
import 'package:e_commerce_app/features/shop/screens/home/home_screen.dart';
import 'package:e_commerce_app/features/shop/screens/orders/oders.dart';
import 'package:e_commerce_app/features/shop/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/user_profile.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_reviews.dart';
import 'package:e_commerce_app/features/shop/screens/store/store_screen.dart';
import 'package:e_commerce_app/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppRoutes {
  static final pages = {
    GetPage(name: ERoutes.home, page: () => const HomeScreen()),
    GetPage(name: ERoutes.store, page: () => const StoreScreen()),
    GetPage(name: ERoutes.favorites, page: () => const WishlistScreen()),
    GetPage(name: ERoutes.settings, page: () => const ProfileScreen()),
    GetPage(name: ERoutes.productReviews, page: () => const ProductReviews()),
    GetPage(name: ERoutes.order, page: () => const OrdersScreen()),
    GetPage(name: ERoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: ERoutes.cart, page: () => const CartScreen()),
    GetPage(name: ERoutes.userProfile, page: () => const UserProfileScreen()),
    //GetPage(name: ERoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: ERoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: ERoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: ERoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: ERoutes.forgotPassword, page: () => const ForgotPassword()),
    GetPage(name: ERoutes.onBoarding, page: () => const OnBoardingScreen()),
  };
}
