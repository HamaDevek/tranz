import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class StateCycleWidget extends StatefulWidget {
  const StateCycleWidget({
    super.key,
    required this.child,
    this.onInit,
    this.afterInit,
    this.onDispose,
  });

  final Widget child;
  final VoidCallback? onInit;
  final VoidCallback? afterInit;
  final VoidCallback? onDispose;

  @override
  State<StateCycleWidget> createState() => _StateCycleWidgetState();
}

class _StateCycleWidgetState extends State<StateCycleWidget> {
  @override
  void initState() {
    widget.onInit?.call();

    if (widget.afterInit != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.afterInit?.call();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }
}

extension StateCycleWidgetExtension on Widget {
  Widget onInit(VoidCallback onInit) {
    return StateCycleWidget(
      onInit: onInit,
      child: this,
    );
  }

  Widget afterInit(VoidCallback afterInit) {
    return StateCycleWidget(
      afterInit: afterInit,
      child: this,
    );
  }

  Widget onDispose(VoidCallback onDispose) {
    return StateCycleWidget(
      onDispose: onDispose,
      child: this,
    );
  }
}
