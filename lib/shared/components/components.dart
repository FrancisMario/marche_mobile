//import 'package:udemy_first_app/modules/login/login_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/cubit/cubit.dart';
import '../styles/colors.dart';
import '../styles/icon_broken.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defaultTextButton({
  required String text,
  Color? color,
  required Function function,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required String text,
  required Function function,
  bool isUpperCase = true,
  double radius = 10,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        /*()
        {
          function();
          }*/
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

/////////////////////////////////////

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String? label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  int? max,
  onSubmit,
  onChange,
  onTap,
  required validator,
  function,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      maxLength: max,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black26,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black26,
            width: 2.0,
          ),
        ),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                ),
                onPressed: function,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget designedFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String? label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  onSubmit,
  onChange,
  onTap,
  required validator,
  function,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.red),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                ),
                onPressed: function,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void showToast({
  required text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultFallback({
  required String text,
}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.hourglass_empty,
            size: 100,
            color: Colors.black38,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );

Widget processingLoader({
  required String text,
}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(
        title!,
      ),
      titleSpacing: 5,
      actions: actions,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
    );
