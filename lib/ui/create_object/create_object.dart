// 他人には見せられないク⚪︎コード
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:myapp/components/color.dart';

class CreateObject extends StatefulWidget {
  final String id; //上位Widgetから受け取りたいデータ
  final File? image; //上位Widgetから受け取りたいデータ
  const CreateObject({Key? key, required this.id, required this.image})
      : super(key: key);

  @override
  State<CreateObject> createState() => _CreateObjectState();
}

class _CreateObjectState extends State<CreateObject> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;

  String title = "GameManager";
  bool value = false;
  bool _sendLoading = false;
  void Function(bool)? onChanged;
  // 気が向いたらサーバーに置く。気が向いたら。
  List<List<Map<String, dynamic>>> actions = [
    [
      {
        "label": "鹿(1)",
        "type": "object",
        "name": "object/animal/deer_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "鹿(2)",
        "type": "object",
        "name": "object/animal/deer_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "鹿(3)",
        "type": "object",
        "name": "object/animal/deer_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "馬(1)",
        "type": "object",
        "name": "object/animal/horse_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "馬(2)",
        "type": "object",
        "name": "object/animal/horse_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "馬(3)",
        "type": "object",
        "name": "object/animal/horse_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "鶏(1)",
        "type": "object",
        "name": "object/animal/chicken_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "鶏(2)",
        "type": "object",
        "name": "object/animal/chicken_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "鶏(3)",
        "type": "object",
        "name": "object/animal/chicken_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "犬(1)",
        "type": "object",
        "name": "object/animal/dog_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "犬(2)",
        "type": "object",
        "name": "object/animal/dog_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "犬(3)",
        "type": "object",
        "name": "object/animal/dog_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ペンギン(1)",
        "type": "object",
        "name": "object/animal/penguin_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ペンギン(2)",
        "type": "object",
        "name": "object/animal/penguin_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ペンギン(3)",
        "type": "object",
        "name": "object/animal/penguin_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "猫(1)",
        "type": "object",
        "name": "object/animal/cat_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "猫(2)",
        "type": "object",
        "name": "object/animal/cat_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "猫(3)",
        "type": "object",
        "name": "object/animal/cat_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "虎(1)",
        "type": "object",
        "name": "object/animal/tiger_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "虎(2)",
        "type": "object",
        "name": "object/animal/tiger_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "虎(3)",
        "type": "object",
        "name": "object/animal/tiger_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "雪だるま1(1)",
        "type": "object",
        "name": "object/snowman/snowman_1_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま1(2)",
        "type": "object",
        "name": "object/snowman/snowman_1_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま1(3)",
        "type": "object",
        "name": "object/snowman/snowman_1_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま2(1)",
        "type": "object",
        "name": "object/snowman/snowman_2_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま2(2)",
        "type": "object",
        "name": "object/snowman/snowman_2_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま2(3)",
        "type": "object",
        "name": "object/snowman/snowman_2_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま3(1)",
        "type": "object",
        "name": "object/snowman/snowman_3_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま3(2)",
        "type": "object",
        "name": "object/snowman/snowman_3_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま3(3)",
        "type": "object",
        "name": "object/snowman/snowman_3_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま4(1)",
        "type": "object",
        "name": "object/snowman/snowman_4_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま4(2)",
        "type": "object",
        "name": "object/snowman/snowman_4_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "雪だるま4(3)",
        "type": "object",
        "name": "object/snowman/snowman_4_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "プレゼント1(1)",
        "type": "object",
        "name": "object/present/box_1_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント1(2)",
        "type": "object",
        "name": "object/present/box_1_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント1(3)",
        "type": "object",
        "name": "object/present/box_1_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント2(1)",
        "type": "object",
        "name": "object/present/box_2_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント2(2)",
        "type": "object",
        "name": "object/present/box_2_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント2(3)",
        "type": "object",
        "name": "object/present/box_2_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント3(1)",
        "type": "object",
        "name": "object/present/box_3_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント3(2)",
        "type": "object",
        "name": "object/present/box_3_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント3(3)",
        "type": "object",
        "name": "object/present/box_3_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント4(1)",
        "type": "object",
        "name": "object/present/box_4_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント4(2)",
        "type": "object",
        "name": "object/present/box_4_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント4(3)",
        "type": "object",
        "name": "object/present/box_4_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント5(1)",
        "type": "object",
        "name": "object/present/box_5_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント5(2)",
        "type": "object",
        "name": "object/present/box_5_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント5(3)",
        "type": "object",
        "name": "object/present/box_5_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント6(1)",
        "type": "object",
        "name": "object/present/box_6_1",
        "value": false,
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント6(2)",
        "type": "object",
        "name": "object/present/box_6_2",
        "value": false,
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント6(3)",
        "type": "object",
        "name": "object/present/box_6_3",
        "value": false,
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント7(1)",
        "type": "object",
        "name": "object/present/box_7_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント7(2)",
        "type": "object",
        "name": "object/present/box_7_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント7(3)",
        "type": "object",
        "name": "object/present/box_7_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント8(1)",
        "type": "object",
        "name": "object/present/box_8_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント8(2)",
        "type": "object",
        "name": "object/present/box_8_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント8(3)",
        "type": "object",
        "name": "object/present/box_8_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント9(1)",
        "type": "object",
        "name": "object/present/box_9_1",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント9(2)",
        "type": "object",
        "name": "object/present/box_9_2",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "プレゼント9(3)",
        "type": "object",
        "name": "object/present/box_9_3",
        "value": false,
        "detail": {
          "size": 0.2,
          "power": 5,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "教会1(1)",
        "type": "object",
        "name": "object/building/building_1_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "教会1(2)",
        "type": "object",
        "name": "object/building/building_1_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "教会1(3)",
        "type": "object",
        "name": "object/building/building_1_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "教会2(1)",
        "type": "object",
        "name": "object/building/building_2_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "教会2(2)",
        "type": "object",
        "name": "object/building/building_2_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "教会2(3)",
        "type": "object",
        "name": "object/building/building_2_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家1(1)",
        "type": "object",
        "name": "object/building/building_3_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家1(2)",
        "type": "object",
        "name": "object/building/building_3_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家1(3)",
        "type": "object",
        "name": "object/building/building_3_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家2(1)",
        "type": "object",
        "name": "object/building/building_4_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家2(2)",
        "type": "object",
        "name": "object/building/building_4_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家2(3)",
        "type": "object",
        "name": "object/building/building_4_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家3(1)",
        "type": "object",
        "name": "object/building/building_5_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家3(2)",
        "type": "object",
        "name": "object/building/building_5_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家3(3)",
        "type": "object",
        "name": "object/building/building_5_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家4(1)",
        "type": "object",
        "name": "object/building/building_6_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家4(2)",
        "type": "object",
        "name": "object/building/building_6_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家4(3)",
        "type": "object",
        "name": "object/building/building_6_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家5(1)",
        "type": "object",
        "name": "object/building/building_7_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家5(2)",
        "type": "object",
        "name": "object/building/building_7_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家5(3)",
        "type": "object",
        "name": "object/building/building_7_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家6(1)",
        "type": "object",
        "name": "object/building/building_8_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家6(2)",
        "type": "object",
        "name": "object/building/building_8_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家6(3)",
        "type": "object",
        "name": "object/building/building_8_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家7(1)",
        "type": "object",
        "name": "object/building/building_9_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家7(2)",
        "type": "object",
        "name": "object/building/building_9_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家7(3)",
        "type": "object",
        "name": "object/building/building_9_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家8(1)",
        "type": "object",
        "name": "object/building/building_10_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家8(2)",
        "type": "object",
        "name": "object/building/building_10_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家8(3)",
        "type": "object",
        "name": "object/building/building_10_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家9(1)",
        "type": "object",
        "name": "object/building/building_11_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家9(2)",
        "type": "object",
        "name": "object/building/building_11_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家9(3)",
        "type": "object",
        "name": "object/building/building_11_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家10(1)",
        "type": "object",
        "name": "object/building/building_12_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家10(2)",
        "type": "object",
        "name": "object/building/building_12_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家10(3)",
        "type": "object",
        "name": "object/building/building_12_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家11(1)",
        "type": "object",
        "name": "object/building/building_13_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家11(2)",
        "type": "object",
        "name": "object/building/building_13_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家11(3)",
        "type": "object",
        "name": "object/building/building_13_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家12(1)",
        "type": "object",
        "name": "object/building/building_14_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家12(2)",
        "type": "object",
        "name": "object/building/building_14_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "家12(3)",
        "type": "object",
        "name": "object/building/building_14_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "クリスマスツリー1(1)",
        "type": "object",
        "name": "object/tree/tree_6_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー1(2)",
        "type": "object",
        "name": "object/tree/tree_6_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー1(3)",
        "type": "object",
        "name": "object/tree/tree_6_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー2(1)",
        "type": "object",
        "name": "object/tree/tree_8_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 200,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー2(2)",
        "type": "object",
        "name": "object/tree/tree_8_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 200,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー2(3)",
        "type": "object",
        "name": "object/tree/tree_8_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 200,
          "rx": 270.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー3(1)",
        "type": "object",
        "name": "object/tree/tree_9_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 4,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー3(2)",
        "type": "object",
        "name": "object/tree/tree_9_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 4,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クリスマスツリー3(3)",
        "type": "object",
        "name": "object/tree/tree_9_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 4,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木1(1)",
        "type": "object",
        "name": "object/tree/tree_1_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木1(2)",
        "type": "object",
        "name": "object/tree/tree_1_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木1(3)",
        "type": "object",
        "name": "object/tree/tree_1_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木2(1)",
        "type": "object",
        "name": "object/tree/tree_2_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木2(2)",
        "type": "object",
        "name": "object/tree/tree_2_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木2(3)",
        "type": "object",
        "name": "object/tree/tree_2_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木3(1)",
        "type": "object",
        "name": "object/tree/tree_3_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木3(2)",
        "type": "object",
        "name": "object/tree/tree_3_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木3(3)",
        "type": "object",
        "name": "object/tree/tree_3_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木4(1)",
        "type": "object",
        "name": "object/tree/tree_4_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木4(2)",
        "type": "object",
        "name": "object/tree/tree_4_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木4(3)",
        "type": "object",
        "name": "object/tree/tree_4_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木5(1)",
        "type": "object",
        "name": "object/tree/tree_5_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木5(2)",
        "type": "object",
        "name": "object/tree/tree_5_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木5(3)",
        "type": "object",
        "name": "object/tree/tree_5_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木6(1)",
        "type": "object",
        "name": "object/tree/tree_7_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木6(2)",
        "type": "object",
        "name": "object/tree/tree_7_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "木6(3)",
        "type": "object",
        "name": "object/tree/tree_7_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "岩1(1)",
        "type": "object",
        "name": "object/rock/rock_1_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩1(2)",
        "type": "object",
        "name": "object/rock/rock_1_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩1(3)",
        "type": "object",
        "name": "object/rock/rock_1_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩2(1)",
        "type": "object",
        "name": "object/rock/rock_2_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩2(2)",
        "type": "object",
        "name": "object/rock/rock_2_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩2(3)",
        "type": "object",
        "name": "object/rock/rock_2_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩3(1)",
        "type": "object",
        "name": "object/rock/rock_3_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩3(2)",
        "type": "object",
        "name": "object/rock/rock_3_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩3(3)",
        "type": "object",
        "name": "object/rock/rock_3_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩4(1)",
        "type": "object",
        "name": "object/rock/rock_4_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩4(2)",
        "type": "object",
        "name": "object/rock/rock_4_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩4(3)",
        "type": "object",
        "name": "object/rock/rock_4_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩5(1)",
        "type": "object",
        "name": "object/rock/rock_5_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩5(2)",
        "type": "object",
        "name": "object/rock/rock_5_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩5(3)",
        "type": "object",
        "name": "object/rock/rock_5_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩6(1)",
        "type": "object",
        "name": "object/rock/rock_6_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩7(1)",
        "type": "object",
        "name": "object/rock/rock_7_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩7(2)",
        "type": "object",
        "name": "object/rock/rock_7_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩7(3)",
        "type": "object",
        "name": "object/rock/rock_7_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩8(1)",
        "type": "object",
        "name": "object/rock/rock_8_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩8(2)",
        "type": "object",
        "name": "object/rock/rock_8_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩8(3)",
        "type": "object",
        "name": "object/rock/rock_8_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩9(1)",
        "type": "object",
        "name": "object/rock/rock_9_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩9(2)",
        "type": "object",
        "name": "object/rock/rock_9_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩9(3)",
        "type": "object",
        "name": "object/rock/rock_9_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩10(1)",
        "type": "object",
        "name": "object/rock/rock_10_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩10(2)",
        "type": "object",
        "name": "object/rock/rock_10_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩10(3)",
        "type": "object",
        "name": "object/rock/rock_10_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩11(1)",
        "type": "object",
        "name": "object/rock/rock_11_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩11(2)",
        "type": "object",
        "name": "object/rock/rock_11_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩11(3)",
        "type": "object",
        "name": "object/rock/rock_11_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩12(1)",
        "type": "object",
        "name": "object/rock/rock_12_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩12(2)",
        "type": "object",
        "name": "object/rock/rock_12_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "岩12(3)",
        "type": "object",
        "name": "object/rock/rock_12_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "クッキー1(1)",
        "type": "object",
        "name": "object/cookie/cookie_1_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー1(2)",
        "type": "object",
        "name": "object/cookie/cookie_1_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー1(3)",
        "type": "object",
        "name": "object/cookie/cookie_1_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー2(1)",
        "type": "object",
        "name": "object/cookie/cookie_2_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー2(2)",
        "type": "object",
        "name": "object/cookie/cookie_2_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー2(3)",
        "type": "object",
        "name": "object/cookie/cookie_2_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー3(1)",
        "type": "object",
        "name": "object/cookie/cookie_3_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー3(2)",
        "type": "object",
        "name": "object/cookie/cookie_3_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー3(3)",
        "type": "object",
        "name": "object/cookie/cookie_3_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー4(1)",
        "type": "object",
        "name": "object/cookie/cookie_4_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー4(2)",
        "type": "object",
        "name": "object/cookie/cookie_4_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー4(3)",
        "type": "object",
        "name": "object/cookie/cookie_4_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー5(1)",
        "type": "object",
        "name": "object/cookie/cookie_5_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー5(2)",
        "type": "object",
        "name": "object/cookie/cookie_5_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー5(3)",
        "type": "object",
        "name": "object/cookie/cookie_5_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー6(1)",
        "type": "object",
        "name": "object/cookie/cookie_6_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー7(1)",
        "type": "object",
        "name": "object/cookie/cookie_7_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー7(2)",
        "type": "object",
        "name": "object/cookie/cookie_7_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "クッキー7(3)",
        "type": "object",
        "name": "object/cookie/cookie_7_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "地面1(1)",
        "type": "object",
        "name": "object/ground/ground_1_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面1(2)",
        "type": "object",
        "name": "object/ground/ground_1_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面1(3)",
        "type": "object",
        "name": "object/ground/ground_1_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面2(1)",
        "type": "object",
        "name": "object/ground/ground_2_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面2(2)",
        "type": "object",
        "name": "object/ground/ground_2_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面2(3)",
        "type": "object",
        "name": "object/ground/ground_2_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面3(1)",
        "type": "object",
        "name": "object/ground/ground_3_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面3(2)",
        "type": "object",
        "name": "object/ground/ground_3_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "地面3(3)",
        "type": "object",
        "name": "object/ground/ground_3_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "エフェクト1",
        "type": "object",
        "name": "object/effect/effect_1",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 10,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト2",
        "type": "object",
        "name": "object/effect/effect_2",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト3",
        "type": "object",
        "name": "object/effect/effect_3",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト4",
        "type": "object",
        "name": "object/effect/effect_4",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト5",
        "type": "object",
        "name": "object/effect/effect_5",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト6",
        "type": "object",
        "name": "object/effect/effect_6",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト7",
        "type": "object",
        "name": "object/effect/effect_7",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト8",
        "type": "object",
        "name": "object/effect/effect_8",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト9",
        "type": "object",
        "name": "object/effect/effect_9",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト10",
        "type": "object",
        "name": "object/effect/effect_10",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト11",
        "type": "object",
        "name": "object/effect/effect_11",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト12",
        "type": "object",
        "name": "object/effect/effect_12",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト13",
        "type": "object",
        "name": "object/effect/effect_13",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト14",
        "type": "object",
        "name": "object/effect/effect_14",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト15",
        "type": "object",
        "name": "object/effect/effect_15",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト16",
        "type": "object",
        "name": "object/effect/effect_16",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト17",
        "type": "object",
        "name": "object/effect/effect_17",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト18",
        "type": "object",
        "name": "object/effect/effect_18",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト19",
        "type": "object",
        "name": "object/effect/effect_19",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト20",
        "type": "object",
        "name": "object/effect/effect_20",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト21",
        "type": "object",
        "name": "object/effect/effect_21",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト22",
        "type": "object",
        "name": "object/effect/effect_22",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト23",
        "type": "object",
        "name": "object/effect/effect_23",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト24",
        "type": "object",
        "name": "object/effect/effect_24",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト25",
        "type": "object",
        "name": "object/effect/effect_25",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト26",
        "type": "object",
        "name": "object/effect/effect_26",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト27",
        "type": "object",
        "name": "object/effect/effect_27",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト28",
        "type": "object",
        "name": "object/effect/effect_28",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト29",
        "type": "object",
        "name": "object/effect/effect_29",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト30",
        "type": "object",
        "name": "object/effect/effect_30",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト31",
        "type": "object",
        "name": "object/effect/effect_31",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト32",
        "type": "object",
        "name": "object/effect/effect_32",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト33",
        "type": "object",
        "name": "object/effect/effect_33",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "エフェクト34",
        "type": "object",
        "name": "object/effect/effect_34",
        "value": false,
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "テキスト(1)",
        "type": "text",
        "name": "object/text/text_1",
        "text": "",
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "テキスト(2)",
        "type": "text",
        "name": "object/text/text_2",
        "text": "",
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "テキスト(3)",
        "type": "text",
        "name": "object/text/text_3",
        "text": "",
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "テキスト(4)",
        "type": "text",
        "name": "object/text/text_4",
        "text": "",
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "テキスト(5)",
        "type": "text",
        "name": "object/text/text_5",
        "text": "",
        "detail": {
          "size": 0.5,
          "power": 2,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {
        "label": "ライト(1)",
        "type": "object",
        "name": "object/light/light_1",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(2)",
        "type": "object",
        "name": "object/light/light_2",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(3)",
        "type": "object",
        "name": "object/light/light_3",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(4)",
        "type": "object",
        "name": "object/light/light_4",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(5)",
        "type": "object",
        "name": "object/light/light_5",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(6)",
        "type": "object",
        "name": "object/light/light_6",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(7)",
        "type": "object",
        "name": "object/light/light_7",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(8)",
        "type": "object",
        "name": "object/light/light_8",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(9)",
        "type": "object",
        "name": "object/light/light_9",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
      {
        "label": "ライト(10)",
        "type": "object",
        "name": "object/light/light_10",
        "detail": {
          "size": 1.0,
          "power": 1,
          "rx": 0.0,
          "ry": 0.0,
          "rz": 0.0,
          "px": 0.0,
          "py": 0.0,
          "pz": 0.0
        }
      },
    ],
    [
      {"label": "雪1", "action": "snow1_size", "type": "slider", "value": 0.0},
      {"label": "雪2", "action": "snow2_size", "type": "slider", "value": 0.0},
      {"label": "雪3", "action": "snow3_size", "type": "slider", "value": 0.0},
      {"label": "雪4", "action": "snow4_size", "type": "slider", "value": 0.0},
      {"label": "雪5", "action": "snow5_size", "type": "slider", "value": 0.0},
      {"label": "雪6", "action": "snow6_size", "type": "slider", "value": 0.0},
      {"label": "雪7", "action": "snow7_size", "type": "slider", "value": 0.0},
      {"label": "雪8", "action": "snow8_size", "type": "slider", "value": 0.0},
      {"label": "雪9", "action": "snow9_size", "type": "slider", "value": 0.0},
      {"label": "雪10", "action": "snow10_size", "type": "slider", "value": 0.0},
    ],
  ];

  late Map<String, dynamic> action = actions[0][0];

  @override
  Widget build(BuildContext context) {
    return _buildDefaultTheme(Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: SafeArea(
          bottom: false,
          child: WillPopScope(
              onWillPop: () async {
                // Pop the category page if Android back button is pressed.
                return true;
              },
              child: Column(children: <Widget>[
                Expanded(
                  child: Stack(
                    children: [
                      Expanded(
                          child: UnityWidget(
                        onUnityCreated: onUnityCreated,
                      )),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        top: 5,
                        child: Container(
                          width: 150,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            child: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: DetailEditor(
                                    action: action,
                                    changeObject: _changeObject)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 200,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: DefaultTabController(
                        length: actions.length,
                        child: Scaffold(
                          appBar: const TabBar(
                            labelColor: theme,
                            indicatorColor: theme,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            tabs: <Widget>[
                              Tab(icon: Icon(Icons.beach_access_sharp)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                              Tab(icon: Icon(Icons.cloudy_snowing)),
                            ],
                          ),
                          body: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: actions
                                  .map((e) => SingleChildScrollView(
                                          child: ObjectEditor(
                                        actions: e,
                                        changeSwitch: _changeSwitch,
                                        changeSlider: _changeSlider,
                                        toggleObject: _toggleObject,
                                        toggleObjectText: _toggleObjectText,
                                      )))
                                  .toList()),
                        ),
                      ),
                    )),
              ])),
        ),
      ),
      Visibility(
        visible: _sendLoading,
        child: Expanded(
            child: Container(
          color: Colors.black.withOpacity(0.85),
          child: const Center(
            child: SizedBox(
                width: 60, height: 60, child: CircularProgressIndicator()),
          ),
        )),
      )
    ]));
  }

  AppBar _buildAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: subtheme,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Object Builder",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      automaticallyImplyLeading: true,
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                child: const Text(
                  "完成",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                // データ送信を行います
                onTap: () async {
                  setState(() {
                    _sendLoading = true;
                  });
                  _request();
                }),
          ),
        )
      ],
    );
  }

  Widget _buildDefaultTheme(Widget child) {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 10,
          thumbColor: theme,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
          activeTrackColor: theme.withOpacity(0.7),
          activeTickMarkColor: Colors.green,
        ),
        child: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.red, fontSize: 20),
            child: SwitchTheme(data: SwitchThemeData(), child: child)));
  }

  void _request() async {
    Uint8List imageBytes = await widget.image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // APIエンドポイント
    String apiUrl = "https://portfolio.k256.dev/api/upload";

    // すべてのデータをマージ
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      "image": base64Image,
      "json": actions,
      "id": widget.id,
    };

    print("処理");

    // APIにPOSTリクエストを送信
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    // レスポンスの処理
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
    _unityWidgetController?.postMessage("sceneChanger", "setScene", "creator");
  }

  // message send switch
  void _changeSwitch(e, value) {
    setState(() {
      e["value"] = value;
    });
    _unityWidgetController?.postMessage(
        title, e["action"], e["value"] ? "enable" : "disenable");
    print(e);
  }

  // message send slider
  void _changeSlider(e, value) {
    setState(() {
      e["value"] = value;
    });
    _unityWidgetController?.postMessage(
        title, e["action"], e["value"].toString());
    print(e);
  }

  void _changeObject(Map<String, dynamic> e, String changeKey, double value) {
    setState(() {
      e["detail"][changeKey] = value;
    });
    _unityWidgetController?.postJsonMessage(title, "changeObject", e);
  }

  void _toggleObject(Map<String, dynamic> e, bool value) {
    setState(() {
      e["value"] = value;
    });
    if (e["value"]) {
      setState(() {
        action = e;
      });
    }
    _unityWidgetController?.postJsonMessage(title, "changeObject", e);
  }

  void _toggleObjectText(Map<String, dynamic> e, String value) {
    setState(() {
      e["text"] = value;
    });
    if (e["text"] != "") {
      setState(() {
        action = e;
      });
    }
    _unityWidgetController?.postJsonMessage(title, "changeObject", e);
  }
}

class DetailEditor extends StatelessWidget {
  final Map<String, dynamic> action;
  final Function(Map<String, dynamic>, String, double) changeObject;
  DetailEditor({required this.action, required this.changeObject});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
          thumbColor: theme,
          activeTrackColor: theme.withOpacity(0.7),
          activeTickMarkColor: subtheme,
          overlayShape: SliderComponentShape.noOverlay, //用意したクラス
        ),
        child: Column(
          children: [
            Text('詳細設定'),
            SizedBox(height: 5),
            Text(action["label"]),
            SizedBox(height: 10),
            Text('サイズ'),
            SizedBox(
              child: Slider(
                value: action["detail"]["size"],
                min: 0,
                max: 1,
                onChanged: (double value) {
                  changeObject(action, "size", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('回転(横)'),
            SizedBox(
              child: Slider(
                value: action["detail"]["rx"],
                min: 0,
                max: 360,
                onChanged: (double value) {
                  changeObject(action, "rx", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('回転(高さ)'),
            SizedBox(
              child: Slider(
                value: action["detail"]["ry"],
                min: 0,
                max: 360,
                onChanged: (double value) {
                  changeObject(action, "ry", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('回転(縦)'),
            SizedBox(
              child: Slider(
                value: action["detail"]["rz"],
                min: 0,
                max: 360,
                onChanged: (double value) {
                  changeObject(action, "rz", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('移動横'),
            SizedBox(
              child: Slider(
                value: action["detail"]["px"],
                min: -10,
                max: 10,
                onChanged: (double value) {
                  changeObject(action, "px", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('移動高さ'),
            SizedBox(
              child: Slider(
                value: action["detail"]["py"],
                min: -10,
                max: 10,
                onChanged: (double value) {
                  changeObject(action, "py", value);
                },
              ),
            ),
            SizedBox(height: 5),
            Text('移動縦'),
            SizedBox(
              child: Slider(
                value: action["detail"]["pz"],
                min: -10,
                max: 10,
                onChanged: (double value) {
                  changeObject(action, "pz", value);
                },
              ),
            ),
          ],
        ));
  }
}

class ObjectEditor extends StatelessWidget {
  final List<Map<String, dynamic>> actions;
  final Function(Map<String, dynamic>, bool) changeSwitch;
  final Function(Map<String, dynamic>, double) changeSlider;
  final Function(Map<String, dynamic>, bool) toggleObject;
  final Function(Map<String, dynamic>, String) toggleObjectText;

  ObjectEditor(
      {required this.actions,
      required this.changeSwitch,
      required this.changeSlider,
      required this.toggleObject,
      required this.toggleObjectText}); // コンストラクタで引数を受け取る

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: actions
              .map((e) => Row(
                    children: [
                      SizedBox(
                        width: 150.0, // 固定サイズ
                        child: Text(e["label"],
                            style: const TextStyle(color: Colors.black)),
                      ),
                      // 右のSlider
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: (() {
                              if (e["type"] == "toggle") {
                                return Switch(
                                  activeColor: theme,
                                  value: e["value"] ?? false,
                                  onChanged: (value) {
                                    changeSwitch(e, value);
                                  },
                                );
                              } else if (e["type"] == "slider") {
                                return Slider(
                                    value: e["value"] ?? 0.0,
                                    min: 0,
                                    max: 100,
                                    onChanged: (value) {
                                      changeSlider(e, value);
                                    });
                              } else if (e["type"] == "object") {
                                return Switch(
                                  activeColor: theme,
                                  value: e["value"] ?? false,
                                  onChanged: (value) {
                                    toggleObject(e, value);
                                  },
                                );
                              } else if (e["type"] == "text") {
                                return TextFormField(
                                  cursorColor: theme,
                                  initialValue: e["text"],
                                  decoration: const InputDecoration(
                                    hoverColor: theme,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme, //入力中
                                      ),
                                    ),
                                  ),
                                  enabled: true,
                                  // 入力数
                                  maxLength: 20,
                                  obscureText: false,
                                  maxLines: 1,

                                  //パスワード
                                  onChanged: (value) {
                                    toggleObjectText(e, value);
                                  },
                                );
                              }
                            })()),
                      ),
                    ],
                  ))
              .toList()),
    );
  }
}
