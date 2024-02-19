import 'validation_string.dart';

String emailValidationMsg(String email) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (email.isEmpty) {
    return errorRequiredEmail;
  } else if (regex.hasMatch(email)) {
    return errorValid;
  } else {
    return errorValidEmail;
  }
}
String aadharCardValidationMsg(String aadharCard) {
  String pattern =
      r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$';
  RegExp regex = RegExp(pattern);
  if (aadharCard.isEmpty) {
    return errorValidAadharCard;
  } else if (regex.hasMatch(aadharCard)) {
    return errorValid;
  } else {
    return errorValidRequiredAadharCard;
  }
}


String passwordValidationMsg(String password) {
  if (password.isEmpty || password == "") {
    return errorRequiredPassword;
  } else if (password.length < 6) {
    return errorMinimum6Character;
  } else {
    return "";
  }
}

String mobileValidationMsg(String mobile) {
  if (mobile.isEmpty || mobile == "") {
    return errorRequiredMobileNumber;
  } else if (mobile.length < 10 || mobile.length > 10) {
    return errorValidMobileNumber;
  } else {
    return "";
  }
}

String nameValidationMsg(String name) =>
    name.isEmpty || name == "" ? errorRequiredName : "";

String ageValidationMsg(String age) =>
    age.isEmpty || age == "" ? errorRequiredAge : "";

String dobValidationMsg(String dob) =>
    dob.isEmpty || dob == "" ? errorRequiredDob : "";

String addressValidationMsg(String address) =>
    address.isEmpty || address == "" ? errorValidAddress : "";
String nationalityValidationMsg(String nationality) =>
    nationality.isEmpty || nationality == "" ? errorValidNationality : "";
