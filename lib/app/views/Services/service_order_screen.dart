import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../components/button_custom_component.dart';
import '../../../utils/config.dart';
import '../../../utils/utils.dart';
import '../../../app/controllers/service_api_controller.dart';
import '../../../app/models/service_api_model.dart';
import '../../../app/models/service_model.dart';
import '../../../app/controllers/city_api_controller.dart';
import '../../../app/models/city_model.dart';
import '../../../components/textfield_custom_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class ServiceOrderScreen extends StatefulWidget {
  const ServiceOrderScreen({Key? key}) : super(key: key);

  @override
  _ServiceOrderScreenState createState() => _ServiceOrderScreenState();
}

class _ServiceOrderScreenState extends State<ServiceOrderScreen> {
  final CityApiController _cityApiController =
      Get.find<CityApiController>(tag: 'city');
  final ServiceApiController _serviceApiController =
      Get.find<ServiceApiController>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late CityModel selectedCity;
  late ServiceModel service;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      cancelText: 'cancel'.tr,
      confirmText: 'ok'.tr,
      helpText: "select.date".tr,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  brightness: Brightness.light,
                  onPrimary: Colors.black,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: !ThemeService().isSavedDarkMode()
                    ? Colors.black
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        var formatter = new DateFormat('yyyy-MM-dd');
        selectedDate = picked;
        _dateController?.text = formatter.format(selectedDate);
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    var selectedTime24Hour = await showTimePicker(
      context: context,
      cancelText: 'cancel'.tr,
      confirmText: 'ok'.tr,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    brightness: Brightness.light,
                    onPrimary: Colors.black,
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: !ThemeService().isSavedDarkMode()
                      ? Colors.black
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (selectedTime24Hour != null) {
      print(selectedTime24Hour.format(context));
      DateTime parsedTime =
          DateFormat.jm().parse(selectedTime24Hour.format(context).toString());
      String formattedTime = DateFormat('HH:mm a').format(parsedTime);
      _timeController?.text = formattedTime;
    }
  }

  TextEditingController? _nameController,
      _addressController,
      _phoneController,
      _timeController,
      _dateController;

  @override
  void initState() {
    super.initState();
    service = Get.arguments;
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _timeController = TextEditingController();
    _dateController = TextEditingController();
    selectedCity = _cityApiController.cities[0];
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
                                        fontFamily: 'language.rtl'.tr.parseBool
                                            ? "Rabar"
                                            : "",
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
                                });
                              },
                            ),
                          );
                        }
                      })),
                  SizedBox(height: 16),
                  TextfieldCustomComponent(
                      hintText: 'address'.tr, controller: _addressController),
                  // SizedBox(height: 16),
                  // TextfieldCustomComponent(
                  //   readOnly: true,
                  //   hintText: 'address.onmap'.tr,
                  //   controller: _phoneController,
                  //   suffixIcon: Icon(Iconsax.gps),
                  //   onTap: () {
                  //   },
                  // ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextfieldCustomComponent(
                            hintText: 'cart.date'.tr,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            controller: _dateController),
                      ),
                      Expanded(
                        child: TextfieldCustomComponent(
                          hintText: 'cart.time'.tr,
                          controller: _timeController,
                          readOnly: true,
                          onTap: () {
                            _selectTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: ButtonCustomComponent(
                        child: Text(
                          'services.order'.tr,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1E272E),
                            fontFamily:
                                'language.rtl'.tr.parseBool ? 'Rabar' : '',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPress: () async {
                          if (!_serviceApiController.isLoadingSend.value) {
                            await _serviceApiController
                                .sendServiceReuqest(ServiceApiModel(
                                    name: _nameController!.value.text,
                                    phone: _phoneController!.value.text,
                                    address: _addressController!.value.text,
                                    info: {
                                      'city': selectedCity.name,
                                      'date': _dateController!.value.text,
                                      'time': _timeController!.value.text,
                                    },
                                    message: '',
                                    imei: await getDeviceIdentifier(),
                                    branch: ConfigApp.branchAccess,
                                    type: 'service'));
                          }
                        }),
                  )
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
                              'services.order'.tr,
                              textAlign: 'language.rtl'.tr.parseBool
                                  ? TextAlign.left
                                  : TextAlign.right,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
