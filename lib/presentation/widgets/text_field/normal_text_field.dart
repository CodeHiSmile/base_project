// import 'package:base_ui/base_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class NormalTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Function(String content)? onChanged;
//   final Function(String content)? onSubmitted;
//   final String? hintText;
//   final TextStyle? hintTextStyle;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextInputType keyboardType;
//   final AutovalidateMode? autoValidateMode;
//   final TextStyle? style;
//   final Color? borderColor;
//   final int? maxLength;
//   final TextCapitalization textCapitalization;
//   final BorderRadiusGeometry? borderRadius;
//   final BoxBorder? border;
//
//   /// An action the user has requested the text input control to perform.
//   final TextInputAction textInputAction;
//
//   /// Text input formatters
//   final List<TextInputFormatter> inputFormatters;
//
//   /// Text input validator
//   final String? Function(String? value)? validator;
//
//   /// show error on focus or not
//   final bool showErrorOnFocus;
//
//   /// obscureText
//   final bool obscureText;
//
//   /// Text min line
//   final int? minLines;
//
//   /// Text max line
//   final int? maxLines;
//
//   /// Is TextFormField required
//   final bool isRequired;
//
//   /// Is enabled
//   final bool enabled;
//
//   /// Read only mode
//   final bool readOnly;
//
//   /// Prefix
//   final Widget? prefix;
//
//   /// Suffix
//   final Widget? suffix;
//
//   final TextAlign textAlign;
//
//   final bool showClearIcon;
//
//   final double height;
//
//   final String? suffixText;
//
//   final String? labelText;
//
//   const NormalTextField({
//     super.key,
//     this.controller,
//     this.focusNode,
//     this.autofocus = false,
//     this.onChanged,
//     this.onSubmitted,
//     this.hintText,
//     this.style,
//     this.borderColor,
//     this.hintTextStyle,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.inputFormatters = const [],
//     this.showErrorOnFocus = true,
//     this.obscureText = false,
//     this.minLines = 1,
//     this.maxLines = 1,
//     this.isRequired = false,
//     this.enabled = true,
//     this.readOnly = false,
//     this.autoValidateMode = AutovalidateMode.onUserInteraction,
//     this.prefix,
//     this.suffix,
//     this.maxLength,
//     this.validator,
//     this.textCapitalization = TextCapitalization.none,
//     this.borderRadius,
//     this.border,
//     this.contentPadding,
//     this.textAlign = TextAlign.start,
//     this.showClearIcon = true,
//     this.height = 48,
//     this.suffixText,
//     this.labelText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: height,
//       decoration: BoxDecoration(
//         color: enabled
//             ? context.colors.backgroundWhite
//             : context.colors.backgroundGray,
//         borderRadius: borderRadius ?? BorderRadius.circular(10),
//         border: Border.all(
//           color: borderColor ?? context.colors.borderDefault,
//           width: 1,
//         ),
//       ),
//       child: TextFormField(
//         controller: controller,
//         textAlign: textAlign,
//         focusNode: focusNode,
//         style: style ?? context.textStyles.normal,
//         autofocus: autofocus,
//         textInputAction: textInputAction,
//         keyboardType: keyboardType,
//         readOnly: readOnly,
//         inputFormatters: inputFormatters,
//         enabled: enabled,
//         onChanged: (value) {
//           content.value = value;
//           onChanged?.call(value);
//         },
//         onFieldSubmitted: onSubmitted,
//         textCapitalization: textCapitalization,
//         autovalidateMode: autoValidateMode,
//         maxLength: maxLength,
//         maxLines: maxLines,
//         minLines: minLines,
//         buildCounter:
//             (
//               BuildContext context, {
//               required int currentLength,
//               required bool isFocused,
//               required int? maxLength,
//             }) {
//               return null;
//             },
//         validator: validator,
//         decoration: InputDecoration(
//           isDense: true,
//           hintText: hintText ?? '',
//           suffixText: suffixText,
//           labelText: labelText,
//           suffixStyle: style ?? context.textStyles.normal,
//           border: InputBorder.none,
//           errorBorder: InputBorder.none,
//           focusedErrorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           contentPadding:
//               contentPadding ??
//               const EdgeInsets.only(left: 16, right: 16, top: 14),
//           hintStyle:
//               hintTextStyle ??
//               context.textStyles.body2Regular.copyWith(
//                 color: context.colors.textPlaceholder,
//               ),
//           suffixIcon: showClearIcon && content.value.isNotEmpty
//               ? Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         controller?.clear();
//                         content.value = '';
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: BaseAssets.icons.iconCloseCircle.svg(),
//                       ),
//                     ),
//                     suffix ?? const SizedBox(),
//                   ],
//                 )
//               : suffix,
//           prefixIcon: prefix,
//         ),
//       ),
//     );
//   }
// }
