import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marche/shared/bloc_observer.dart';
import 'package:marche/shared/components/constants.dart';
import 'package:marche/shared/networks/local/cache_helper.dart';
import 'package:marche/shared/networks/remote/dio_helper.dart';
import 'package:marche/shared/styles/themes.dart';
import 'layout/shop_layout/shop_layout_screen.dart';
import 'modules/cubit/cubit.dart';
import 'modules/cubit/states.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  // CacheHelper.removeData(key: 'token');
  // CacheHelper.removeData(key: 'onBoarding');

  if (onBoarding != null) {
    widget = ShopLayoutScreen();
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..initApp(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
