
import 'package:e_attendance/core/theme/app_dimensions.dart';
import 'package:e_attendance/presentation/features/common/connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:smart_responsive/smart_responsive.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  AppDimensions.contentPadding,
      child: ConnnectivityWidget(
        child: SmartResponsive(
          mobile: child,
          tablet: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(width: deviceWidth * 0.2, height: deviceHeight),
                    child,
                    SizedBox(width: deviceWidth * 0.2, height: deviceHeight),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(width: deviceWidth * 0.3, height: deviceHeight),
                    child,
                    SizedBox(width: deviceWidth * 0.3, height: deviceHeight),
                  ],
                );
              }
            },
          ),
          desktop: child,
        ),
      ),
    );
  }
}
