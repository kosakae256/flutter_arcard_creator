import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/components/color.dart';

class AR extends StatefulWidget {
  const AR({Key? key}) : super(key: key);

  @override
  State<AR> createState() => _ARState();
}

class _ARState extends State<AR> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;
  String id = "";
  bool isExists = false;
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () async {
            // Pop the category page if Android back button is pressed.
            return true;
          },
          child: Stack(children: [
            UnityWidget(
              onUnityCreated: onUnityCreated,
            ),
            SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Visibility(
                    visible: _visible,
                    child: Center(
                      child: Container(
                          width: 250,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z0-9_]') //英数字、_のみ入力可にする
                                        ),
                                  ],
                                  enabled: true,
                                  // 入力数
                                  maxLength: 16,
                                  obscureText: false,
                                  maxLines: 1,

                                  onChanged: (value) async {
                                    // 存在チェック
                                    http.Response response = await http.get(
                                        Uri.https(
                                            'portfolio.k256.dev',
                                            '/api/is_exists_id',
                                            {'id': value}));
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        isExists = false;
                                      });
                                    } else if (response.statusCode == 201) {
                                      setState(() {
                                        isExists = true;
                                      });
                                    }
                                    id = value;
                                  },
                                  decoration: InputDecoration(
                                    errorText: isExists
                                        ? null
                                        : id == ""
                                            ? null
                                            : "${id}は存在しません",
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 72, 72, 72),
                                        width: 2.0,
                                      ),
                                    ),
                                    hintText: '作品名を入力',
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 14),
                                    foregroundColor: Colors.black,
                                    backgroundColor: theme,
                                    elevation: 0,
                                    disabledBackgroundColor:
                                        Colors.grey.withOpacity(0.5),
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.8),
                                  ),
                                  onPressed: isExists
                                      ? () {
                                          _loadObjectData();
                                          setState(() {
                                            _visible = false;
                                          });
                                        }
                                      : null,
                                  child: const Text(
                                    'ARカードを読み取る',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    )))
          ]),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: subtheme,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "AR Loader",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      automaticallyImplyLeading: true,
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
    _unityWidgetController?.postMessage("sceneChanger", "setScene", "ar");
  }

  void _loadObjectData() async {
    http.Response response = await http.get(
        Uri.https('portfolio.k256.dev', '/api/get_build_data', {'id': id}));

    // 存在する場合ロード処理をする
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      await _unityWidgetController?.postMessage(
          "ARCamera", "RetrieveTextureFromWeb", body["img_url"]);
      await Future.delayed(Duration(seconds: 3));
      for (var a in body["build_data"]) {
        for (var b in a) {
          if (b["type"] == "object" || b["type"] == "text") {
            await _unityWidgetController?.postJsonMessage(
                "GameManager", "changeObject", b);
            print("a");
          } else if (b["type"] == "slider") {
            await _unityWidgetController?.postMessage(
                "GameManager", b["action"], b["value"].toString());
            print("b");
          }
        }
      }
    } else if (response.statusCode == 404) {
      print("not found");
    }
  }
}
