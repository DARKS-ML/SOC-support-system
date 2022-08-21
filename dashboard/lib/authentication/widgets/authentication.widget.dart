import 'package:flutter/material.dart';

class AuthWidgets {
  // @desc ->  TextForm Field
  static Widget buildTextFormField({
    double? horizontalPadding,
    String? hintText,
    TextEditingController? textEditingController,
  }) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0,
          ),
          border: const OutlineInputBorder(),
          hintText: hintText ?? "",
          label: Text(hintText ?? "")),
    );
  }

  // @desc -> Custom Button
  static Widget buildButton({
    required size,
    Function()? onTap,
    String? text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: (size.width - size.width / 20) / 2.8,
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Text(
          text ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
