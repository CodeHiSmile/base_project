import 'package:base_project/app/app_bloc/app_bloc.dart';
import 'package:base_project/app/app_bloc/app_event.dart';
import 'package:base_project/app/app_bloc/app_state.dart';
import 'package:base_project/di/di.dart';
import 'package:base_project/navigation/middleware/auth_service.dart';
import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/features/home/home_page.dart';
import 'package:base_project/presentation/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import './bloc/bloc.dart';

class MainArguments {
  const MainArguments();
}

class MainPage extends StatefulWidget {
  final MainArguments? arguments;

  const MainPage({super.key, this.arguments});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BasePageState<MainPage, MainBloc>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  PageController? pageController;
  TabController? _tabController;
  final AppBloc appBloc = GetIt.instance.get<AppBloc>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController?.dispose();
    pageController?.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    final isLogin = await getIt.get<AuthService>().isLoggedIn();

    if (index == 2) {
      if (!isLogin) {
        await RouterService.pushTo(RouterPaths.login);

        if (await getIt.get<AuthService>().isLoggedIn()) {
          onNavigateToPageIndex(index);
        }
      } else {
        onNavigateToPageIndex(index);
      }
    } else {
      onNavigateToPageIndex(index);
    }
  }

  void onNavigateToPageIndex(int index) {
    setState(() {
      appBloc.add(ChangeMainPageIndexEvent(pageIndex: index));
      pageController?.jumpToPage(index);
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        if (pageController != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (appState.mainPageIndex != (pageController?.page ?? 0).round()) {
              pageController?.jumpToPage(appState.mainPageIndex);
            }
          });
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              const HomePage(),
              const SizedBox(),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appState.mainPageIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
