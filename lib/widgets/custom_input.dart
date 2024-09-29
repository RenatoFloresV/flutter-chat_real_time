import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {super.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.onChanged,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.keyboardType = TextInputType.text});

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final Function()? onTap;
  final Function(String)? onChanged;
  final bool obscureText;

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
              child: TextField(
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    suffixIcon: widget.suffixIcon != null
                        ? GestureDetector(
                            onTap: () {
                              _obscureText = !_obscureText;
                              setState(() {});
                            },
                            child: Icon(widget.suffixIcon))
                        : const SizedBox(),
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(widget.prefixIcon)
                        : const SizedBox()),
              ),
            ),
            if (widget.helperText != null)
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(widget.helperText!),
              )
          ],
        ));
  }
}
