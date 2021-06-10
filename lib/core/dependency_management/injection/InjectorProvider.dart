import 'package:flutter/cupertino.dart';

import 'injector.dart';

class InjectorProvider extends InheritedWidget {
  final Injector injector;

  const InjectorProvider({
    @required this.injector,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static InjectorProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InjectorProvider>();
}
