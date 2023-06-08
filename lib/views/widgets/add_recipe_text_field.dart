import 'package:flutter/material.dart';

class AddRecipeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  const AddRecipeTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.inputType,
    this.validator,
  }) : super(key: key);

  @override
  _AddRecipeTextFieldState createState() => _AddRecipeTextFieldState();
}

class _AddRecipeTextFieldState extends State<AddRecipeTextField> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateInput);
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      if (widget.validator != null) {
        _errorText = widget.validator!(widget.controller.text);
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: widget.controller,
              cursorHeight: 16,
              cursorColor: Colors.black,
              keyboardType: widget.inputType,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorText != null
                        ? Colors.red
                        : const Color(0xffc6cfdc),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorText != null
                        ? Colors.red
                        : const Color(0xFF848A92),
                  ),
                ),
                errorText: _errorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
