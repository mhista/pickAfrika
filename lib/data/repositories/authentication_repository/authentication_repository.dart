import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pickafrika/features/authentication/screens/login/login.dart';
import 'package:pickafrika/features/authentication/screens/onboarding/onboarding.dart';
import 'package:pickafrika/features/authentication/screens/signup/verify_email.dart';
import 'package:pickafrika/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:pickafrika/utils/exceptions/firebase_exceptions.dart';
import 'package:pickafrika/utils/exceptions/format_eceptions.dart';
import 'package:pickafrika/utils/exceptions/platform_exceptions.dart';

import '../../../navigation_menu.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // VARIABLES
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // CALLED FROM THE main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // FUNCTION TO SHOW REDIRECT SCREEN
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => const VerifyEmailScreen());
      }
    } else {
      if (kDebugMode) {
        print(
            '---------------------------- GET STORAGE AUTH REPO ----------------------------');
        print(deviceStorage.read('isFirstTime'));
      }
      // LOCAL STORAGE
      await deviceStorage.writeIfNull('isFirstTime', true);
      await deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  //  ------------------------------- Email and Password signin --------------------------

  // SIGNIN EMAIL AUTHENTICATION

  // REGISTER EMAIL AUTHENTICATION
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // EMAIL VERIFICATION
  Future<void> verifyUserEmail() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // LOGIN USER
  Future<UserCredential> loginWitheEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // LOGOUT USER
  logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      // deviceStorage.write('remember_me', false);
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
  // REAUTHENTICATION

  //  ---------------------------------- FEDERATED IDENTITY AND SOCIAL SIGN IN---------------

  // GOOGLE AUTHENTICATION
  Future<UserCredential> signInWithGoogle() async {
    try {
      // TRRIGGER THE AUTHENTICATION FLOW
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      // OBTAIN THE AUTH DETAILS FROM THE REQUEST
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      // CREATE A NEW CREDENTIAL
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      // ONCE SIGNED IN GET THE USER CREDENTIALS
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
  // FACEBOOK AUTHENTICATION

  //  ---------------------------------------OTHER VERIFICATION ---------------

  // DELETE USER
}
