import 'package:eighty_two/authentication/providers/auth_provider.dart';
import 'package:eighty_two/authentication/screens/screens.dart';
import 'package:eighty_two/shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, provider, __) {
        if (provider.user == null) {
          return SignUpScreen();
        }

        return HomeScreen();
      },
    );
  }
}
