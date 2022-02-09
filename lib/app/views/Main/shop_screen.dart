import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/controllers/cart_controller.dart';
import '../../../app/controllers/category_api_controller.dart';
import '../../../app/controllers/item_api_controller.dart';
import '../../../app/models/item_model.dart';
import '../../../components/button_category_component.dart';
import '../../../components/no_glow_component.dart';
import '../../../components/shop/shop_card_component.dart';
import '../../../components/shop/shop_loading_component.dart';
import '../../../services/theme_service.dart';
import '../../../utils/extentions.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final CategoryApiController _categoryApiControllerController =
      Get.put(CategoryApiController());
  final ItemApiController _itemsController = Get.put(ItemApiController());
  final CartController _cartController = Get.put(CartController());

  String _isSelected = 'all';
  List<ItemModel>? _listItem;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlowComponent(),
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Text(
                      'items'.tr,
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
                  SizedBox(
                    height: 18,
                  ),
                  Obx(() {
                    if (_categoryApiControllerController.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(.5),
                                highlightColor: Colors.grey.withOpacity(.5),
                                child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(.5),
                                highlightColor: Colors.grey.withOpacity(.5),
                                child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 40,
                        child: ScrollConfiguration(
                          behavior: NoGlowComponent(),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Row(
                                  children: [
                                    ButtonCategoryComponent(
                                      text: 'all'.tr,
                                      isSelected: _isSelected == 'all',
                                      onPress: () {
                                        _isSelected = 'all';
                                        setState(() {
                                          _listItem = [
                                            ..._itemsController.items
                                          ];
                                        });
                                      },
                                    ),
                                    ButtonCategoryComponent(
                                      text: _categoryApiControllerController
                                              .category[index]
                                              .title?["x-lang".tr] ??
                                          "",
                                      isSelected: _isSelected ==
                                          '${_categoryApiControllerController.category[index].id}',
                                      onPress: () => _onClickCategory(
                                          _categoryApiControllerController
                                              .category[index].id),
                                    ),
                                  ],
                                );
                              } else {
                                return ButtonCategoryComponent(
                                  text: _categoryApiControllerController
                                      .category[index].name,
                                  isSelected: _isSelected ==
                                      '${_categoryApiControllerController.category[index].id}',
                                  onPress: () => _onClickCategory(
                                      _categoryApiControllerController
                                          .category[index].id),
                                );
                              }
                            },
                            itemCount: _categoryApiControllerController
                                .category.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: 16),
                  Expanded(
                    child: Obx(() {
                      if (_itemsController.isLoading.value) {
                        return GridView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.6),
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  mainAxisExtent: 230),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          itemBuilder: (BuildContext context, int index) {
                            return ShopLoadingComponent();
                          },
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _itemsController.onInit();
                            _categoryApiControllerController.onInit();
                          },
                          child: GridView.builder(
                            itemCount: _listItem?.length ??
                                _itemsController.items.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.6),
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    mainAxisExtent: 250),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            itemBuilder: (BuildContext context, int index) {
                              return ShopCardComponent(
                                item: _listItem?[index] ??
                                    _itemsController.items[index],
                              );
                            },
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Theme.of(context).primaryColor,
          // elevation: 0.0,
          child: Container(
            height: 50,
            width: 50,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.bag_2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return _cartController.cart.length <= 0
                      ? Container()
                      : Positioned(
                          top: 8,
                          right: 4,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                _cartController.cart.length >= 10
                                    ? '9+'
                                    : '${_cartController.cart.length}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                })
              ],
            ),
          ),
          onPressed: () {
            Get.toNamed('/cart');
          },
        ),
      ),
    );
  }

  _onClickCategory(id) {
    _listItem = [
      ..._itemsController.items.where((element) => element.category == id)
    ];
    setState(() {
      _isSelected = '$id';
    });
  }
}
