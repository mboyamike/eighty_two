import 'package:eighty_two/authentication/providers/auth_provider.dart';
import 'package:eighty_two/authentication/repositories/firebase_auth_repository.dart';
import 'package:eighty_two/authentication/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EightyTwoApp());
}

class EightyTwoApp extends StatelessWidget {
  const EightyTwoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: FirebaseAuthRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "IBM Plex Sans",
        ),
        home: SignUpScreen(),
      ),
    );
  }
}
