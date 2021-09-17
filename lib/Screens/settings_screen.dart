import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Consts/consts.dart';
import 'package:flutter_ecomerce_app/Styles/colors.dart';
import 'package:flutter_ecomerce_app/Widgets/default_button.dart';
import 'package:flutter_ecomerce_app/Widgets/default_text_field.dart';

class SettingScreen extends StatelessWidget {
  //const SettingScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Update data',
                      style: TextStyle(fontSize: 45),
                    ),
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFailed(
                      controller: nameController,
                      type: TextInputType.name,
                      validatemsg: 'name must not be empty',
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFailed(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validatemsg: 'email must not be empty',
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFailed(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validatemsg: 'phone must not be empty',
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // defaultButton(
                    //   function: () {
                    //     // if (formKey.currentState!.validate()) {
                    //     //   // ShopCubit.get(context).updateUserData(
                    //     //   //   name: nameController.text,
                    //     //   //   phone: phoneController.text,
                    //     //   //   email: emailController.text,
                    //     //   // );
                    //     // }
                    //   },
                    //   text: 'update',
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // defaultButton(
                    //   function: () {
                    //     signOut(context);
                    //   },
                    //   text: 'Logout',
                    // ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        child: Text(
                          'Update'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: defaultColor,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: MaterialButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: Text(
                          'Logout'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: defaultColor,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
