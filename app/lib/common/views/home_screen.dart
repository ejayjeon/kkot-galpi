import 'package:app/common/components/book_rack.dart';
import 'package:app/common/layout/main_layout.dart';
import 'package:app/login/kakao/components/kakao_login.dart';
import 'package:app/login/naver/components/naver_login.dart';
import 'package:app/post/components/post_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String get routeName => 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          BookRack(),
          PostScreen(),
          KakaoLogin(),
          NaverLogin(),
          Container(
            child: Center(
              child: Text('내정보'),
            ),
          ),
        ],
      ),
      bottomNav: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_rounded,
            ),
            label: '책장',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_stories_rounded,
            ),
            label: '독서노트',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mark_chat_unread_outlined,
            ),
            label: '소식',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: '내정보',
          ),
        ],
      ),
    );
  }
}
