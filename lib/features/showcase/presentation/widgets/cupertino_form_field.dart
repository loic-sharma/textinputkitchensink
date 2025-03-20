import 'package:flutter/cupertino.dart';

class CupertinoFormField extends FormField<String> {
  CupertinoFormField({
    super.key,
    required this.controller,
    this.placeholder,
    super.validator,
    bool obscureText = false,
    IconData? prefixIcon,
    Widget? suffix,
    bool autocorrect = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines,
    TextInputAction? textInputAction,
  }) : super(
         builder: (FormFieldState<String> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               CupertinoTextField(
                 textInputAction: textInputAction,
                 maxLines: maxLines,
                 keyboardType: keyboardType,
                 style: TextStyle(
                   color:
                       state.hasError
                           ? CupertinoColors.destructiveRed
                           : CupertinoColors.black,
                 ),
                 autocorrect: autocorrect,
                 controller: controller,
                 obscureText: obscureText,
                 onChanged: state.didChange,
                 placeholder: placeholder,
                 prefix:
                     prefixIcon == null
                         ? null
                         : Padding(
                           padding: EdgeInsets.only(left: 8),
                           child: Icon(
                             prefixIcon,
                             color:
                                 state.hasError
                                     ? CupertinoColors.destructiveRed
                                     : null,
                           ),
                         ),
                 suffix: suffix,
                 decoration: BoxDecoration(
                   border: Border.all(
                     color:
                         state.hasError
                             ? CupertinoColors.destructiveRed
                             : CupertinoColors.systemGrey,
                     width: 1.0,
                   ),
                   borderRadius: BorderRadius.circular(8.0),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 5.0),
                   child: Text(
                     state.errorText!,
                     style: TextStyle(color: CupertinoColors.destructiveRed),
                   ),
                 ),
             ],
           );
         },
       );

  final String? placeholder;
  final TextEditingController controller;

  @override
  FormFieldState<String> createState() => _CupertinoFormFieldState();
}

class _CupertinoFormFieldState extends FormFieldState<String> {
  @override
  CupertinoFormField get widget => super.widget as CupertinoFormField;
}
