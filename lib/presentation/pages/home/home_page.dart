import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/platform_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/track_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_static_web/presentation/layout/adaptive.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/discover_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/awards_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/blog_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/footer_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/header_section/header_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/nav_section/nav_section_mobile.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/nav_section/nav_section_web.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/projects_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/meetup_section.dart';
import 'package:flutter_static_web/presentation/pages/home/sections/statistics_section.dart';
import 'package:flutter_static_web/presentation/widgets/app_drawer.dart';
import 'package:flutter_static_web/presentation/widgets/nav_item.dart';
import 'package:flutter_static_web/presentation/widgets/spaces.dart';
import 'package:flutter_static_web/utils/functions.dart';
import 'package:flutter_static_web/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  // bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
    NavItemData(name: StringConst.DISCOVER, key: GlobalKey()),
    NavItemData(name: StringConst.MEETUP, key: GlobalKey()),
    NavItemData(name: StringConst.TRACK, key: GlobalKey()),
    NavItemData(name: StringConst.PLATFORMS, key: GlobalKey()),
    NavItemData(name: StringConst.PRICING, key: GlobalKey()),
    NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
    // NavItemData(name: StringConst.BLOG, key: GlobalKey()),
  ];

  genericCallback(int selectedSection) {
    scrollToSection(navItems[selectedSection + 1].key.currentContext!);
    setState(() {
      List.generate(navItems.length, (index) => navItems[index].isSelected = false);
      navItems[selectedSection + 1].isSelected = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.10;

    return Scaffold(
      key: _scaffoldKey,
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < RefinedBreakpoints().desktopSmall) {
            return AppDrawer(
              menuList: navItems,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            // Scroll to header section
            scrollToSection(navItems[0].key.currentContext!);
          },
          child: const Icon(
            FontAwesomeIcons.arrowUp,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(scaffoldKey: _scaffoldKey);
              } else {
                return NavSectionWeb(
                  navItems: navItems,
                );
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                // color: Colors.teal,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xff009688),
                      Color(0xff2C3E50),
                    ], // Gradient from https://learnui.design/tools/gradient-generator.html
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Column(
                  children: [
                    _renderLandingSection(),
                    SizedBox(height: spacerHeight),
                    _renderDiscoverSection(),
                    SizedBox(height: spacerHeight),
                    _renderMeetupSection(),
                    SizedBox(height: spacerHeight),
                    _renderTrackSection(),
                    SizedBox(height: spacerHeight),
                    _renderPlatformSection(),
                    // StatisticsSection(),
                    // SizedBox(height: spacerHeight),
                    // Container(
                    //   key: navItems[3].key,
                    //   child: ProjectsSection(),
                    // ),
                    // SizedBox(height: spacerHeight),
                    // Awards, blog
                    FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _renderLandingSection() => VisibilityDetector(
    key: Key("homeheader"),
    onVisibilityChanged: (info) {
      double visiblePercentage = info.visibleFraction * 100;
      if (visiblePercentage > 25) {
        setState(() {
          List.generate(navItems.length, (index) => navItems[index].isSelected = false);
          navItems[0].isSelected = true;
        });
      }
    },
    child: HeaderSection(
        key: navItems[0].key,
        hopButtonCallback: genericCallback
    ),
  );

  _renderDiscoverSection() => VisibilityDetector(
    key: Key("discover"),
    onVisibilityChanged: (visibilityInfo) {
      double visiblePercentage = visibilityInfo.visibleFraction * 100;
      if (visiblePercentage > 10) {
        _controller.forward();
      }

      if (visiblePercentage > 25) {
        setState(() {
          List.generate(navItems.length, (index) => navItems[index].isSelected = false);
          navItems[1].isSelected = true;
        });
      }
    },
    child: Container(
      key: navItems[1].key,
      child: DiscoverSection(),
    ),
  );

  _renderMeetupSection() => VisibilityDetector(
    key: Key("meetup"),
    onVisibilityChanged: (info) {
      double visiblePercentage = info.visibleFraction * 100;
      if (visiblePercentage > 25) {
        setState(() {
          List.generate(navItems.length, (index) => navItems[index].isSelected = false);
          navItems[2].isSelected = true;
        });
      }
    },
    child: Container(
      key: navItems[2].key,
      child: MeetupSection(),
    ),
  );


  _renderTrackSection() => VisibilityDetector(
    key: Key("track"),
    onVisibilityChanged: (info) {
      double visiblePercentage = info.visibleFraction * 100;
      if (visiblePercentage > 25) {
        setState(() {
          List.generate(navItems.length, (index) => navItems[index].isSelected = false);
          navItems[3].isSelected = true;
        });
      }
    },
    child: Container(
      key: navItems[3].key,
      child: TrackSection(),
    ),
  );

  _renderPlatformSection() => VisibilityDetector(
    key: Key("platform"),
    onVisibilityChanged: (info) {
      double visiblePercentage = info.visibleFraction * 100;
      if (visiblePercentage > 25) {
        setState(() {
          List.generate(navItems.length, (index) => navItems[index].isSelected = false);
          navItems[4].isSelected = true;
        });
      }
    },
    child: Container(
      key: navItems[4].key,
      child: PlatformSection(),
    ),
  );
}
