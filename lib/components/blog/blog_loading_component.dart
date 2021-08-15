import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BlogLoadingComponent extends StatelessWidget {
  const BlogLoadingComponent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).accentColor.withOpacity(.5),
        highlightColor: Colors.grey.withOpacity(.5),
        child: Container(
          height: 365,
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
                  height: 160,
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
      ),
    );
  }
}
