import 'package:flutter/material.dart';

class BottomNavBarHolder extends StatefulWidget {
  final List<Widget> screens;
  const BottomNavBarHolder({super.key,required this.screens});

  @override
  State<BottomNavBarHolder> createState() => _BottomNavBarHolderState();
}

class _BottomNavBarHolderState extends State<BottomNavBarHolder>
    with TickerProviderStateMixin{
  int _index = 0;

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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget.screens[_index],
          Container(
              height: 65,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),

              ),
              child: Row(
                children: [
                  _buildNavBarItem(
                      icon: Icons.home,
                      label: 'Home',
                      animationControllers: _animationControllers,
                      index: 0,
                      widthScale: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      navigationPath: 'home'
                  ),
                  _buildNavBarItem(
                      icon: Icons.sort,
                      label: 'Rank',
                      animationControllers: _animationControllers,
                      index: 1,
                      widthScale: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      navigationPath: 'rank'
                  ),
                  _buildNavBarItem(
                      icon: Icons.person,
                      index: 2,
                      label: 'Profile',
                      animationControllers: _animationControllers,
                      widthScale: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      navigationPath: 'profile'
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
    required double widthScale,
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
                // bottomNav.currentState!.pushReplacementNamed(navigationPath);
                setState((){
                  _index = index;
                });
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
                            color: Colors.white,
                            fontSize: 16
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