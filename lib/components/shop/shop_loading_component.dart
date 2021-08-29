import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShopLoadingComponent extends StatelessWidget {
  const ShopLoadingComponent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).accentColor.withOpacity(.5),
      highlightColor: Colors.grey.withOpacity(.5),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('test'),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
