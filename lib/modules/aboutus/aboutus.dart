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

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text("About Us"),
                  Divider(),
                  Text(
                      "Marche 24/7 is created by Gambians from different background yet, equally ambitious and passionate about contributing on the socioeconomic development in the Gambia. At MARCHE 24/7, we understand the rapidly changing nature of the world and its reliance on technology. Countries around the globe are doing whatever possible to evolve around this change, and for MARCHE 24/7,  The Gambia is not an exception in this effort. For this reason, MARCHE 24/7 provides you a platform where shopping will be made safe, reliable and at the touch of a button for every Gambian and their loved ones.")
                ],
              )),
        ),
      ),
    );
  }
}
