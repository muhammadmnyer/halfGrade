import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/quiz_info.dart';
import 'package:half_grade/core/validate.dart';
import 'package:half_grade/main.dart';
import 'package:half_grade/presentation_layer/logic_holders/available_quizzes_cubit/available_quizzes_cubit.dart';
import 'package:half_grade/presentation_layer/logic_holders/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:half_grade/presentation_layer/logic_holders/played_quizzes_screen/played_quizzes_cubit.dart';
import 'package:half_grade/presentation_layer/logic_holders/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:half_grade/presentation_layer/screens/auth_screens/login_screen.dart';
import 'package:half_grade/presentation_layer/screens/auth_screens/signup_screen.dart';
import 'package:half_grade/presentation_layer/screens/available_quizzes_screen.dart';
import 'package:half_grade/presentation_layer/screens/edit_profile_screen.dart';
import 'package:half_grade/presentation_layer/screens/played_quizzes_screen.dart';
import 'package:half_grade/presentation_layer/screens/quiz_screen.dart';
import 'package:half_grade/presentation_layer/screens/home_screen.dart';
import 'package:half_grade/presentation_layer/screens/profile_screen.dart';
import 'package:half_grade/presentation_layer/screens/ranking_screen.dart';
import 'package:half_grade/presentation_layer/screens/subject_topics_screen.dart';
import 'package:half_grade/presentation_layer/widgets/bottom_nav_bar_holder.dart';
import 'package:half_grade/presentation_layer/widgets/gradient_background.dart';
import 'package:half_grade/presentation_layer/widgets/not_found_screen.dart';

class AppPages {

  static final GlobalKey<NavigatorState> mainNavigator = GlobalKey();
  static final GlobalKey<NavigatorState> _homeNavigator = GlobalKey();
  static final GlobalKey<NavigatorState> _profileNavigator = GlobalKey();


  static Route mainNavigation(RouteSettings settings){
    final String routeName = Validate.deepLinkValidation(settings.name!);
    late final Widget screen;

    if(supabase.auth.currentUser == null && routeName.startsWith('/')){
      screen = LoginScreen();
      return PageRouteBuilder(
        settings: const RouteSettings(name: '/login',),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
      );
    }

    if(routeName == '/'){
      screen = BottomNavBarHolder(
          screens: [
            NavigatorPopHandler(
              onPop: () {
                _homeNavigator.currentState!.pop();
              },
              child: Navigator(
                key: _homeNavigator,
                initialRoute: 'home',
                onGenerateRoute: homeScreenNavigation,
              ),
            ),
            const RankingScreen(),
        NavigatorPopHandler(
              onPop: () {
                _profileNavigator.currentState!.pop();
              },
              child: Navigator(
                key: _profileNavigator,
                initialRoute: 'profile',
                onGenerateRoute: profileScreenNavigation,
              ),
            )
          ]
      );

    }

    /// signup and login can't start with '/' because of the behavior of onGenerateInitialRoutes


    else if(routeName == 'signup'){
      screen = SignupScreen();
    }

    else if(routeName == 'login'){
      screen = LoginScreen();
    }

    else if(routeName.startsWith('/exam')){
      final id = int.parse(routeName.split('?id=')[1]);
      screen = BlocProvider<QuizScreenCubit>(
          create: (context) => QuizScreenCubit(),
          child: QuizInfo(child: QuizScreen(id: id))
      );
    }

    else{
      screen = const NotFoundScreen();
    }

    /*return PageRouteBuilder(
        settings: RouteSettings(
          arguments: settings.arguments,
          name: settings.name!.startsWith('/')?settings.name!:"/${settings.name!}",
        ),
        pageBuilder: (context,animation,secondaryAnimation) => screen,
        reverseTransitionDuration: const Duration(seconds: 0)
    );*/

    return _routeBuilder(
      screen: screen,
      settings: RouteSettings(
        arguments: settings.arguments,
        name: settings.name!.startsWith('/')?settings.name!:"/${settings.name!}",
      ),
    );
  }

  static Route homeScreenNavigation(RouteSettings settings){
    late final Widget screen;
    switch(settings.name){

      case "home":
        screen = const HomeScreen();
        break;

      case "topics":
        screen = SubjectTopicsScreen(topics: settings.arguments as List<String>);
        break;

      case "available_quizzes":
        screen = BlocProvider<AvailableQuizzesCubit>(
            create: (context) => AvailableQuizzesCubit(),
            child: AvailableQuizzesScreen(
              topic: settings.arguments as String,
            ));
        break;

    }
    /*return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      reverseTransitionDuration: const Duration(seconds: 0)
    );*/
    return _routeBuilder(screen: screen);
  }

  static Route profileScreenNavigation(RouteSettings settings){
    late final Widget screen;

    switch(settings.name){
      case "profile":
        screen = const ProfileScreen();
        break;
      case "played_quizzes":
        screen = BlocProvider<PlayedQuizzesCubit>(
            create: (context) => PlayedQuizzesCubit()..load(),
            child: const PlayedQuizzesScreen());
        break;

      case "edit_profile":
        screen = BlocProvider<EditProfileCubit>(
            create: (context) => EditProfileCubit(),
            child: EditProfileScreen());
        break;
    }

    /*return MaterialPageRoute(builder: (context) => screen,);*/
    return _routeBuilder(screen: screen);
  }

  static List<Route<dynamic>> mainNavigatorOnGenerateInitialRoutes(String initialRoute){
    initialRoute = Validate.deepLinkValidation(initialRoute);

    return Navigator.defaultGenerateInitialRoutes(
        AppPages.mainNavigator.currentState!,
        initialRoute
    );
  }

  static Route _routeBuilder({required Widget screen,RouteSettings? settings}){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GradientBackground(child: screen),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0)
                ).animate(animation),
                child: child,
            );
        },
      settings: settings
    );
  }

}




