//@dart2.0

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Screens/login_screen.dart';
import 'package:flutter_ecomerce_app/shared/cache_helper.dart';

import 'Bloc/bloc_observer.dart';
import 'Consts/consts.dart';
import 'Layout/shop_layout.dart';
import 'Screens/page_view_screen.dart';
import 'Services/services.dart';
import 'Styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CasheHelper.init();
  Widget widget;
  bool onBoarding =
      CasheHelper.getData(key: 'onBoarding') == null ? false : true;
  String token = CasheHelper.getData(key: 'token') == null ? 'false' : 'true';
  token = CasheHelper.getData(key: 'token');

  print(onBoarding);
  print("token is : " + token);

  if (onBoarding != false) {
    if (token != 'false')
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = PageViewScreen();
  }

  // bool onBoarding = CasheHelper.getData(key: 'onBoarding');
  // token = CasheHelper.getData(key: 'token');
  // print(token);

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = LoginScreen();
  // } else {
  //   widget = PageViewScreen();
  // }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget? startWidget;

  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
