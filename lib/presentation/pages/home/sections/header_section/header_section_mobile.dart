import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/widgets.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter_static_web/presentation/widgets/buttons/social_button_2.dart';
import 'package:flutter_static_web/presentation/widgets/content_area.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double socialTextSizeLg = 18.0;
const double socialTextSizeSm = 14.0;
const double sidePadding = Sizes.PADDING_16;

class HeaderSectionMobile extends StatefulWidget {
  final IntCallback hopButtonCallback;

  const HeaderSectionMobile({
    Key? key,
    required this.hopButtonCallback
  }) : super(key: key);

  @override
  _HeaderSectionMobileState createState() => _HeaderSectionMobileState();
}

class _HeaderSectionMobileState extends State<HeaderSectionMobile>
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
    double headerIntroTextSize = Sizes.TEXT_SIZE_24;
    double screenWidth = widthOfScreen(context) - (sidePadding * 2);
    double contentAreaWidth = screenWidth;
    TextStyle? bodyTextStyle =
        textTheme.bodyText1?.copyWith(fontSize: bodyTextSizeSm);
    TextStyle? socialTitleStyle =
        textTheme.subtitle1?.copyWith(fontSize: socialTextSizeSm);

    double buttonWidth = 80;
    double buttonHeight = 48;

    double sizeOfBlobSm = screenWidth * 0.4;
    double sizeOfGoldenGlobe = screenWidth * 0.3;
    double dottedGoldenGlobeOffset = sizeOfBlobSm * 0.4;
    double heightOfBlobAndGlobe =
        computeHeight(dottedGoldenGlobeOffset, sizeOfGoldenGlobe, sizeOfBlobSm);
    double heightOfStack = heightOfBlobAndGlobe * 2;
    double blobOffset = heightOfStack * 0.3;
    return ContentArea(
      child: Column(
        children: [
          Center(
            child: HeaderImage(
              controller: _controller,
              globeSize: sizeOfGoldenGlobe,
              imageHeight: heightOfStack,
            ),
          ),
          SpaceH40(),
          Center(
            child: Container(
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
          ),
          SpaceH40(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: sidePadding,
              ),
              child: Column(
                children: buildCardRow(
                  context: context,
                  data: Data.nimbusCardData,
                  dataCallback: widget.hopButtonCallback,
                  width: contentAreaWidth,
                  isHorizontal: false,
                  hasAnimation: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
