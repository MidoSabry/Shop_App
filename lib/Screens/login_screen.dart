import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecomerce_app/Bloc/cubit.dart';
import 'package:flutter_ecomerce_app/Bloc/state.dart';
import 'package:flutter_ecomerce_app/Layout/shop_layout.dart';
import 'package:flutter_ecomerce_app/Widgets/default_text_field.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateAndFinish.dart';
import 'package:flutter_ecomerce_app/Widgets/navigateTo.dart';
import 'package:flutter_ecomerce_app/Widgets/toast.dart';
import 'package:flutter_ecomerce_app/shared/cache_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  var formkey = GlobalKey<FormState>();

  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, AppStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              // Fluttertoast.showToast(
              //     msg: state.loginModel.message.toString(),
              //     toastLength: Toast.LENGTH_LONG,
              //     //gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.green,
              //     textColor: Colors.white,
              //     fontSize: 16.0);

              CasheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);

              // Fluttertoast.showToast(
              //     msg: state.loginModel.message.toString(),
              //     toastLength: Toast.LENGTH_LONG,
              //     //gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0);

              showToast(
                text: state.loginModel.message.toString(),
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(colors: [Colors.red, Colors.amber])),
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(left: 30.0, top: 20),
                          child: Image(
                            image: AssetImage(
                              'assets/images/login.png',
                            ),
                            width: 250,
                            height: 250,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'Welcome back!',
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
                            'Log in your existent account of Q Allure',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: defaultTextFailed(
                            controller: emailcontroller,
                            label: 'Email',
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                            validatemsg: 'email is required',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: defaultTextFailed(
                            controller: passwordcontroller,
                            label: 'Password',
                            prefix: Icons.lock,
                            isPassword: ShopCubit.get(context).isPassword,
                            suffixpressed: () {
                              ShopCubit.get(context).changePasswordVisibility();
                            },
                            suffix: ShopCubit.get(context).suffix,
                            type: TextInputType.emailAddress,
                            validatemsg: 'password is required',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'ForgetPassword?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .06,
                          child: ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => ElevatedButton(
                              child: Text("Login"),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  ShopCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                  print('ok');
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
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'don\'t have an account?',
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
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                onTap: () {
                                  navigateTo(
                                    context,
                                    RegisterScreen(),
                                  );
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
            ),
          );
        },
      ),
    );
  }
}
