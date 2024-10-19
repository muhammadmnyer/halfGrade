import 'package:flutter/material.dart';
import 'package:half_grade/main.dart';

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

class BottomNavBarHolder extends StatefulWidget {
  final Widget screen;
  const BottomNavBarHolder({super.key,required this.screen});

  @override
  State<BottomNavBarHolder> createState() => _BottomNavBarHolderState();
}

class _BottomNavBarHolderState extends State<BottomNavBarHolder> with TickerProviderStateMixin{
  late final AnimationController _firstController ;
  late final AnimationController _secondController ;
  late final AnimationController _thirdController;
  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    _firstController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    )..forward();
    _secondController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    _thirdController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    _animationControllers = [
      _firstController,
      _secondController,
      _thirdController
    ];

    _firstController.addStatusListener((status) {
      if(status == AnimationStatus.forward ){
        setState(() {});
      }
    },);

    _secondController.addStatusListener((status) {
      if(status == AnimationStatus.forward ){
        setState(() {});
      }
    },);

    _thirdController.addStatusListener((status) {
      if(status == AnimationStatus.forward ){
        setState(() {});
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: widget.screen
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.black)
            ),
            child: Row(
              children: [
                _buildNavBarItem(
                    icon: Icons.home,
                    label: 'Home',
                    animationControllers: _animationControllers,
                    index: 0,
                    widthScale: 120,
                    height: 45,
                    navigationPath: '/'
                ),
                _buildNavBarItem(
                    icon: Icons.sort,
                    label: 'Rank',
                    animationControllers: _animationControllers,
                    index: 1,
                    widthScale: 120,
                    height: 45,
                    navigationPath: '/rank'
                ),
                _buildNavBarItem(
                    icon: Icons.person,
                    index: 2,
                    label: 'Profile',
                    animationControllers: _animationControllers,
                    widthScale: 120,
                    height: 45,
                    navigationPath: '/profile'
                )
              ],
            )
          )
        ],
      ),
    );
  }


  Widget _buildNavBarItem({
    required IconData icon,
    required String label,
    required List<AnimationController> animationControllers,
    required int index,
    required int widthScale,
    required double height,
    required String navigationPath
}) => Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: animationControllers[index],
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height,
                  //TODO: set width scale to 1000
                  width: animationControllers[index].value * widthScale,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
              );
            },
          ),
          InkWell(
              onTap: () async {
                for (var element in animationControllers) {
                  element.reverse();
                }
                await Future.delayed(const Duration(milliseconds: 225));
                animationControllers[index].forward();
                bottomNav.currentState!.pushReplacementNamed(navigationPath);

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  animationControllers[index].status == AnimationStatus.forward ||
                      animationControllers[index].status == AnimationStatus.completed
                      ?
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(width: 4,),
                    ],
                  ):const SizedBox.shrink(),
                  Icon(
                      icon,
                      color:
                      animationControllers[index].status == AnimationStatus.forward ||
                          animationControllers[index].status == AnimationStatus.completed
                          ?
                      Colors.white:
                      Colors.blueGrey
                  )
                ],
              )
          )
        ],
      )
  );

}



