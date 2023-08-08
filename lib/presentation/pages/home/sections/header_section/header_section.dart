import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/header_section_mobile.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/header_section_web.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderSection extends StatelessWidget {
  final IntCallback hopButtonCallback;

  const HeaderSection({
    Key? key,
    required this.hopButtonCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      refinedBreakpoints: RefinedBreakpoints(),
      builder: (context, sizingInformation) {
        double screenWidth = sizingInformation.screenSize.width;
        if (screenWidth <= RefinedBreakpoints().tabletSmall) {
          return HeaderSectionMobile(hopButtonCallback: hopButtonCallback);
        } else {
          return HeaderSectionWeb(hopButtonCallback: hopButtonCallback);
        }
      },
    );
  }
}
