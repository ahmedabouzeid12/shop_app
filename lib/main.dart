import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget  widget;

  token = CacheHelper.getData(key: 'token')??'';
  if(onBoarding != null)
  {
    if(token != '') widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{
  final Widget startWidget;

  const MyApp({
    required this.startWidget,
});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lihgtTheme,
      home: BlocProvider(create: (BuildContext context ) => ShopCubit()..getHomeData()..getCategories()..getFavoritea()..getUserData(),
        child: startWidget,
      ),
    );
  }
}

