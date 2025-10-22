import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;

  const InputWidget(
    this.hint,
    this.controller, {
    this.obscureText = false,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    );

    if (!widget.obscureText) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: widget.controller,
          obscureText: false,
          enabled: true,
          readOnly: !widget.enabled,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            labelText: widget.hint,
            border: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscure,
        enabled: true,
        readOnly: !widget.enabled,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        decoration: InputDecoration(
          labelText: widget.hint,
          border: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[700],
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          ),
        ),
      ),
    );
  }
}
