import 'dart:math';

import 'package:flutter/material.dart';
import 'package:web3modal_flutter/theme/constants.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final isPortrait = orientation == Orientation.portrait;
            final realMaxHeight =
                isPortrait ? screenHeight - (kNavbarHeight * 2) : screenHeight;
            final realMinHeight = isPortrait ? 0.0 : realMaxHeight;
            return ResponsiveData(
              maxHeight: realMaxHeight,
              minHeight: realMinHeight,
              maxWidth: screenWidth,
              minWidth: screenWidth,
              orientation: orientation,
              child: child,
            );
          },
        );
      },
    );
  }
}

class ResponsiveData extends InheritedWidget {
  const ResponsiveData({
    super.key,
    required this.maxHeight,
    required this.minHeight,
    required this.maxWidth,
    required this.minWidth,
    required this.orientation,
    required super.child,
  });
  final double maxHeight, minHeight, maxWidth, minWidth;
  final Orientation orientation;

  static ResponsiveData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveData>();
  }

  static ResponsiveData of(BuildContext context) {
    final ResponsiveData? result = maybeOf(context);
    assert(result != null, 'No ResponsiveContainer found in context');
    return result!;
  }

  static double maxHeightOf(BuildContext context) {
    final container = maybeOf(context);
    return min(
      (container?.maxHeight ?? MediaQuery.of(context).size.height),
      900,
    );
  }

  static double minHeightOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.minHeight ?? MediaQuery.of(context).size.height);
  }

  static double maxWidthOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.maxWidth ?? MediaQuery.of(context).size.width);
  }

  static double minWidthOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.minWidth ?? MediaQuery.of(context).size.width);
  }

  static double paddingBottomOf(BuildContext context) {
    return MediaQuery.of(context).padding.bottom + kPadding6;
  }

  static bool isPortrait(BuildContext context) {
    final container = maybeOf(context);
    return container?.orientation.isPortrait ?? false;
  }

  static int gridAxisCountOf(BuildContext context) {
    final isPortraitMode = isPortrait(context);
    return isPortraitMode ? kGridAxisCountP : kGridAxisCountL;
  }

  static bool _isBigScreen(BuildContext context) {
    final data = MediaQueryData.fromView(View.of(context));
    return data.size.shortestSide < 600 ? false : true;
  }

  static Size gridItemSzieOf(BuildContext context) {
    final isPortraitMode = isPortrait(context);
    if (isPortraitMode && !_isBigScreen(context)) {
      final width = (maxWidthOf(context) / 4) - (kGridAxisSpacing) - 4.0;
      return Size(width, width * 1.26);
    }
    final width = (maxWidthOf(context) / 6) - kGridAxisSpacing;
    return Size(width, width * 1.26);
  }

  @override
  bool updateShouldNotify(ResponsiveData oldWidget) => true;
}

extension on Orientation {
  bool get isPortrait => this == Orientation.portrait;
}
