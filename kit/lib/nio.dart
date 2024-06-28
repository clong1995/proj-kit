//请求数据基类
class BaseReq {
  int t = 0;
  String a = "";

  Map<String, dynamic> toJson() {
    return {
      "t": t,
      "a": a,
    };
  }
}

//返回数据基类
abstract class BaseRes {
  String state = "ERROR";
  dynamic data;

  //解析json字符串
  void fromJson();
}

//空请求数据
class EmptyReq extends BaseReq {}

//空返回数据
class EmptyRes extends BaseRes {
  @override
  void fromJson() {}
}
