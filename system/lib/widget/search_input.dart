import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class SearchInput extends StatefulWidget {
  final String hintText;
  final void Function(String text) onSearchTap;

  const SearchInput({
    super.key,
    required this.onSearchTap,
    this.hintText = "搜索",
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController controller = TextEditingController();

  String text = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.r,
      height: 24.r,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.r,
          ),
          Icon(
            Icons.search,
            size: 16.r,
            color: Colors.grey,
          ),
          Expanded(
            child: SizedBox(
              // height: height,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 14.r),
                maxLines: 1,
                onChanged: (String text) {
                  this.text = text;
                  setState(() {});
                },
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 14.r,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5.r),
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: const Color.fromRGBO(153, 153, 153, 1),
                    fontSize: 14.r,
                  ),
                ),
              ),
            ),
          ),
          if (text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 5.r),
              child: InkWell(
                child: Icon(
                  Icons.highlight_remove_sharp,
                  size: 18.r,
                  color: Colors.grey,
                ),
                onTap: () {
                  controller.clear();
                  widget.onSearchTap("");
                },
              ),
            ),
          SizedBox(
            width: 5.r,
          ),
          InkWell(
            onTap: () => widget.onSearchTap(text),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.r),
              color: Theme.of(context).primaryColor,
              height: double.infinity,
              child: const Text(
                "搜索",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
