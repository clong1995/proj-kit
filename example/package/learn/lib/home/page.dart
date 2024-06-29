import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Object? arg;

  const HomePage({super.key, this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ListView(
            children: [
              Center(
                child: Text("""中型项目的组织方式和公共库的管理方案
""",style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Text("""1. 项目组织方式和结构:
    |--xxx项目目录
        |--app        ( 项目类型为 Application, 作为项目运行和打包的主项目 )
        |--package
            |--pkg1   ( 项目类型为 Package, 构成主项目的独立业务或独立功能,无平台依赖,
            |--pkg2   通常为一个业务独立的页面, 
            |--pkg3   或几个连续跳转多个页面完成的一套业务流程 )
        |--common     ( 项目中的一些公共部分 )
"""),
              Text("""2. 中型项目中, 多人参与开发, 应以保证项目结构清晰为主, 全责分明, 低耦合. 
"""),
              Text("""3. 以业务来分割开发边界, 每个独立业务创建一个pkg,
    由一个人负责一个pkg, 或多个人负责多个不同业务的pkg",
    独立的pkg中, 禁止引入另一个pkg, 禁止调用另一个pkg中的函数.
"""),
              Text("""4. 收集项目中的公共函数和组建, 形成公司的 kit->system库, 以便下个项目快速启动
    尽可能所有的第三方库和自己写的库, 由system统一抽象和包装, 再由kit对外提供调用.
    每个pkg中仅引入kit, 禁止直接调用system, 更禁止跨过system调用第三方库.
    项目的架构层级结构为:
    |-------------------------|
    |                 app                  | <-打包为可执行程序的主入口项目
    |-------------------------|
    |      pkg1,pkg2,pkg3....     | <-构成这个项目的子业务模块
    |-------------------------|
    |                   kit                  | <-提供给pkg们的函数的统一开放
    |-------------------------|
    |               system              | <-函数和第三方库扽封装
    |-------------------------|
    |   第三方库1,第三方库2....  | <- 依赖的库
    |-------------------------|
    """),
              Text("""5. 企业项目往往存在大而全的冗余集合库, 
    代码库大, 项目打包大, 冗余代码多. 作为个人项目小而精易维护往往不可接受.
    但对于以盈利为首要目标的企业项目, 迭代快速, 使用的函数经过多个项目验证且稳定, 
    快速启动下一个项目的开发, 更为重要.
"""),
            ],
          ),),
          FilledButton(onPressed: (){}, child: Text("组建库和函数的例子")),
        ],
      ),
    );
  }
}
