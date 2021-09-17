import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Screens/search_screen.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateTo.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
          body: shopCubit.screens[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            onTap: (index) {
              shopCubit.changeIndex(index);
            },
            items: shopCubit.bottomItems,
          ),
        );
      },
    );
  }
}
