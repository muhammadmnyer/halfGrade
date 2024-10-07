import 'package:flutter/material.dart';

class AppPages {
  static Route bottomNavigationBarGenerateRoute(RouteSettings settings) {
    late Widget screen;
    switch(settings.name){
      case "/":

        break;
      case "/profile":

        break;
      case "/rank":

        break;
      case "/topics":

        break;
      case "/exam":

        break;
    }
    screen = const SizedBox();
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)=> screen,
    );
  }


}

class BottomNavBarHolder extends StatelessWidget {
  final Widget screen;
  const BottomNavBarHolder({super.key,required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: screen
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: const Text('home')
                    )
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/rank');
                        },
                        child: const Text('rank')
                    )
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/profile');
                        },
                        child: const Text('profile')
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



