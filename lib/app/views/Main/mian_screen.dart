import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/views/Main/blog_screen.dart';
import '../../../app/views/Main/service_screen.dart';
import '../../../app/views/Main/setting_screen.dart';
import '../../../app/views/Main/shop_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Color _disable = const Color(0xff818181);
  int _index = 0;
  List<Widget>? _screen;
  @override
  void initState() {
    super.initState();
    _screen = [
      const ServiceScreen(),
      const ShopScreen(),
      const BlogScreen(),
      const SettingScreen(),
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
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Iconsax.setting_2),
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
                icon: const Icon(Iconsax.book_saved),
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
                icon: const Icon(Iconsax.shop),
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
                icon: const Icon(Iconsax.truck),
                color: _index == 0
                    ? Theme.of(context).textTheme.headline4!.color
                    : _disable,
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }
}
