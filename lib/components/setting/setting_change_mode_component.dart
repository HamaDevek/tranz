import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/button_custom_component.dart';
import '../../services/theme_service.dart';
import '../../utils/extentions.dart';

class SettingChangeColorComponent extends StatefulWidget {
  const SettingChangeColorComponent({Key? key}) : super(key: key);

  @override
  _SettingChangeColorComponentState createState() =>
      _SettingChangeColorComponentState();
}

class _SettingChangeColorComponentState
    extends State<SettingChangeColorComponent> {
  String? _selectedColor;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedColor =
          !ThemeService().isSavedDarkMode() ? "mode.light".tr : "mode.dark".tr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: StatefulBuilder(
        builder: (context, setState) => Container(
          width: 1000,
          height: 213,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: Theme.of(context).accentColor,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'language.choose'.tr,
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
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeService().isSavedDarkMode()
                      ? Color(0xFF292D32)
                      : Colors.grey.shade300,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    iconEnabledColor: Colors.transparent,
                    iconDisabledColor: Colors.transparent,
                    items: ["mode.dark".tr, "mode.light".tr].map((item) {
                      return DropdownMenuItem<String>(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontFamily: "Rabar",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: !ThemeService().isSavedDarkMode()
                                  ? Color(0xFF1E272E)
                                  : Color(0xff818181),
                            ),
                          ),
                        ),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (str) {
                      setState(() {
                        _selectedColor = str as String?;
                      });
                    },
                    value: _selectedColor,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                child: ButtonCustomComponent(
                  onPress: () {
                    "mode.light".tr == _selectedColor
                        ? ThemeService().changeThemeToLight()
                        : ThemeService().changeThemeToDark();

                    Get.back();
                  },
                  child: Text(
                    'choose'.tr.firstUpperCase,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF1E272E),
                      fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
