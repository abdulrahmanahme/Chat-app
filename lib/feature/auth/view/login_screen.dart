import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/routing/routing.dart';
import 'package:chat_app/core/widgets/defult_button.dart';
import 'package:chat_app/core/widgets/text_from_field.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Form(
                key: fromKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: 'Bolt Semibold',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormFieldWidget(
                        controller: emailController,
                        hintText: ' Email',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Please Enter email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        controller: passwordController,
                        hintText: 'Password',
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is LoginLoadingStates
                          ? const Center(
                              child: CircularProgressIndicator(
                                // backgroundColor: Colors.amber,
                                color: AppColors.defaultColor,
                              ),
                            )
                          : DefaultButton(
                              buttonText: 'Login',
                              function: () {
                                if (fromKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signIn(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      );
                                }
                              },
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.signUpScreen,
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Do not have any account? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Bolt Semibold',
                            ),
                            children: [
                              TextSpan(
                                text: "Register Here",
                                style: TextStyle(
                                    fontFamily: 'Bolt Semibold',
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
