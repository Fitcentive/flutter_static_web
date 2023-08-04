import 'package:auto_route/auto_route.dart';
import 'package:flutter_static_web/presentation/pages/home/home_page.dart';

part 'router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Page,Route',)
class AppRouter extends  _$$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // initial route is named "/"
    AutoRoute(page: HomeRoute.page, initial: true)
  ];
}

