import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marche/modules/airtime/buyairtime.dart';
import 'package:marche/modules/credit/addcard.dart';
import 'package:marche/modules/credit/card.dart';
import 'package:marche/modules/cubit/states.dart';
import '../../models/shop_app/home_model.dart';
import '../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../login/shop_login-screen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool tri = true;

  int num = 0;

  bool readOnly = true;

  bool showSegmentedControl = true;

  final _formKey = GlobalKey<FormBuilderState>();

  String? name = "";

  String? email = "";

  String? phone = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        print((ShopCubit.get(context).loginModel == null));
        // print(ShopCubit.get(context).loginModel!.data!.email.toString());
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
              ShopCubit.get(context).loginModel != null,
          widgetBuilder: (BuildContext context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Mario Gomez",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                        FormBuilder(
                          key: _formKey,
                          // enabled: false,
                          onChanged: () {
                            _formKey.currentState!.save();
                            debugPrint(_formKey.currentState!.value.toString());
                          },
                          autovalidateMode: AutovalidateMode.disabled,
                          skipDisabled: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 15),
                              FormBuilderTextField(
                                readOnly: readOnly,
                                autovalidateMode: AutovalidateMode.disabled,
                                name: 'email',
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                                initialValue: ShopCubit.get(context)
                                    .loginModel!
                                    .data!
                                    .email,
                                onEditingComplete: () {},
                                onChanged: (val) {},
                                valueTransformer: (text) => int.tryParse(text!),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 15),
                              FormBuilderTextField(
                                readOnly: readOnly,
                                autovalidateMode: AutovalidateMode.disabled,
                                name: 'phone',
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                ),
                                initialValue: ShopCubit.get(context)
                                    .loginModel!
                                    .data!
                                    .email,
                                onEditingComplete: () {},
                                onChanged: (val) {},
                                valueTransformer: (text) => int.tryParse(text!),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            readOnly
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            readOnly = false;
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Edit',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            readOnly = true;
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            !readOnly
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _formKey.currentState;
                                        },
                                        child: Center(
                                          child: Text(
                                            'Update',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Payment Cards',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              navigateTo(context, const AddCard());
                            },
                            child: const Text("Add Card"),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          fallbackBuilder: (BuildContext context) => Center(
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Profile"),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                          child: Text(
                        "Please login to continue",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  ShopLoginScreen(
                                    next: SettingsScreen(),
                                  ));
                            },
                            child: Container(
                                width: 100,
                                height: 25,
                                child: Center(
                                    child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )))),
                      )
                    ],
                  ))),
        );
      },
      listener: (context, state) {},
    );
  }
}
