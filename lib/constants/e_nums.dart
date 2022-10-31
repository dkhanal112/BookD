enum EmailLogIn {
  loggedIn,
  invalidEmail,
  wrongPassword,
  userNotFound,
  userDisabled,
  emailNotVerified,
  tooManyRequests,
  otherError,
  verifyEmailFirst,
  emailSent
}

enum EmailSignUp {
  signedUp,
  weakPassword,
  invalidEmail,
  emailAlreadyInUse,
  otherError,
}

enum ForgotPassword {
  emailSent,
 invalidEmail,
  otherError,
}

enum SocialLogIn {
  loggedIn,
  invalidCreds,
  userDisabled,
  emailAlreadyUsed,
  otherError,
  userNotFound,
  cancelledByUser,
}
