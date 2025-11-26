// import 'package:base_ui/base_ui.dart';
// import 'package:base_ui/typography/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:vcc/generated/assets.gen.dart';
//
// class SearchTextFieldWidget extends HookConsumerWidget {
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Function(String content)? onChanged;
//   final Function(String content)? onSubmitted;
//   final String? hintText;
//   final TextStyle? style;
//   final Color? borderColor;
//   final List<TextInputFormatter>? inputFormatters;
//
//   const SearchTextFieldWidget({
//     super.key,
//     this.controller,
//     this.focusNode,
//     this.autofocus = false,
//     this.onChanged,
//     this.onSubmitted,
//     this.hintText,
//     this.style,
//     this.borderColor,
//     this.inputFormatters,
//   });
//
//   @override
//   Widget build(BuildContext context, ref) {
//     var content = useState('');
//
//     return Container(
//       width: double.infinity,
//       height: 40,
//       decoration: BoxDecoration(
//         color: context.colors.backgroundWhite,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: borderColor ?? context.colors.borderDefault,
//           width: 1,
//         ),
//       ),
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         style: style ?? context.textStyles.titleNormal,
//         autofocus: autofocus,
//         textInputAction: TextInputAction.search,
//         keyboardType: TextInputType.text,
//         inputFormatters: inputFormatters,
//         onChanged: (value) {
//           content.value = value;
//           onChanged?.call(value);
//         },
//         onSubmitted: onSubmitted,
//         decoration: InputDecoration(
//           suffixIcon:
//               content.value.isNotEmpty || (controller?.text ?? '').isNotEmpty
//                   ? InkWell(
//                       onTap: () {
//                         controller?.clear();
//                         content.value = '';
//                         onChanged?.call('');
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: BaseAssets.icons.iconCloseCircle.svg(),
//                       ),
//                     )
//                   : null,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: BaseAssets.icons.iconSearchS20.svg(),
//           ),
//           hintText: hintText ?? 'Tìm kiếm',
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.only(left: 8, top: 4),
//           hintStyle: context.textStyles.body2Regular.copyWith(
//             color: context.colors.textPlaceholder,
//           ),
//         ),
//       ),
//     );
//   }
// }
