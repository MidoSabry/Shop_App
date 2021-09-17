import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Widgets/build_list_product.dart';
import 'package:flutter_ecomerce_app/Widgets/default_text_field.dart';
import 'package:flutter_ecomerce_app/Widgets/myDivider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // defaultTextFailed(
                    //   controller: searchController,
                    //   type: TextInputType.text,
                    //   validatemsg: 'enter text to search',
                    //   onSubmit: (String text) {
                    //     ShopCubit.get(context).search(text);
                    //   },
                    //   label: 'Search',
                    //   prefix: Icons.search,
                    // ),
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String text) {
                        ShopCubit.get(context).search(text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Sarch',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                            ShopCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                              ShopCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
