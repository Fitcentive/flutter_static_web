import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter_static_web/presentation/widgets/content_area.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/custom_button_link.dart';
import 'package:flutter_static_web/presentation/widgets/custom_link.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<FooterItem> footerItems = [
  FooterItem(
    title: StringConst.EMAIL_US + ":",
    subtitle: StringConst.DEV_EMAIL_2,
    iconData: FontAwesomeIcons.paperPlane,
  ),
  FooterItem(
    title: StringConst.FOLLOW_ME_2 + ":",
    subtitle: StringConst.BEHANCE_ID,
    iconData: FontAwesomeIcons.instagram,
  ),
];

class FooterSection extends StatefulWidget {
  FooterSection({Key? key});
  @override
  _FooterSectionState createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? footerTextStyle = textTheme.caption?.copyWith(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    );
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidth = screenWidth;
    double contentAreaHeight = responsiveSize(
      context,
      screenHeight,
      screenHeight * 0.7,
      md: screenHeight * 0.85,
      sm: screenHeight * 0.85,
    );

    return ContentArea(
      padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
      child: Column(
        children: [
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;

              if (screenWidth <= (RefinedBreakpoints().tabletNormal)) {
                return _buildFooterSectionSm(
                  width: contentAreaWidth,
                  height: contentAreaHeight,
                );
              } else {
                return _buildFooterSectionLg(
                  width: contentAreaWidth,
                  height: contentAreaHeight,
                );
              }
            },
          ),
          SpaceH20(),
          InkWell(
            onTap: () => openUrlLink(StringConst.WEB_GENIUS_LAB_URL),
            child: RichText(
              text: TextSpan(
                text: StringConst.RIGHTS_RESERVED + " ",
                style: footerTextStyle,
                children: [],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SpaceH4(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child:RichText(
                    text: TextSpan(
                      text: StringConst.BUILT_BY,
                      style: footerTextStyle,
                      children: [],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SpaceH20(),
        ],
      ),
    );
  }

  List<Widget> _buildFooterItems(List<FooterItem> data,
      {bool isHorizontal = false}) {
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        FooterItem(
          title: data[index].title,
          subtitle: data[index].subtitle,
          iconData: data[index].iconData,
        ),
      );
      if (index < data.length - 1) {
        if (isHorizontal) {
          items.add(Spacer(flex: 2));
        } else {
          items.add(SpaceH40());
        }
      }
    }
    return items;
  }

  Widget _buildFooterSectionSm({
    required double width,
    required double height,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ContentArea(
      width: width,
      backgroundColor: AppColors.black400,
      borderRadius: const BorderRadius.all(
        Radius.circular(Sizes.RADIUS_8),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.RADIUS_8),
        ),
        child: Center(
          child: Column(
            children: [
              SpaceH80(),
              Text(
                StringConst.GET_IN_TOUCH,
                textAlign: TextAlign.center,
                style:
                    textTheme.headline4?.copyWith(color: AppColors.white),
              ),
              SpaceH60(),
              ..._buildFooterItems(footerItems),
              SpaceH60(),
              CustomButton(
                buttonTitle: StringConst.CONTACT_US,
                buttonColor: AppColors.orange1,
                onPressed: () {},
              ),
              SpaceH80(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSectionLg({
    required double width,
    required double height,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ContentArea(
      width: width,
      height: height,
      backgroundColor: AppColors.black400,
      borderRadius: const BorderRadius.all(
        Radius.circular(Sizes.RADIUS_8),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.RADIUS_8),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(flex: 2),
                Text(
                  StringConst.GET_IN_TOUCH,
                  style: textTheme.headline3?.copyWith(color: AppColors.white),
                ),
                const Spacer(),
                Text(
                  StringConst.GET_IN_TOUCH_DESC,
                  style: textTheme.headlineMedium?.copyWith(color: AppColors.white),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    ..._buildFooterItems(footerItems, isHorizontal: true),
                    const Spacer(flex: 3),
                  ],
                ),
                const Spacer(),
                const CustomButtonLink(
                  url: StringConst.EMAIL_URL,
                  buttonTitle: StringConst.CONTACT_US,
                  buttonColor: AppColors.orange1,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FooterItem extends StatelessWidget {
  FooterItem({
    required this.iconData,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(
          iconData,
          color: AppColors.orange1,
          size: Sizes.ICON_SIZE_36,
        ),
        SpaceH8(),
        Text(
          title,
          style: textTheme.subtitle1?.copyWith(
            color: AppColors.white,
          ),
        ),
        SpaceH8(),
        Text(
          subtitle,
          style: textTheme.bodyText1?.copyWith(
            color: AppColors.grey250,
          ),
        ),
      ],
    );
  }
}
