import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    Key? key,
    required this.duration,
    required this.text,
    this.onPress,
  }) : super(key: key);

  final Duration duration;
  final String text;
  final VoidCallback? onPress;

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    Future.delayed(Duration(milliseconds: 200), () {
      _animationController!.forward();
    });
    _animation = Tween<Offset>(
            begin: Offset(MediaQuery.of(context).size.width, 0.0),
            end: Offset(0.0, 0.0))
        .animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation!.value,
          child: child,
        );
      },
      child: FlatButton(
        onPressed: widget.onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color(0xff2545ff),
        padding: EdgeInsets.symmetric(vertical: 17),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
