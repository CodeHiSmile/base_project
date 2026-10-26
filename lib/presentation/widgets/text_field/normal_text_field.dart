import 'package:base_ui/base_ui.dart';
import 'package:base_project/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final Function(String content)? onChanged;
  final Function(String content)? onSubmitted;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType keyboardType;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? style;
  final Color? borderColor;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  final TextInputAction textInputAction;

  final List<TextInputFormatter> inputFormatters;

  final String? Function(String? value)? validator;

  final bool showErrorOnFocus;

  final bool obscureText;

  final int? minLines;

  final int? maxLines;

  final bool isRequired;

  final bool enabled;

  final bool readOnly;

  final Widget? prefix;

  final Widget? suffix;

  final TextAlign textAlign;

  final bool showClearIcon;

  final double height;

  final String? suffixText;

  final String? labelText;

  final Color? backgroundColor;

  const NormalTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.style,
    this.borderColor,
    this.hintTextStyle,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.showErrorOnFocus = true,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius,
    this.border,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.showClearIcon = true,
    this.height = 48,
    this.suffixText,
    this.labelText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: maxLines == 1 ? height : null,
      decoration: BoxDecoration(
        color: enabled
            ? backgroundColor ?? context.colors.backgroundWhite
            : context.colors.backgroundGray,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border: Border.all(
          color: borderColor ?? context.colors.borderDefault,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: textAlign,
        focusNode: focusNode,
        style: style ?? context.textStyles.normal,
        autofocus: autofocus,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        enabled: enabled,
        onChanged: (value) {
          onChanged?.call(value);
        },
        onFieldSubmitted: onSubmitted,
        textCapitalization: textCapitalization,
        autovalidateMode: autoValidateMode,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        buildCounter:
            (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              return null;
            },
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText ?? '',
          suffixText: suffixText,
          labelText: labelText,
          suffixStyle: style ?? context.textStyles.normal,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding:
              contentPadding ??
              const EdgeInsets.only(left: 16, right: 16, top: 14),
          hintStyle:
              hintTextStyle ??
              context.textStyles.body2Regular.copyWith(
                color: context.colors.textPlaceholder,
              ),
          suffixIcon: showClearIcon
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        controller?.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: MyAssets.icons.iconCloseCircle.svg(),
                      ),
                    ),
                    suffix ?? const SizedBox(),
                  ],
                )
              : suffix,
          prefixIcon: prefix,
        ),
      ),
    );
  }
}
