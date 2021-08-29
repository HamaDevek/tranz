import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trancehouse/app/views/Main/blog_screen.dart';
import 'package:trancehouse/app/views/Main/service_screen.dart';
import 'package:trancehouse/app/views/Main/setting_screen.dart';
import 'package:trancehouse/app/views/Main/shop_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color _disable = Color(0xff818181);
  int _index = 0;
  List<Widget>? _screen;
  @override
  void initState() {
    super.initState();
    _screen = [
      ServiceScreen(),
      ShopScreen(),
      BlogScreen(),
      SettingScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen![_index],
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Iconsax.setting_2),
                color: _index == 3
                    ? Theme.of(context).textTheme.headline4!.color
                    : _disable,
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Iconsax.book_saved),
                color: _index == 2
                    ? Theme.of(context).textTheme.headline4!.color
                    : _disable,
                onPressed: () {
                  setState(() {
                    _index = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(Iconsax.shop),
                color: _index == 1
                    ? Theme.of(context).textTheme.headline4!.color
                    : _disable,
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Iconsax.broom),
                color: _index == 0
                    ? Theme.of(context).textTheme.headline4!.color
                    : _disable,
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}