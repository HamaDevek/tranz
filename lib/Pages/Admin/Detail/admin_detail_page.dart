import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranzhouse/Models/admin_order_model.dart';
import 'package:tranzhouse/Models/services_model.dart';
import 'package:tranzhouse/Pages/Admin/Detail/reject_bottomsheet.dart';
import 'package:tranzhouse/Widgets/Buttons/request_button.dart';
import 'package:tranzhouse/Widgets/Containers/Image_gallery_widget.dart';
import 'package:tranzhouse/Widgets/Other/appbar_widget.dart';

import '../../../Getx/Controllers/admin_controller.dart';
import '../../../Theme/theme.dart';
import '../../../Utility/utility.dart';
import '../../../Widgets/Modal/confirmation_modal.dart';
import '../../../Widgets/Other/app_spacer.dart';

class AmdinOrderDetailPage extends StatefulWidget {
  const AmdinOrderDetailPage({super.key});
  static const String routeName = "/admin-order-detail";

  @override
  State<AmdinOrderDetailPage> createState() => _AmdinOrderDetailPageState();
}

class _AmdinOrderDetailPageState extends State<AmdinOrderDetailPage> {
  AdminOrderModel? order;
  String tempStatus = "";

  @override
  void initState() {
    super.initState();
    order = Get.arguments['order'] as AdminOrderModel;
    tempStatus = Get.arguments['status'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageTitle: "Order Details",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacer.p20(),
            ImageGalleryWidgetState(
              imagesUrl: order?.service?.images ?? [],
              title: getText(
                order?.service?.title ?? LanguagesModel(en: "", ar: "", ku: ""),
              ),
              description: getText(
                order?.service?.description ??
                    LanguagesModel(en: "", ar: "", ku: ""),
              ),
              category: order?.owner?.name ?? '',
              date: order?.createdAt ?? DateTime.now(),
              text: "Ordered on",
            ),
            AppSpacer.p20(),
          ],
        ),
      ),
      bottomNavigationBar: order?.status == "accept" ||
              order?.status == "rejected"
          ? const SizedBox()
          : UnconstrainedBox(
              child: Container(
                width: screenWidth(context),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: ColorPalette.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RequestButtonWidget(
                            height: screenWidth(context) * .1,
                            verticalPadding: 0,
                            color: ColorPalette.red,
                            textColor: ColorPalette.whiteColor,
                            text: "Decline",
                            onPressed: () async {
                              // String note = "";
                              DeclineBottomsheetWidget.show(
                                onDeclinePressed: (note) async {
                                  final value =
                                      await ConfirmationDialogWidget.show(
                                    context,
                                    onConfirmed: () async {
                                      Get.back(result: true);
                                    },
                                    bodyText:
                                        "Are you sure you want to decline this order?",
                                  );
                                  if (value != null && value) {
                                    await AdminController.to
                                        .acceptOrRejectOrder(
                                      orderId: order?.id ?? '',
                                      status: "rejected",
                                      note: note,
                                    )
                                        .then((res) {
                                      if (res.isSuccess) {
                                        order?.status = "rejected";
                                        if (tempStatus.isNotEmpty) {
                                          AdminController.to
                                              .filterOrdersByStatus(tempStatus);
                                        }
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      }
                                    });
                                  }
                                  // Get.back(result: true);
                                },
                              );
                            },
                          ),
                        ),
                        AppSpacer.p16(),
                        Expanded(
                          child: RequestButtonWidget(
                            height: screenWidth(context) * .1,
                            verticalPadding: 0,
                            color: ColorPalette.green,
                            textColor: ColorPalette.primary,
                            text: "accept",
                            onPressed: () async {
                              final value = await ConfirmationDialogWidget.show(
                                context,
                                onConfirmed: () async {
                                  Get.back(result: true);
                                },
                                bodyText:
                                    "Are you sure you want to accept this order?",
                              );
                              if (value != null && value == true) {
                                final res = await AdminController.to
                                    .acceptOrRejectOrder(
                                  orderId: order?.id ?? '',
                                  status: "accept",
                                  note: '',
                                );
                                if (res.isSuccess) {
                                  order?.status = "accept";
                                  if (tempStatus.isNotEmpty) {
                                    AdminController.to
                                        .filterOrdersByStatus(tempStatus);
                                  }
                                  setState(() {});
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
