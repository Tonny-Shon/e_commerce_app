import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/controller/signup/exceptions.dart';
import '../../../features/shop/screens/splash_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Make current user reactive
  final Rx<User?> _currentUser = Rx<User?>(null);

  //get authenticated user data
  User? get authUser => _currentUser.value;
  Rx<User?> get cu => _currentUser;

  @override
  onInit() {
    super.onInit();
    _currentUser.bindStream(_auth.authStateChanges());
  }

  bool get isAnonymous => authUser?.isAnonymous ?? true;
  bool get isLoggedIn => authUser != null && !isAnonymous;

  //called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  Future<void> signInAnonymously() async{
    try{
      final userCredential = await _auth.signInAnonymously();
      await ELocalStorage.init(userCredential.user!.uid);
      await screenRedirect();
    }on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

//function to the relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {

      await GetStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      // if (user.emailVerified) {
      //   //Initialize User specific storage
        
      // } else {
      //   Get.offAll(() => const VerifyEmailScreen(
      //         // email: _auth.currentUser!.email,
      //       ));
      // }
    } else {
      //local storage
      deviceStorage.writeIfNull("IsFirstTime", true);
      // Show app navigation for unauthenticated users; require login only when placing orders
      Get.offAll(() => const SplashScreen());
    }
  }

  ///EmailAuthentication Signin
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error.');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: '').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///EmailAuthentication Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(code: e.code, message: '');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: '').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///user authenticate
  ///forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///
  ///
  ///google authentication
  Future<UserCredential?> signinWithGoogle() async {
    try {
      //trigger the authentication flow

      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //once signed in, return the userCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///facebook authentication
  ///
  ///
  ///logout user
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const NavigationMenu());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

// Re Authenticate user
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }

  ///delete user
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(
          code: e.code, message: 'Authentication error');
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: e.code, message: 'Database error').message;
    } on FormatException catch (_) {
      throw EFormatException();
    } on PlatformException catch (_) {
      throw EPlatformException('An error occured!.');
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }


}
