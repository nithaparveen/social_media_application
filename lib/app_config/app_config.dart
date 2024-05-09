class AppConfig {
  //baseurl is set here
  static String baseurl = "http://10.11.0.98:8000/";

  //mediaUrl is set here
  static String mediaUrl = "http://10.11.0.98:8000";

  // //key to store data from api function in LoginController in json format used in AppUtils to get access key & userid
  static const String loginData = 'logInData';

  static const String noImage = 'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';
  // //key to store data from api function in LoginController in json format used in AppUtils to get user details only
  // static const String userData = 'userdata';
  //
  // //key to store username which user entered used in registration page controller, login page controller
  // static const String userName = "username";
  //
  // //key to check whether the user is already registered  or not and navigate to login page on every other startup since registering.
  // static const String status = "status";
  //
  static const String token = "token";
  static const String loggedIn = 'loggedIn';

}
