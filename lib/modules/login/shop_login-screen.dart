import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:marche/modules/cubit/cubit.dart';
import 'package:marche/modules/cubit/states.dart';

import '../../layout/shop_layout/shop_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';

class ShopLoginScreen extends StatefulWidget {
  final Widget? next;
  const ShopLoginScreen({Key? key, required this.next}) : super(key: key);

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    // Login stuff
    var loginformKey = GlobalKey<FormState>();
    var emailController_login = TextEditingController();
    var passwordController_login = TextEditingController();

    // Register
    var registerformKey = GlobalKey<FormState>();
    var emailController_register = TextEditingController();
    var passwordController_register = TextEditingController();
    var nameController_register = TextEditingController();
    var phoneController_register = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {
        if (states is ShopRegisterSuccessState ||
            states is ShopLoginSuccessState) {
          if (ShopCubit.get(context).loginModel!.status != null) {
            CacheHelper.saveData(
                    key: 'token',
                    value: ShopCubit.get(context).loginModel!.data!.token)
                .then((value) {
              ShopCubit.get(context).token =
                  ShopCubit.get(context).loginModel!.data!.token!;
            });
          } else {}
        }
      },
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: !login
                    ? Form(
                        key: registerformKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.shopping_cart,
                                size: 100,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            defaultFormField(
                              controller: nameController_register,
                              type: TextInputType.name,
                              label: 'Full Name',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Name must be not empty';
                                }
                              },
                              prefixIcon: Icons.person,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: emailController_register,
                              type: TextInputType.emailAddress,
                              label: 'Email Address',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must be not empty';
                                }
                              },
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              function: () {
                                ShopCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              controller: passwordController_register,
                              type: TextInputType.visiblePassword,
                              label: 'Password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'password must be not empty';
                                }
                              },
                              prefixIcon: Icons.lock,
                              suffixIcon: ShopCubit.get(context).suffix,
                              isPassword: ShopCubit.get(context).isPassword,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: phoneController_register,
                              type: TextInputType.phone,
                              label: 'Phone',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'phone must be not empty';
                                }
                              },
                              prefixIcon: Icons.call,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (BuildContext context) => true,
                              widgetBuilder: (BuildContext context) =>
                                  defaultButton(
                                      background: Colors.redAccent,
                                      radius: 25,
                                      text: 'Sign Up! ',
                                      function: () {
                                        if (registerformKey.currentState!
                                            .validate()) {
                                          ShopCubit.get(context).userRegister(
                                            email: emailController_login.text,
                                            password:
                                                passwordController_login.text,
                                            name: nameController_register.text,
                                            phone:
                                                phoneController_register.text,
                                          );
                                        }
                                      }),
                              fallbackBuilder: (BuildContext context) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Have account already?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        login = !login;
                                      });
                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Form(
                        key: loginformKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.shopping_cart,
                                size: 100,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            defaultFormField(
                              controller: emailController_login,
                              type: TextInputType.emailAddress,
                              label: 'Email ',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must be not empty';
                                }
                              },
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              function: () {
                                ShopCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              controller: passwordController_login,
                              type: TextInputType.visiblePassword,
                              label: 'Password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'password must be not empty';
                                }
                              },
                              prefixIcon: Icons.lock,
                              suffixIcon: ShopCubit.get(context).suffix,
                              isPassword: ShopCubit.get(context).isPassword,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (BuildContext context) =>
                                  states is! ShopLoginLoadingState,
                              widgetBuilder: (BuildContext context) =>
                                  defaultButton(
                                radius: 25,
                                text: 'Login',
                                background: Colors.redAccent,
                                function: () {
                                  if (loginformKey.currentState!.validate()) {
                                    ShopCubit.get(context).userLogin(
                                        email: emailController_login.text,
                                        password:
                                            passwordController_login.text);
                                  }
                                },
                              ),
                              fallbackBuilder: (BuildContext context) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        login = !login;
                                      });
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
