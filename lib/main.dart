import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:myapp/components/color.dart';
import 'package:myapp/ui/ar/ar.dart';
import 'ui/home/home.dart';
import 'ui/archive/archive.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
          useMaterial3: false),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0; // 下部ナビゲーションバーの現在のインデックス

  final List<Widget> pages = [
    const HomeScreen(),
    const ArchiveScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          // ホーム画面以外の場合は、ホーム画面に戻る
          setState(() {
            currentIndex = 0;
          });
          return false; // デフォルトの戻るボタンの動作を防ぐ
        }
        return true; // デフォルトの戻るボタンの動作（アプリの終了）
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildIndexedStack(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const AR();
                },
              ),
            );
          },
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: _buildBottomAppBar(), // 下のナビゲーションバーを表示する
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: subtheme,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        "AR Card",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      automaticallyImplyLeading: true,
    );
  }

  Widget _buildIndexedStack() {
    return IndexedStack(
      index: currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomAppBar() {
    return SizedBox(
      height: 85,
      child: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0; // ホーム画面に切替
                  });
                },
                icon: Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: Colors.black,
                  size: 28,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1; // アーカイブ画面に切替
                  });
                },
                icon: Icon(
                  currentIndex == 1 ? Icons.folder : Icons.folder_outlined,
                  color: Colors.black,
                  size: 28,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
