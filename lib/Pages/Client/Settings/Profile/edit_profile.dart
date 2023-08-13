import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    addressController.text = UserController.to.user?.value.user?.address ?? "";
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
                  Get.back(result: true);
                },
                confirmButtonColor: ColorPalette.yellow,
                confirmTextColor: ColorPalette.primary,
                cancelButtonColor: ColorPalette.primaryLight,
                bodyText: "Save changes before leaving?",
                confirmText: "Save",
                cancelText: "Don't Save",
              ).then((value) {
                if (value == true) {
                  if (TextFieldValidationController.instance.validate()) {
                    File? file;
                    if (_profileImage != null) {
                      file = File(_profileImage!.path);
                    }
                    UserController.to
                        .updateProfile(
                      name: nameController.text,
                      address: addressController.text,
                      image: file,
                    )
                        .then((res) {
                      print("RESPONSE: ${res.isSuccess}");
                      // UserController.to.me().then((value) {
                      if (res.isSuccess) {
                        _profileImage = null;
                        UserController.to
                            .isImageChanged(image: _profileImage?.path);
                        UserController.to
                            .isNameChanged(name: nameController.text);
                        UserController.to
                            .isAddressChanged(address: addressController.text);
                        Navigator.of(context).pop();
                      }
                    });
                  }
                } else {
                  Get.back();
                }
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
                imageUrl: UserController.to.user?.value.user?.image ?? "",
                profileImage: _profileImage,
                onProfileImageSelected: (file) {
                  _profileImage = file;

                  UserController.to.isImageChanged(image: file?.path);
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name must not be empty";
                } else if (value.length < 3) {
                  return "Name must be at least 3 characters";
                }
                return null;
              },
            ),
            AppSpacer.p16(),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  side: const BorderSide(
                    color: ColorPalette.greyText,
                    width: 1,
                  ),
                ),
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      phoneController.text,
                      style: TextWidget.textStyleCurrent.copyWith(
                        color: ColorPalette.greyText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacer.p16(),
            TextFieldWidget(
              controller: addressController,
              hintText: "Address",
              onChanged: (value) {
                UserController.to.isAddressChanged(address: value);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Address must not be empty";
                } else if (value.length < 5) {
                  return "Address must be at least 5 characters";
                }
                return null;
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        persistentFooterButtons: [
          RequestButtonWidget(
            disabled: UserController.to.isProfileInfoChanged.value == false,
            width: screenWidth(context),
            onPressed: () async {
              if (TextFieldValidationController.instance.validate()) {
                File? file;
                if (_profileImage != null) {
                  file = File(_profileImage!.path);
                }
                final res = await UserController.to.updateProfile(
                  name: nameController.text,
                  address: addressController.text,
                  image: file,
                );
                if (res.isSuccess) {
                  // await UserController.to.me();

                  setState(() {
                    _profileImage = null;
                    UserController.to
                        .isImageChanged(image: _profileImage?.path);
                    UserController.to.isNameChanged(name: nameController.text);
                    UserController.to
                        .isAddressChanged(address: addressController.text);
                  });
                }
              }
            },
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
    this.profileImage,
  });
  final Function(XFile? file) onProfileImageSelected;
  final String imageUrl;
  final XFile? profileImage;

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  XFile? _profileImage;

  // @override
  // void initState() {
  //   super.initState();
  //   _profileImage = widget.profileImage;
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
            imageFile: widget.profileImage != null
                ? File(widget.profileImage!.path)
                : null,
            imageUrl: widget.imageUrl,
            height: screenWidth(context) * .3,
            width: screenWidth(context) * .3,
            isCircle: true,
            border: Border.all(
              color: ColorPalette.whiteColor,
              width: 1,
            ),
            placeholder: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorPalette.whiteColor,
                  width: 1,
                ),
              ),
              child: const Icon(
                CupertinoIcons.person_solid,
                size: 70,
                color: ColorPalette.whiteColor,
              ),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              if (_profileImage != null) {
                setState(() {
                  _profileImage = null;
                  widget.onProfileImageSelected.call(null);
                });
              } else {
                ImagePicker()
                    .pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 512,
                  maxWidth: 512,
                  imageQuality: 90,
                )
                    .then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        _profileImage = value;
                        widget.onProfileImageSelected.call(_profileImage!);
                      });
                    }
                  },
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.whiteColor,
              ),
              child: widget.profileImage == null
                  ? const Icon(
                      CupertinoIcons.camera,
                      size: 18,
                      color: ColorPalette.primary,
                    )
                  : const Icon(
                      CupertinoIcons.clear,
                      size: 18,
                      color: ColorPalette.red,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
