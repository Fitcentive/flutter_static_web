import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/social_button_2.dart';
import 'package:flutter_static_web/presentation/widgets/content_area.dart';
import 'package:flutter_static_web/presentation/widgets/custom_info_section.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kRunSpacing = 20.0;
const double kMainAxisSpacing = 16.0;
const double kCrossAxisSpacing = 16.0;
const double kSpacingSm = 40.0;
const double kRunSpacingSm = 24.0;
const double kSpacingLg = 24.0;
const double kRunSpacingLg = 16.0;

class MeetupSection extends StatefulWidget {
  MeetupSection({Key? key});
  @override
  _MeetupSectionState createState() => _MeetupSectionState();
}

class _MeetupSectionState extends State<MeetupSection> with TickerProviderStateMixin {

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _fadeInController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeInController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeInController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - getSidePadding(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.0;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 0.5;
    return VisibilityDetector(
      key: Key('meetup-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          _scaleController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: getSidePadding(context)),
        child: ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
              return Column(
                children: [
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildMeetupSection(
                      width: contentAreaWidthSm,
                      height: screenHeight,
                    ),
                  ),
                  SpaceH40(),
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildImage(
                      width: contentAreaWidthSm,
                      height: contentAreaHeightSm,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildMeetupSection(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildImage(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),

                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildSocialButtons(
      List<SocialButton2Data> data, {
        double? width,
      }) {
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        SocialButton2(
          width: width,
          title: data[index].title.toUpperCase(),
          iconData: data[index].iconData,
          onPressed: () => openUrlLink(data[index].url),
          titleColor: data[index].titleColor,
          buttonColor: data[index].buttonColor,
          iconColor: data[index].iconColor,
        ),
      );
    }
    return items;
  }

  Widget _buildImage({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodyText1?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
        Stack(
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                ImagePath.MEETUP_HEADER,
                width: width * 0.95,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMeetupSection({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
        //positions blob on the far right of the section
        //based on the calculation only 10% of blob is showing
        ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
              return nimbusInfoSectionSm(width: width);
            } else {
              //This container takes 85% of the space and leave 15% as spacing
              //between the blob and the content
              return Container(
                width: width * 0.85,
                child: nimbusInfoSectionLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget nimbusInfoSectionLg() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInfoSection1(
                sectionTitle: StringConst.MEETUP_SECTION,
                title1: StringConst.STAY_ACTIVE,
                title2: StringConst.TOGETHER,
                body: StringConst.STAY_ACTIVE_DESC,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget nimbusInfoSectionSm({required double width}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CustomInfoSection2(
      sectionTitle: StringConst.DISCOVER_HEADING,
      title1: StringConst.FIND_BUDDIES,
      title2: StringConst.WITH_SIMILAR_INTERESTS,
      body: StringConst.DISCOVER_DESCRIPTION,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConst.FOLLOW_ME_1,
            style: textTheme.headline6?.copyWith(color: AppColors.black),
          ),
          SpaceH16(),
          Wrap(
            spacing: kSpacingSm,
            runSpacing: kRunSpacingSm,
            children: _buildSocialButtons(Data.socialData2),
          ),
        ],
      ),
    );
  }
}
