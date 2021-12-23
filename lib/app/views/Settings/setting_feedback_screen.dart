import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/controllers/cms_api_controller.dart';
import '../../models/feedback_api_model.dart';
import '../../../components/button_custom_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/textarea_custom_component.dart';
import '../../../components/textfield_custom_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/config.dart';
import '../../../utils/extentions.dart';
import '../../../utils/utils.dart';

class SettingFeedbackScreen extends StatefulWidget {
  const SettingFeedbackScreen({Key? key}) : super(key: key);

  @override
  _SettingFeedbackScreenState createState() => _SettingFeedbackScreenState();
}

class _SettingFeedbackScreenState extends State<SettingFeedbackScreen> {
  final CmsApiController _cmsApiController = Get.put(CmsApiController());
  TextEditingController? _nameController,
      _infoController,
      _phoneController,
      _messageController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _infoController = TextEditingController();
    _phoneController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _infoController?.dispose();
    _phoneController?.dispose();
    _messageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextfieldCustomComponent(
                        hintText: 'name'.tr, controller: _nameController),
                    SizedBox(height: 16),
                    TextfieldCustomComponent(
                        hintText: 'service'.tr, controller: _infoController),
                    SizedBox(height: 16),
                    TextfieldCustomComponent(
                        hintText: 'phone'.tr,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 16),
                    TextareaCustomComponent(
                        hintText: 'info'.tr, controller: _messageController),
                    SizedBox(height: 16),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: ButtonCustomComponent(
                            onPress: () async {
                              if (_infoController!.value.text.length > 3 &&
                                  _nameController!.value.text.length >= 3 &&
                                  _messageController!.value.text.length >= 10 &&
                                  _phoneController!.value.text.isPhoneNumber &&
                                  !_cmsApiController.isLoading.value) {
                                await _cmsApiController.sendFeedback(
                                  FeedbackApiModel(
                                      name: _nameController!.value.text,
                                      phone: _phoneController!.value.text,
                                      info: {
                                        'type': _infoController!.value.text,
                                      },
                                      imei: await getDeviceIdentifier(),
                                      message: _messageController!.value.text,
                                      branch: ConfigApp.branchAccess,
                                      type: 'feedback'),
                                );
                                if (this.mounted) {
                                  _infoController!.text = '';
                                  _nameController!.text = '';
                                  _messageController!.text = '';
                                  _phoneController!.text = '';
                                }
                              }
                            },
                            child: Text(
                              _cmsApiController.isLoading.value
                                  ? 'sending'.tr.firstUpperCase
                                  : 'send'.tr.firstUpperCase,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF1E272E),
                                fontFamily:
                                    'language.rtl'.tr.parseBool ? 'Rabar' : '',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.4),
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              'language.rtl'.tr.parseBool
                                  ? Iconsax.arrow_right_3
                                  : Iconsax.arrow_left_2,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                'feedback.send'.tr,
                                textAlign: 'language.rtl'.tr.parseBool
                                    ? TextAlign.left
                                    : TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'language.rtl'.tr.parseBool
                                      ? "Rabar"
                                      : "",
                                  fontSize: 24,
                                  color: !ThemeService().isSavedDarkMode()
                                      ? Color(0xFF1E272E)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
