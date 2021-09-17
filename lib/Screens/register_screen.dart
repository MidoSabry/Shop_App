import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Consts/consts.dart';
import 'package:flutter_ecomerce_app/Layout/shop_layout.dart';
import 'package:flutter_ecomerce_app/Screens/login_screen.dart';
import 'package:flutter_ecomerce_app/Widgets/default_text_field.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateAndFinish.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateTo.dart';
import 'package:flutter_ecomerce_app/Widgets/toast.dart';
import 'package:flutter_ecomerce_app/shared/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  //const RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, AppStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CasheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token!;

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message.toString(),
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(colors: [Colors.red, Colors.amber])),
                  padding: EdgeInsetsDirectional.only(
                      top: 60, bottom: 15, start: 15, end: 15),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Let\'s Get Started',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'Create an account to Q Allure to get all features',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: defaultTextFailed(
                              controller: nameController,
                              label: 'Name',
                              prefix: Icons.person,
                              type: TextInputType.name,
                              validatemsg: ' Name is required',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: defaultTextFailed(
                              controller: emailController,
                              label: 'Email',
                              prefix: Icons.email,
                              type: TextInputType.emailAddress,
                              validatemsg: ' email is required',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: defaultTextFailed(
                              controller: phoneController,
                              label: 'Phone',
                              prefix: Icons.phone,
                              type: TextInputType.phone,
                              validatemsg: ' phone is required',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: defaultTextFailed(
                              controller: passwordController,
                              label: ' Password',
                              prefix: Icons.lock,
                              isPassword: ShopCubit.get(context).isPassword,
                              suffixpressed: () {
                                ShopCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              suffix: ShopCubit.get(context).suffix,
                              type: TextInputType.emailAddress,
                              validatemsg: ' password is required',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => Container(
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .06,
                              child: ElevatedButton(
                                child: Text("Register"),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                ),
                              ),
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have account?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Text(
                                    'Signin',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  onTap: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
