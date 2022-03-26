import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ServiceLoadingComponent extends StatelessWidget {
  const ServiceLoadingComponent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.secondary.withOpacity(.5),
      highlightColor: Colors.grey.withOpacity(.5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
