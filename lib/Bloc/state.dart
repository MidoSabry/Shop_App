import 'package:flutter_ecomerce_app/Models/change_favorites_model.dart';
import 'package:flutter_ecomerce_app/Models/login_model.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class ShopLoginLoadingState extends AppStates {}

class ShopLoginSuccessState extends AppStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends AppStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class ShopLoadingHomeDataState extends AppStates {}

class ShopSuccessHomeDataState extends AppStates {}

class ShopErrorHomeDataState extends AppStates {}

class ShopSuccessCategoriesState extends AppStates {}

class ShopErrorCategoriesState extends AppStates {}

class ShopChangeFavoritesState extends AppStates {}

class ShopSuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends AppStates {}

class ShopLoadingGetFavoritesState extends AppStates {}

class ShopSuccessGetFavoritesState extends AppStates {}

class ShopErrorGetFavoritesState extends AppStates {}

class ShopLoadingUserDataState extends AppStates {}

class ShopSuccessUserDataState extends AppStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends AppStates {}

class ShopLoadingUpdateUserState extends AppStates {}

class ShopSuccessUpdateUserState extends AppStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends AppStates {}

class ShopRegisterInitialState extends AppStates {}

class ShopRegisterLoadingState extends AppStates {}

class ShopRegisterSuccessState extends AppStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends AppStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends AppStates {}

class SearchInitialState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}
