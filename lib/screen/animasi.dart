import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Animasi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimasiState();
  }
}

class _AnimasiState extends State<Animasi> {
  bool animated = false;
  late Timer _timer;
  int _posisi = 1;
  double _left = 0;
  double _top = 0;
  double _wh = 100;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        animated = !animated;
        _posisi++;
        if (_posisi > 4) _posisi = 1;
        if (_posisi == 1) {
          _left = 250;
          _top = 0;
        }
        if (_posisi == 2) {
          _left = 0;
          _top = 0;
        }
        if (_posisi == 3) {
          _left = 0;
          _top = 100;
        }
        if (_posisi == 4) {
          _left = 250;
          _top = 100;
        }
        // Untuk membesar/kecilkan ufo
        if (_top == 0) {
          _wh = 100;
        } else if (_top == 100) {
          _wh = 200;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('animation test'),
        ),
        body: ListView(children: <Widget>[
          //later, we add widgets here
          AnimatedDefaultTextStyle(
            style: animated
                ? TextStyle(
                    color: Colors.blue,
                    fontSize: 60,
                  )
                : TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
            duration: Duration(milliseconds: 1000),
            child: Column(children: [
              Text('Hello'),
              Text("Animasi"),
              TextButton(onPressed: () {}, child: Text("Ini Animasi"))
            ]),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                animated = !animated;
              });
            },
            child: Text('Animate'),
          ),
          Container(
              width: 250.0,
              height: 250.0,
              child: AnimatedAlign(
                alignment: animated ? Alignment.topRight : Alignment.bottomLeft,
                duration: const Duration(seconds: 1),
                curve: Curves.bounceInOut,
                child:
                    Image.network('https://placekitten.com/100/100?image=12'),
              )),
          AnimatedOpacity(
            opacity: animated ? 1 : 0,
            duration: const Duration(milliseconds: 1000),
            child: Image.network('https://placekitten.com/240/360?image=10'),
          ),
          // AnimatedContainer(
          //   height: animated ? 200 : 300,
          //   margin: EdgeInsets.all(50),
          //   decoration: animated
          //       ? BoxDecoration(
          //           image: DecorationImage(
          //             image: NetworkImage(
          //                 'https://placekitten.com/400/400?image=8'),
          //             fit: BoxFit.cover,
          //           ),
          //           border: Border.all(
          //             color: Colors.indigo,
          //             width: 10,
          //           ),
          //           shape: BoxShape.rectangle,
          //           borderRadius: BorderRadius.all(Radius.circular(100)),
          //         )
          //       : BoxDecoration(
          //           image: DecorationImage(
          //             image: NetworkImage(
          //                 'https://placekitten.com/400/400?image=9'),
          //             fit: BoxFit.cover,
          //           ),
          //           border: Border.all(
          //             color: Colors.amber,
          //             width: 5,
          //           ),
          //           shape: BoxShape.rectangle,
          //           borderRadius: BorderRadius.all(Radius.circular(30)),
          //         ),
          //   duration: const Duration(seconds: 1),
          //   curve: Curves.fastOutSlowIn,
          // ),
          Center(
              child: AnimatedCrossFade(
            duration: const Duration(seconds: 3),
            firstChild: Image(
                image: AssetImage("assets/images/mark.jpeg"),
                fit: BoxFit.fitWidth,
                width: 200,
                height: 240),
            secondChild: Image(
                image: AssetImage("assets/images/hulk.jpeg"),
                fit: BoxFit.fitWidth,
                width: 200,
                height: 240),
            crossFadeState:
                animated ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          )),
          AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // return RotationTransition(child: child, turns: animation);
              return ScaleTransition(child: child, scale: animation);
            },
            child: animated ? widget1() : widget2(),
          ),
          Container(
              width: 400,
              height: 300,
              child: Stack(children: [
                Image.asset(
                  "assets/images/city.jpeg",
                  scale: 0.5,
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  left: _left,
                  top: _top,
                  child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: _wh,
                      height: _wh,
                      child: Image.asset("assets/images/ufo.gif")),
                ),
              ])),
          TweenAnimationBuilder(
            duration: const Duration(seconds: 20),
            tween: Tween<double>(begin: 0, end: 5 * math.pi),
            builder: (_, double angle, __) {
              return Transform.rotate(
                angle: angle,
                child: Image.asset('assets/images/earth.png'),
              );
            },
          ),
          TweenAnimationBuilder(
            child: Image.asset('assets/images/earth.png'),
            duration: const Duration(seconds: 5),
            tween: ColorTween(begin: Colors.blue, end: Colors.red),
            builder: (_, Color? color, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                child: child,
              );
            },
          ),
          TweenAnimationBuilder(
            child: Image.asset('assets/images/earth.png'),
            duration: const Duration(seconds: 5),
            tween: ColorTween(begin: Colors.blue, end: Colors.red),
            builder: (_, Color? color, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                    color ?? Colors.transparent, BlendMode.modulate),
                child: child,
              );
            },
          ),
        ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  Widget widget1() {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          "Click me!",
          style: TextStyle(fontSize: 30),
        ));
  }

  Widget widget2() {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Click me!",
          style: TextStyle(fontSize: 30),
        ));
  }
}
