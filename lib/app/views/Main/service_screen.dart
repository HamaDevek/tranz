import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trancehouse/components/no_glow_component.dart';
import 'package:trancehouse/components/services/service_card_component.dart';
import 'package:trancehouse/services/theme_service.dart';
import 'package:get/get.dart';
import '../../../utils/extentions.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool _isGrid = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 'language.rtl'.tr.parseBool ? 0 : 16,
                        right: 'language.rtl'.tr.parseBool ? 16 : 0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeService().isSavedDarkMode()
                          ? Color(0xFF292D32)
                          : Colors.white,
                    ),
                    child: Icon(Iconsax.notification),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'services'.tr,
                    textAlign: 'language.rtl'.tr.parseBool
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'language.rtl'.tr.parseBool ? "Rabar" : "",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: !ThemeService().isSavedDarkMode()
                          ? Color(0xFF1E272E)
                          : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isGrid = !_isGrid;
                      });
                    },
                    icon: Icon(_isGrid
                        ? Iconsax.row_vertical
                        : Iconsax.row_horizontal),
                  )
                ],
              )),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: GridView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _isGrid ? 2 : 1,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.6),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: _isGrid ? 145 : 185),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemBuilder: (_, __) {
                    return ServiceCardComponent();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
