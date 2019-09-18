import 'package:flutter/material.dart';
import 'dart:async';
import 'package:js/js.dart';
import 'interactive_canvas_js.dart';

Future main() async {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SpinningSquare(),
        ),
      ),
    ),
  );
}

class SpinningSquare extends StatefulWidget {
  @override
  _SpinningSquareState createState() => new _SpinningSquareState();
}

class _SpinningSquareState extends State<SpinningSquare>
    with SingleTickerProviderStateMixin {
  StreamSubscription _updateSubscription;
  Color color = Color(65280 | 0xFF000000);

  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    // We use 3600 milliseconds instead of 1800 milliseconds because 0.0 -> 1.0
    // represents an entire turn of the square whereas in the other examples
    // we used 0.0 -> math.pi, which is only half a turn.
    _animation = new AnimationController(
      duration: const Duration(milliseconds: 3600),
      vsync: this,
    )..repeat();
    initInteractiveCanvas();
  }

  void initInteractiveCanvas() {
    var canvas = interactiveCanvas;
    canvas.ready(InteractiveCanvasCallbacks(
      onUpdate: allowInterop((OnUpdateData data) {
        print('plugin invoking onUpdate $data');
        print('data runtimeType ${data.runtimeType}');
        print('data.command = ${data.command}');
        print('data.tint = ${data.tint}');
        print('data.spin = ${data.spin}');
        if (data.command == 'SPIN') {
          if (data.spin == true) {
            _animation.repeat();
          } else {
            _animation.stop();
          }
        } else if (data.command == 'TINT') {
          setState(() {
            color = Color(data.tint | 0xFF000000);
          });
        }
      }),
    ));
  }

  @override
  void dispose() {
    _updateSubscription.cancel();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new RotationTransition(
        turns: _animation,
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: color,
        ));
  }
}
