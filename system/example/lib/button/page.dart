import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:system/widget/check_button.dart';
import 'package:system/widget/drop_button.dart';
import 'package:system/widget/drop_check_menu.dart';
import 'package:system/widget/drop_menu.dart';
import 'package:system/widget/multiple_drop_button.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OutlinedButton(onPressed: () {}, child: Text("OutlinedButton")),
            CheckButton(
              checked: true,
              onTap: (bool value) {
                print(value);
              },
              title: Text('CheckButton'),
            ),
            SizedBox(
              width: 90,
              child: DropMenu<int>(
                items: const {1: '文字很长很长', 2: '初中', 3: '大'},
              ),
            ),
            SizedBox(
                width: 120,
                child: DropCheckMenu<int>(
                    onChanged: (res) {
                      print(res);
                    },
                    items: const {1: '艺术', 2: '美术', 3: '语文', 4: '英语', 5: '数学'},
                    selectedKeys: const [])),
            MultipleDropButton<int>(
              items: const {1: "以色列", 2: "法国", 3: '阿塞拜疆'},
              selectedKeys: const [1],
              onChanged: (res) => print(res),
            ),
            DropButton<int>(items: {1:'小学',2:'初中',3:'大学'},value: 1,),
            Container(
              height: 800,
              width: double.infinity,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
