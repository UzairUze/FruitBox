import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  ///provide here all languages
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'email_hint': 'Email',
          'internet_exception':
              "We're unable to show results. \nplease check you data\nconnection.",
          'general_exception':
              "An error has occurred. \nPlease try again later",
          'splash_title': "Welcome\nBack",
          'login': 'Welcome back',
          'password_hint': 'Password',
        },
        'ur_PK': {'email_hint': 'ای میل درج کریں'},
      };
}
