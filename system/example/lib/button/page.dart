import 'package:example/button/button_routes.dart';
import 'package:flutter/material.dart';
import 'package:system/func/desktop_state.dart';
import 'package:system/widget/check_button.dart';
import 'package:system/widget/date_picker.dart';
import 'package:system/widget/delete_button.dart';
import 'package:system/widget/drop_button.dart';
import 'package:system/widget/drop_check_menu.dart';
import 'package:system/widget/drop_menu.dart';
import 'package:system/widget/multiple_drop_button.dart';

import 'intro.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  Map<int, String> items = {1: 'item1'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text("OutlinedButton"),
            ),
            CheckButton(
              checked: true,
              onTap: (bool value) {
                print(value);
              },
              title: const Text('CheckButton'),
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
                selectedKeys: const [],
              ),
            ),
            MultipleDropButton<int>(
              items: const {1: "以色列", 2: "法国", 3: '阿塞拜疆'},
              selectedKeys: const [1],
              onChanged: (res) => print(res),
            ),
            SizedBox(
              height: 500,
              child: Navigator(
                key: nestedNavigatorKey,
                onGenerateRoute: ButtonRoutes.generateRoute,
                onGenerateInitialRoutes: (navigator, initialRoute) => [
                  MaterialPageRoute(builder: (context) => const IntroList()),
                ],
              ),
            ),
            Row(
              children: [
                DropButton(items: items),
                FilledButton(
                    onPressed: () {
                      int k = items.keys.last + 1;
                      setState(() {
                        items = {...items, k: 'item$k'};
                      });
                    },
                    child: const Text("增加选项"))
              ],
            ),
            const SizedBox(
              width: 90,
              child: DropButton<int>(
                items: {1: '小学', 2: '初中', 3: '大学利迈纳的'},
              ),
            ),
            DatePicker(
              initial: DateTime.now(),
              first: DateTime.now().add(const Duration(days: -30)),
              last: DateTime.now().add(const Duration(days: 30)),
              onChanged: (d) {
                print(d);
              },
            ),
            const DeleteButton(title: Text("Delete\nButton")),
            const CheckButton(title: Text("DeleteButton")),
            Wrap(
              spacing: 10,
              children: [
                FilledButton(
                    onPressed: () {
                      desktopState('toggle');
                    },
                    child: const Text("toggle")),
                FilledButton(
                    onPressed: () {
                      desktopState('max');
                    },
                    child: const Text("max")),
                FilledButton(
                    onPressed: () {
                      desktopState('min');
                    },
                    child: const Text("min"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
