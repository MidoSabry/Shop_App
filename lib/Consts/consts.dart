import 'package:flutter_ecomerce_app/Screens/login_screen.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateAndFinish.dart';
import 'package:flutter_ecomerce_app/shared/cache_helper.dart';

const LOGIN = 'login';
const HOME = 'home';
const GET_CATEGORIES = 'categories';
const FAVORITES = 'favorites';
const PROFILE = 'profile';
const REGISTER = 'register';
const UPDATE_PROFILE = 'update-profile';
const SEARCH = 'products/search';
String token = '';
void printFullText(String? text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

void signOut(context) {
  CasheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}
