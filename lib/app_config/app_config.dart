class AppConfig {
  //baseurl is set here
  static String baseurl = "http://192.168.100.3:8000/";

  //mediaUrl is set here
  static String mediaUrl = "http://192.168.100.3:8000";

  //key to store data from api function in LoginController in json format used in AppUtils to get access key & userid
  static const String loginData = 'logInData';

  static const String noImage =
      'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';

  static const String token = "token";

  static const String loggedIn = 'loggedIn';
}
