import 'package:eighty_two/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      expandedHeight: MediaQuery.of(context).size.height / 2.3,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.3,
                color: Color(0xffF2F2F2),
              ),
              Positioned(
                bottom: 0,
                child: Transform.rotate(
                  angle: -0.13,
                  child: Image.asset(
                    "assets/images/shoe.png",
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: AppBar().preferredSize.height + 20,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Hello',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: " George",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 25,
                top: AppBar().preferredSize.height,
                child: Icon(
                  Icons.notifications_none_outlined,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
