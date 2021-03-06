import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/controllers/language_controller.dart';
import '../../components/button_custom_component.dart';
import '../../model/language_model.dart';
import '../../services/theme_service.dart';
import '../../utils/extentions.dart';

class SettingChangeLangaugeComponent extends StatefulWidget {
  const SettingChangeLangaugeComponent({Key? key}) : super(key: key);

  @override
  _SettingChangeLangaugeComponentState createState() =>
      _SettingChangeLangaugeComponentState();
}

class _SettingChangeLangaugeComponentState
    extends State<SettingChangeLangaugeComponent> {
  final LanguageController _languageController = Get.put(LanguageController());
  final List<LanguageModel> _listLanguage = [
    LanguageModel(
      name: 'کوردی',
      value: 'ku',
      code: 'ar_SO',
    ),
    LanguageModel(
      name: 'العربي',
      value: 'ar',
      code: 'ar_IQ',
    ),
    LanguageModel(
      name: 'English',
      value: 'en',
      code: 'en_US',
    ),
  ];
  LanguageModel? _selectedLanguage;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedLanguage =
          _listLanguage.firstWhere((element) => element.value == 'x-lang'.tr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: StatefulBuilder(
        builder: (context, setState) => Container(
          width: 1000,
          height: 213,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: Theme.of(context).colorScheme.secondary,
                  child: SizedBox(
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
                            ? const Color(0xFF1E272E)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeService().isSavedDarkMode()
                      ? const Color(0xFF292D32)
                      : Colors.grey.shade300,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    iconEnabledColor: Colors.transparent,
                    iconDisabledColor: Colors.transparent,
                    items: _listLanguage.map((item) {
                      return DropdownMenuItem<LanguageModel>(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontFamily:
                                  'language.rtl'.tr.parseBool ? "Rabar" : "",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: !ThemeService().isSavedDarkMode()
                                  ? const Color(0xFF1E272E)
                                  : const Color(0xff818181),
                            ),
                          ),
                        ),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (lang) {
                      setState(() {
                        _selectedLanguage = lang as LanguageModel?;
                      });
                    },
                    value: _selectedLanguage,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              ButtonCustomComponent(
                onPress: () {
                  _changeLanguage(_selectedLanguage);
                  Get.back();
                },
                child: Text(
                  'choose'.tr.firstUpperCase,
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color(0xFF1E272E),
                    fontFamily: 'language.rtl'.tr.parseBool ? 'Rabar' : '',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changeLanguage(languageModel) async {
    final List<String> _temp = languageModel!.code.split('_');
    _languageController.changeLanguage(language: _temp[0], dialect: _temp[1]);
  }
}
