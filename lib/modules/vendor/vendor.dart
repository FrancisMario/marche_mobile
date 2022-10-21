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
import '../login/shop_login-screen.dart';

class VendoRegistration extends StatelessWidget {
  const VendoRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var locationController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
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
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          'Become a vendor',
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
                        controller: nameController,
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
                        controller: phoneController,
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
                        height: 15,
                      ),
                      defaultFormField(
                        controller: locationController,
                        type: TextInputType.text,
                        label: 'Shop Location',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Shop location must be not empty';
                          }
                        },
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) => true,
                        widgetBuilder: (BuildContext context) => defaultButton(
                            background: Colors.redAccent,
                            radius: 25,
                            text: 'Submit! ',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).vendorRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  location: locationController.text,
                                );
                              }
                            }),
                        fallbackBuilder: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
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
