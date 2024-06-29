import 'package:learn/register.dart';
import 'package:kit/def.dart';
import 'package:pkg1/register.dart';
import 'package:pkg2/register.dart';

const Iterable<Register Function()> registers = [
  learn,
  pkg1,
  pkg2,
  //根据项目大小，继续拆分页面或组建，拆分原则：业务独立/功能专一/功能复杂
  //....
];
