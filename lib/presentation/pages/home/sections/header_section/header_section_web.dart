import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/widgets.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/social_button_2.dart';
import 'package:flutter_static_web/presentation/widgets/content_area.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/custom_button_link.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double socialTextSizeLg = 18.0;
const double socialTextSizeSm = 14.0;
// const double sidePadding = Sizes.PADDING_16;

class HeaderSectionWeb extends StatefulWidget {
  final IntCallback hopButtonCallback;

  const HeaderSectionWeb({
    required this.hopButtonCallback
  });

  @override
  _HeaderSectionWebState createState() => _HeaderSectionWebState();
}

class _HeaderSectionWebState extends State<HeaderSectionWeb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _controller.forward();
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_24,
      Sizes.TEXT_SIZE_56,
      md: Sizes.TEXT_SIZE_36,
    );
    double bodyTextSize =
        responsiveSize(context, bodyTextSizeSm, bodyTextSizeLg);
    double socialTextSize =
        responsiveSize(context, socialTextSizeSm, socialTextSizeLg);
    double screenWidth = widthOfScreen(context);
    double contentAreaWidth = screenWidth;
    TextStyle? bodyTextStyle =
        textTheme.bodyText1?.copyWith(fontSize: bodyTextSize);
    TextStyle? socialTitleStyle =
        textTheme.subtitle1?.copyWith(fontSize: socialTextSize);

    List<Widget> cardsForTabletView = buildCardRow(
      context: context,
      data: Data.nimbusCardData,
      dataCallback: widget.hopButtonCallback,
      width: contentAreaWidth * 0.4,
      isWrap: true,
    );
    double buttonWidth = responsiveSize(
      context,
      80,
      150,
    );
    double buttonHeight = responsiveSize(
      context,
      48,
      60,
      md: 54,
    );

    double sizeOfBlobSm = screenWidth * 0.3;
    double sizeOfGoldenGlobe = screenWidth * 0.2;
    double dottedGoldenGlobeOffset = sizeOfBlobSm * 0.4;
    double heightOfBlobAndGlobe =
        computeHeight(dottedGoldenGlobeOffset, sizeOfGoldenGlobe, sizeOfBlobSm);
    double heightOfStack = heightOfBlobAndGlobe * 1.66;
    double blobOffset = heightOfStack * 0.3;
    return ContentArea(
      child: Stack(
        children: [
          Container(
            height: heightOfStack,
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  child: HeaderImage(
                    controller: _controller,
                    globeSize: sizeOfGoldenGlobe,
                    imageHeight: heightOfStack,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: heightOfStack * 0.2,
                    left: (sizeOfBlobSm * 0.35)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: screenWidth),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                StringConst.FIND_YOUR,
                                speed: Duration(milliseconds: 60),
                                textStyle: textTheme.headline2?.copyWith(
                                  fontSize: headerIntroTextSize,
                                  color: Colors.white
                                ),
                              ),
                            ],
                            onTap: () {},
                            isRepeatingAnimation: false,
                            totalRepeatCount: 5,
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: screenWidth),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                StringConst.INCENTIVE,
                                speed: Duration(milliseconds: 60),
                                textStyle: textTheme.headline2?.copyWith(
                                    fontSize: headerIntroTextSize,
                                    color: AppColors.orange1
                                ),
                              ),
                            ],
                            onTap: () {},
                            isRepeatingAnimation: false,
                            totalRepeatCount: 5,
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                          BoxConstraints(maxWidth: screenWidth),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                StringConst.TO_KEEP_FIT,
                                speed: Duration(milliseconds: 60),
                                textStyle: textTheme.headline2?.copyWith(
                                    fontSize: headerIntroTextSize,
                                    color: AppColors.white
                                ),
                              ),
                            ],
                            onTap: () {},
                            isRepeatingAnimation: false,
                            totalRepeatCount: 5,
                          ),
                        ),
                        SpaceH16(),
                        Column(
                          children: [
                            Row(
                              children: [
                                CustomButton(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  buttonTitle: StringConst.GET_STARTED,
                                  buttonColor: AppColors.orange1,
                                  onPressed: () {
                                    openUrlLink("https://app.fitcentive.xyz");
                                  },
                                ),
                              ],
                            ),
                            SpaceH16(),
                            Row(
                              children: [
                                SocialButton2(
                                  title: "",
                                  iconData: FontAwesomeIcons.googlePlay,
                                  onPressed: () => openUrlLink("https://google.ca"),
                                  buttonColor: AppColors.orange1,
                                  iconColor: AppColors.white,
                                ),
                                SocialButton2(
                                  title: "",
                                  iconData: FontAwesomeIcons.appStore,
                                  onPressed: () => openUrlLink("https://google.ca"),
                                  buttonColor: AppColors.orange1,
                                  iconColor: AppColors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightOfStack / 2),
              Container(
                margin: EdgeInsets.only(left: (sizeOfBlobSm * 0.35)),
                child: ResponsiveBuilder(
                  refinedBreakpoints: RefinedBreakpoints(),
                  builder: (context, sizingInformation) {
                    double screenWidth = sizingInformation.screenSize.width;
                    if (screenWidth < RefinedBreakpoints().tabletNormal) {
                      return Container(
                        margin: EdgeInsets.only(right: (sizeOfBlobSm * 0.35)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildCardRow(
                            context: context,
                            dataCallback: widget.hopButtonCallback,
                            data: Data.nimbusCardData,
                            width: contentAreaWidth,
                            isHorizontal: false,
                            hasAnimation: false,
                          ),
                        ),
                      );
                    } else if (screenWidth >=
                            RefinedBreakpoints().tabletNormal &&
                        screenWidth <= 1024) {
                      return Wrap(
                        runSpacing: 24,
                        children: [
                          SizedBox(width: contentAreaWidth * 0.03),
                          cardsForTabletView[0],
                          SpaceW40(),
                          cardsForTabletView[1],
                          SizedBox(width: contentAreaWidth * 0.03),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: cardsForTabletView[2],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ...buildCardRow(
                                context: context,
                                dataCallback: widget.hopButtonCallback,
                                data: Data.nimbusCardData,
                                width: contentAreaWidth / 3.8,
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
