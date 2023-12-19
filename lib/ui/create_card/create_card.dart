import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/components/color.dart';
import 'package:myapp/ui/create_object/create_object.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  File? image;
  String id = "";
  bool isExists = true;

  final picker = ImagePicker();

  Future getImage() async {
    //カメラロールから読み取る
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('画像が選択できませんでした。');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var innerWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 200, minHeight: 100),
                        child: ElevatedButton(
                            onPressed: getImage,
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10) //こちらを適用
                                    )),
                            child: image == null
                                ? const Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.image_outlined,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '画像を選択',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Image.file(image!)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'カードを作成する',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: innerWidth,
                        child: TextFormField(
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
                            http.Response response = await http.get(Uri.https(
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
                                ? id == ""
                                    ? null
                                    : "${id}は既に存在します"
                                : null,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 72, 72, 72),
                                width: 2.0,
                              ),
                            ),
                            hintText: '作品名を入力(英数字と_のみ)',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 72, 72, 72),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 50),
                    const Spacer(),
                    Center(
                      child: SizedBox(
                        width: innerWidth,
                        height: innerWidth / 5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.black,
                            backgroundColor: theme,
                            elevation: 0,
                            disabledBackgroundColor:
                                Colors.grey.withOpacity(0.5),
                            disabledForegroundColor:
                                Colors.white.withOpacity(0.8),
                          ),
                          onPressed: (image == null || id == "")
                              ? null
                              : () async {
                                  http.Response response = await http.get(
                                      Uri.https('portfolio.k256.dev',
                                          '/api/is_exists_id', {'id': id}));

                                  // 存在しない場合
                                  if (response.statusCode == 200) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateObject(
                                                image: image, id: id)));
                                  } else if (response.statusCode == 201) {
                                    print("exist");
                                  }
                                },
                          child: const Center(
                            child: Text(
                              '3Dオブジェクトを作成する',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
        "AR Card",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
