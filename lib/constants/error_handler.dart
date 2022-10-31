import 'e_nums.dart';

class ErrorHandler {
  static String emailLoginError(EmailLogIn loginStatus) {
   
    switch (loginStatus) {
      case EmailLogIn.emailNotVerified:
        return 'Verification link sent again. Check your inbox.';
      case EmailLogIn.userNotFound:
        return 'User not found. Sign up first.';
      case EmailLogIn.tooManyRequests:
        return 'Too many requests. Wait for a while.';
      case EmailLogIn.userDisabled:
        return 'User is disabled. Contact customer care.';
      case EmailLogIn.wrongPassword:
        return 'You entered a wrong password. Try again.';
      case EmailLogIn.invalidEmail:
        return 'Invalid email.';
      case EmailLogIn.otherError:
        return 'Login failed. Contact customer care.';
      case EmailLogIn.verifyEmailFirst:
        return 'Email should be verified before logging in.';
      default:
        return 'Login failed. Contact customer care.';
    }
  }

  static String emailSignUpError(EmailSignUp loginStatus) {
    switch (loginStatus) {
      case EmailSignUp.invalidEmail:
        return 'Invalid email.';
      case EmailSignUp.emailAlreadyInUse:
        return 'Account with this email already exists.';
      case EmailSignUp.weakPassword:
        return 'Password too weak';
      default:
        return 'Failed to creeate account';
    }
  }

  static String resetPasswordError(EmailSignUp loginStatus) {
    switch (loginStatus) {
      case EmailSignUp.invalidEmail:
        return 'Invalid email.';
      case EmailSignUp.emailAlreadyInUse:
        return 'Account with this email already exists.';
      case EmailSignUp.weakPassword:
        return 'Password too weak';
      default:
        return 'Failed to create account';
    }
  }
    static String socialLogin(SocialLogIn status) {
    switch (status) {
      case SocialLogIn.emailAlreadyUsed:
        return 'This email is already used in another account.';
      case SocialLogIn.cancelledByUser:
        return 'Login Cancelled';
      case SocialLogIn.invalidCreds:
        return 'Invalid Login Credentials';
      case SocialLogIn.userDisabled:
        return 'User is disabled due to illegal activities.';
      case SocialLogIn.userNotFound:
        return 'User not found';
      default:
        return 'Unknown error.';
    }
  }
}