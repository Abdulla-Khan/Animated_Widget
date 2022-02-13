import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener(listener);
    controller.forward();
    super.initState();
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Animate(animation),
      ),
    );
  }
}

class Animate extends AnimatedWidget {
  static final _opacity = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizetween = Tween<double>(begin: 0.0, end: 300.0);
  static final _rotation = Tween<double>(begin: 0.0, end: 13.5);

  Animate(Animation<double> animation) : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Transform.rotate(
        angle: _rotation.evaluate(animation),
        child: Opacity(
          opacity: _opacity.evaluate(animation),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: _sizetween.evaluate(animation),
            height: _sizetween.evaluate(animation),
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
