import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/social_button_2.dart';
import 'package:flutter_static_web/presentation/widgets/content_area.dart';
import 'package:flutter_static_web/presentation/widgets/empty.dart';
import 'package:flutter_static_web/presentation/widgets/custom_info_section.dart';
import 'package:flutter_static_web/presentation/widgets/custom_link.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kSpacingSm = 40.0;
const double kRunSpacingSm = 24.0;
const double kSpacingLg = 24.0;
const double kRunSpacingLg = 16.0;

class PricingSection extends StatefulWidget {
  PricingSection({Key? key});
  @override
  _PricingSectionState createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection>
    with TickerProviderStateMixin {
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
      key: const Key('pricing-section'),
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
                    child: _buildComparisonTable(
                      width: contentAreaWidthSm,
                      height: contentAreaHeightSm,
                    ),
                  ),
                  SpaceH40(),
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildPricingSection(
                      width: contentAreaWidthSm,
                      height: screenHeight,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildComparisonTable(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildPricingSection(
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
        // NimBusLink(
        //   url: data[index].url,
        //   child: SocialButton2(
        //     width: width,
        //     title: data[index].title.toUpperCase(),
        //     iconData: data[index].iconData,
        //     onPressed: () {},
        //     titleColor: data[index].titleColor,
        //     buttonColor: data[index].buttonColor,
        //     iconColor: data[index].iconColor,
        //   ),
        // ),
      );
    }
    return items;
  }

  Widget _buildComparisonTable({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    double fontSizeTableHeader = responsiveSize(context, 18, 26);
    double fontSizeTableLeading = responsiveSize(context, 14, 18);
    double fontSizeTableData = responsiveSize(context, 12, 16);
    TextStyle? titleStyle = textTheme.bodyText1?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );
    TextStyle tableDataStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTableLeading);
    TextStyle tableDataValueStyle = TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: fontSizeTableLeading);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: DataTable(
        columnSpacing: 10,
        dataRowMinHeight: 45,
        dataRowMaxHeight: 60,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Feature',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTableHeader),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Freemium',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTableHeader),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Fitcentive+',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTableHeader),
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Unlimited social media posts', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Unlimited nutrition tracking', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Unlimited exercise tracking', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ]
          ),
          DataRow(
            cells: [
              DataCell(Text('Progress tracking', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Achievements tracking', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Direct messaging', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Social feed', style: tableDataStyle,)),
              _iconCheck(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Ads', style: tableDataStyle,)),
              _iconCheck(),
              _iconCross(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Meetup reminders', style: tableDataStyle,)),
              _iconCross(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Weight log reminders', style: tableDataStyle,)),
              _iconCross(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Unlimited user discovery', style: tableDataStyle,)),
              _iconCrossWithText("Max 5 per month", tableDataValueStyle),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Unlimited meetups', style: tableDataStyle,)),
              _iconCrossWithText("Max 5 per month", tableDataValueStyle),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Multi person meetups', style: tableDataStyle,)),
              _iconCross(),
              _iconCheck(),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Group chats', style: tableDataStyle,)),
              _iconCross(),
              _iconCheck(),
            ],
          ),
        ],
      ),
    );
  }

  DataCell _iconCheck() => DataCell(
      CircleAvatar(
        radius: 15,
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
            image: DecorationImage(
                image: AssetImage("assets/images/icon_check.png")
            ),
          ),
        ),
      )
  );

  DataCell _iconCross() => DataCell(
      CircleAvatar(
        radius: 15,
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.redAccent,
            image: DecorationImage(
                image: AssetImage("assets/images/icon_cross.png")
            ),
          ),
        ),
      )
  );

  DataCell _iconCrossWithText(String text, TextStyle tableDataValueStyle) => DataCell(
      Row(
        children: [
          CircleAvatar(
            radius: 15,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
                image: DecorationImage(
                    image: AssetImage("assets/images/icon_cross.png")
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: tableDataValueStyle,
          )
        ],
      )
  );

  Widget _buildPricingSection({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
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
                sectionTitle: StringConst.PRICING_SECTION,
                title1: StringConst.PRICING_HEADING_1,
                hasTitle2: false,
                body: StringConst.PRICING_DESC,
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
