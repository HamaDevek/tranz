import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../app/models/cart_api_model.dart';
import '../../../utils/utils.dart';
import '../../../app/controllers/cart_controller.dart';
import '../../../app/controllers/city_api_controller.dart';
import '../../../app/models/city_model.dart';
import '../../../components/cart/cart_all_total_contract.dart';
import '../../../components/textfield_custom_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class CartFinishScreen extends StatefulWidget {
  const CartFinishScreen({Key? key}) : super(key: key);

  @override
  _CartFinishScreenState createState() => _CartFinishScreenState();
}

class _CartFinishScreenState extends State<CartFinishScreen> {
  final CartController _cartController = Get.put(CartController());
  final CityApiController _cityApiController =
      Get.find<CityApiController>(tag: 'city');
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late CityModel selectedCity;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime.now().add(Duration(days: 30)),
  //     cancelText: 'cancel'.tr,
  //     confirmText: 'ok'.tr,
  //     helpText: "select.date".tr,
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: Theme.of(context).colorScheme.copyWith(
  //                 brightness: Brightness.light,
  //                 onPrimary: Colors.black,
  //               ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: !ThemeService().isSavedDarkMode()
  //                   ? Colors.black
  //                   : Theme.of(context).primaryColor,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  // Future<void> _selectTime(BuildContext context) async {
  //   Future<TimeOfDay?> selectedTime24Hour = showTimePicker(
  //     context: context,
  //     cancelText: 'cancel'.tr,
  //     confirmText: 'ok'.tr,
  //     initialEntryMode: TimePickerEntryMode.dial,
  //     initialTime: const TimeOfDay(hour: 10, minute: 47),
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //         child: Theme(
  //           data: Theme.of(context).copyWith(
  //             colorScheme: Theme.of(context).colorScheme.copyWith(
  //                   brightness: Brightness.light,
  //                   onPrimary: Colors.black,
  //                 ),
  //             textButtonTheme: TextButtonThemeData(
  //               style: TextButton.styleFrom(
  //                 primary: !ThemeService().isSavedDarkMode()
  //                     ? Colors.black
  //                     : Theme.of(context).primaryColor,
  //               ),
  //             ),
  //           ),
  //           child: child!,
  //         ),
  //       );
  //     },
  //   );
  // }

  TextEditingController? _nameController, _addressController, _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    selectedCity = _cityApiController.cities[0];
    _cartController.fee.value = selectedCity.deliveryPrice!;
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _addressController?.dispose();
    _phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       margin:
                  //           EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  //       child: Text(
                  //         'cart.city'.tr,
                  //         textAlign: 'language.rtl'.tr.parseBool
                  //             ? TextAlign.right
                  //             : TextAlign.left,
                  //         style: TextStyle(
                  //           fontFamily:
                  //               'language.rtl'.tr.parseBool ? "Rabar" : "",
                  //           fontSize: 24,
                  //           color: !ThemeService().isSavedDarkMode()
                  //               ? Color(0xFF1E272E)
                  //               : Colors.white,
                  //         ),
                  //         overflow: TextOverflow.fade,
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Text(
                          'cart.info'.tr,
                          textAlign: 'language.rtl'.tr.parseBool
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                                'language.rtl'.tr.parseBool ? "Rabar" : "",
                            fontSize: 24,
                            color: !ThemeService().isSavedDarkMode()
                                ? Color(0xFF1E272E)
                                : Colors.white,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  TextfieldCustomComponent(
                      hintText: 'name'.tr, controller: _nameController),
                  SizedBox(height: 16),
                  TextfieldCustomComponent(
                      hintText: 'phone'.tr,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone),
                  SizedBox(height: 16),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeService().isSavedDarkMode()
                            ? Color(0xFF292D32)
                            : Colors.grey.shade300,
                      ),
                      child: Obx(() {
                        if (_cityApiController.isLoading.value ||
                            _cityApiController.cities.length == 0) {
                          return Text('Empty');
                        } else {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<CityModel>(
                              isExpanded: true,
                              value: selectedCity,
                              iconEnabledColor: Colors.transparent,
                              iconDisabledColor: Colors.transparent,
                              items: _cityApiController.cities
                                  .map((CityModel city) {
                                return DropdownMenuItem<CityModel>(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      "${city.name ?? ""}",
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
                                  value: city,
                                );
                              }).toList(),
                              onChanged: (city) {
                                setState(() {
                                  selectedCity = city!;
                                  _cartController.fee.value =
                                      city.deliveryPrice!;
                                });
                              },
                            ),
                          );
                        }
                      })),
                  SizedBox(height: 16),

                  TextfieldCustomComponent(
                      hintText: 'address'.tr, controller: _addressController),
                  SizedBox(height: 16),
                  // TextfieldCustomComponent(
                  //   readOnly: true,
                  //   hintText: 'address.onmap'.tr,
                  //   controller: _phoneController,
                  //   suffixIcon: Icon(Iconsax.gps),
                  //   onTap: () {
                  //   },
                  // ),
                  // SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextfieldCustomComponent(
                  //           hintText: 'cart.date'.tr,
                  //           readOnly: true,
                  //           onTap: () {
                  //             _selectDate(context);
                  //           },
                  //           controller: _phoneController),
                  //     ),
                  //     Expanded(
                  //       child: TextfieldCustomComponent(
                  //         hintText: 'cart.time'.tr,
                  //         controller: _phoneController,
                  //         readOnly: true,
                  //         onTap: () {
                  //           _selectTime(context);
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 250 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
            Container(
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
                        Expanded(
                          child: Container(
                            child: Text(
                              'finish.transaction'.tr,
                              textAlign: 'language.rtl'.tr.parseBool
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: TextStyle(
                                fontFamily:
                                    'language.rtl'.tr.parseBool ? "Rabar" : "",
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
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            'language.rtl'.tr.parseBool
                                ? Iconsax.arrow_left_2
                                : Iconsax.arrow_right_3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CartAllTotalComponent(
                  onPress: _onPressBuy,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _onPressBuy() async {
    final itemList = _cartController.cart
        .map((e) => Item(
            name: e.name,
            barcode: e.barcode,
            quantity: e.amount.toString(),
            price: e.sellingPrice.toString(),
            totalPrice: (e.amount * e.sellingPrice).toString(),
            currency: 'iqd'))
        .toList();
    itemList.add(Item(
        name: 'delivery',
        barcode: 'delivery',
        quantity: '1',
        price: '${_cartController.fee}',
        totalPrice: '${_cartController.fee}',
        currency: 'iqd'));
    final totlPrice = (_cartController.total.value.toInt() +
        _cartController.fee.value.toInt());
    final totalPriceObject =
        TotalPrice(amount: totlPrice, totalInvoiceBalance: totlPrice);
    final versionobject = Version(
        totalPrice: totalPriceObject,
        items: itemList,
        note: '${selectedCity.name}~${_addressController!.value.text}');

    if (_nameController!.value.text.length >= 3 &&
        _addressController!.value.text.length >= 3 &&
        _phoneController!.value.text.isPhoneNumber) {
      if (this.mounted) {
        var order = CartApiModel(
            traderName: _nameController!.value.text,
            quickCustomerName: _nameController!.value.text,
            quickCustomerPhone: _phoneController!.value.text,
            versions: [versionobject],
            createdBy: await getDeviceIdentifier());

        bool isSend = await _cartController.sendOrderRequest(order);
        if (isSend) {
          _nameController!.text = '';
          _addressController!.text = '';
          _phoneController!.text = '';
          _cartController.deleteAllCartList();
        }
      }
    }
  }
}
