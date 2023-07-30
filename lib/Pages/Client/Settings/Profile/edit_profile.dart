import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranzhouse/Getx/Controllers/user_controller.dart';
import 'package:tranzhouse/Theme/theme.dart';
import 'package:tranzhouse/Utility/utility.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Modal/confirmation_modal.dart';
import 'package:tranzhouse/Widgets/Other/app_spacer.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';
import 'package:tranzhouse/Widgets/Other/image_widget.dart';
import 'package:tranzhouse/Widgets/Text/text_widget.dart';
import 'package:tranzhouse/Widgets/TextField/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static const routeName = '/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late String phone;
  XFile? _profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    nameController.text = UserController.to.user?.value.user?.name ?? "";
    // phone = UserController.to.user?.value.user?.phone
    //         ?.substring(4, UserController.to.user?.value.user?.phone?.length) ??
    //     "";
    phone = UserController.to.user?.value.user?.phone?.split("+964").last ?? "";

    phoneController.text =
        formatPhoneNumber(int.parse(phone), withCountryCode: false);
    addressController.text = "Zargata, Sulaimaniyah, Iraq";
    UserController.to.resetValues();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBarWidget(
          pageTitle: "Edit Profile",
          onPressedBackButton: () {
            if (UserController.to.isProfileInfoChanged.value == true) {
              ConfirmationDialogWidget.show(
                context,
                onConfirmed: () async {
                  Get.back();
                },
                confirmButtonColor: ColorPalette.primary,
                confirmTextColor: ColorPalette.whiteColor,
                cancelButtonColor: ColorPalette.primaryLight,
                bodyText: "Save changes before leaving?",
                confirmText: "Save",
                cancelText: "Don't Save",
              ).then((value) {
                Get.back();
              });
            } else {
              Get.back();
            }
          },
          actions: [
            IconButton(
              onPressed: () {
                ConfirmationDialogWidget.show(
                  context,
                  onConfirmed: () async {
                    UserController.to.logOut();
                  },
                  bodyText: "Are you sure you want to logout?",
                );
              },
              icon: TextWidget(
                "Logout",
                style: TextWidget.textStyleCurrent.copyWith(
                  color: ColorPalette.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AppSpacer.p8(),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacer.p20(),
            Center(
              child: ProfileAvatarWidget(
                imageUrl: "https://picsum.photos/900/200",
                onProfileImageSelected: (file) {
                  _profileImage = file;
                  print(_profileImage?.path);
                },
              ),
            ),
            AppSpacer.p32(),
            TextFieldWidget(
              controller: nameController,
              hintText: "Name",
              onChanged: (value) {
                UserController.to.isNameChanged(name: value);
              },
            ),
            AppSpacer.p16(),
            TextFieldWidget(
              controller: phoneController,
              hintText: "Phone",
              onChanged: (value) {
                UserController.to.isPhoneChanged(phone: value);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                MaskedTextInputFormatter(
                  mask: "xxx xxx xxxx",
                  separator: " ",
                )
              ],
            ),
            AppSpacer.p16(),
            TextFieldWidget(
              controller: addressController,
              hintText: "Address",
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        persistentFooterButtons: [
          RequestButtonWidget(
            disabled: UserController.to.isProfileInfoChanged.value == false,
            width: screenWidth(context),
            onPressed: () async {},
            text: "Update",
          ).paddingSymmetric(horizontal: 8),
        ],
      );
    });
  }
}

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget({
    super.key,
    required this.onProfileImageSelected,
    required this.imageUrl,
  });
  final Function(XFile file) onProfileImageSelected;
  final String imageUrl;

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  XFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageFile: _profileImage != null ? File(_profileImage!.path) : null,
          imageUrl: widget.imageUrl,
          height: screenWidth(context) * .3,
          width: screenWidth(context) * .3,
          isCircle: true,
          border: Border.all(
            color: ColorPalette.whiteColor,
            width: 1,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              ImagePicker()
                  .pickImage(
                source: ImageSource.gallery,
                maxHeight: 512,
                maxWidth: 512,
                imageQuality: 90,
              )
                  .then((value) {
                if (value != null) {
                  setState(() {
                    _profileImage = value;
                    widget.onProfileImageSelected.call(_profileImage!);
                  });
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.whiteColor,
              ),
              child: const Icon(
                CupertinoIcons.camera,
                size: 18,
                color: ColorPalette.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
