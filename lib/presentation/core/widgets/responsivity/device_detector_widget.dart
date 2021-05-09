import 'package:flutter/material.dart';

/// Enums for different screen sizes
enum DeviceScreenType { Mobile, Tablet }

/// GetDeviceType Function
/// This is where we define our screen widths for different layouts
DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  var orientation = mediaQueryData.orientation;

  var deviceWidth = 0.0;

  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQueryData.size.height;
  } else {
    deviceWidth = mediaQueryData.size.width;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}

class SizeInfo {
  // MediaQueryData mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  double _safeAreaHorizontal;
  double _safeAreaVertical;
  double safeBlockHorizontal;
  double safeBlockVertical;

  SizeInfo({
    @required MediaQueryData mediaQueryData,
  }) {
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

/// Sizing Information
class SizingInformation {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final EdgeInsets safeAreaPadding;
  final Size screenSize;
  final Size blockUnit;

  SizingInformation({
    this.orientation,
    this.deviceScreenType,
    this.screenSize,
    this.blockUnit,
    this.safeAreaPadding,
  });
}

class OrientationLayout extends StatelessWidget {
  final Widget landscape;
  final Widget portrait;

  OrientationLayout({Key key, this.landscape, this.portrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape ?? portrait;
    }

    return portrait;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation size,
  ) builder;

  final safeAreaActive;

  const ResponsiveBuilder({
    Key key,
    this.builder,
    this.safeAreaActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final sizeInfo = SizeInfo(mediaQueryData: mediaQuery);
    final sizingInformation = SizingInformation(
      orientation: mediaQuery.orientation,
      deviceScreenType: getDeviceType(mediaQuery),
      safeAreaPadding: mediaQuery.padding,
      screenSize: Size(
        sizeInfo.screenWidth,
        sizeInfo.screenHeight,
      ),
      blockUnit: Size(
        safeAreaActive
            ? sizeInfo.safeBlockHorizontal
            : sizeInfo.blockSizeHorizontal,
        safeAreaActive
            ? sizeInfo.safeBlockVertical
            : sizeInfo.blockSizeVertical,
      ),
    );
    return safeAreaActive
        ? SafeArea(
            child: builder(
              context,
              sizingInformation,
            ),
          )
        : builder(context, sizingInformation);
  }
}

class DeviceLayoutSelector extends StatelessWidget {
  final safeAreaActive;
  final Widget Function(BuildContext buildContext, SizingInformation size)
      mobileBuilder;
  final Widget Function(BuildContext buildContext, SizingInformation size)
      tabletBuilder;

  const DeviceLayoutSelector({
    Key key,
    @required this.mobileBuilder,
    this.tabletBuilder,
    this.safeAreaActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet &&
            tabletBuilder != null) {
          return tabletBuilder(context, sizingInformation);
        }

        return mobileBuilder(context, sizingInformation);
      },
      safeAreaActive: safeAreaActive,
    );
  }
}
