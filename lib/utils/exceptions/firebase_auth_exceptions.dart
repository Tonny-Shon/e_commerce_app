// class EFirebaseAuthException implements Exception {
//   //error code associated with the exception

//   final String code;

// //constructor
//   EFirebaseAuthException(this.code);

//   //Get the corresponding error message based on the error code
//   String get message {
//     switch (code) {
//       case 'email-already-in-use':
//         return 'The email address is already registered. Please use a different email.';

//       case 'invalid-email':
//         return 'Invalid email address. Please enter a valid email.';

//       case 'weak-password':
//         return 'Weak password. Please choose a stronger password';

//       case 'user-disabled':
//         return 'User account has been disabled. Please contact support for assistance';

//       case 'user-not-found':
//         return 'Invalid credentials. User not found.';

//       case 'wrong-password':
//         return 'Incorrect password. Please check your password and try again';

//       case 'invalid-verification-code':
//         return 'Invalid verification code. Please enter a valid code';

//       case 'invalid-verification-id':
//         return 'Invalid verification ID. Please request a new verification code';

//       case 'quota-exceeded':
//         return 'Quota exceeded. Please try again later';

//       case 'email-already-exists':
//         return 'Email already exists. Please use a different email';

//       case 'provider-already-linked':
//         return 'The account is already linked to another provider.';
//     }
//   }
// }
