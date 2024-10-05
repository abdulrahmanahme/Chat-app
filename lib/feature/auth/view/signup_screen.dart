import 'package:chat_app/core/routing/routing.dart';
import 'package:chat_app/core/widgets/defult_button.dart';
import 'package:chat_app/core/widgets/text_from_field.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
              },
              builder: (context, state) {
                return Form(
                  key: fromKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Register ",
                          style: TextStyle(
                              fontFamily: 'Bolt Semibold',
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        TextFormFieldWidget(
                          controller: nameController,
                          hintText: 'Name',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: emailController,
                          hintText: 'Email',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter Email';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldWidget(
                          controller: phoneController,
                          hintText: ' Phone',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please Enter Phone';
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
                        DefaultButton(
                          buttonText: 'Create Account',
                          function: () {
                            if (fromKey.currentState!.validate()) {
                              context.read<AuthCubit>().registerNewUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
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
                              Routes.loginScreen,
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Bolt Semibold',
                              ),
                              children: [
                                TextSpan(
                                  text: "Login Here",
                                  style: TextStyle(
                                      fontFamily: 'Bolt Semibold',
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
