import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';

class CustomFormField extends FormField<String> {
  const CustomFormField({
    super.key,
    super.initialValue,
    super.validator,
    super.onSaved,
    bool autoValidateMode = false,
    required super.builder,
  }) : super(
         autovalidateMode: autoValidateMode
             ? AutovalidateMode.always
             : AutovalidateMode.disabled,
       );
}

/// Primary text form field
class DropdownCustomWidget extends StatefulWidget {
  /// label text
  final String? labelText;

  /// Label suffix
  final Widget? labelSuffix;

  /// hint text
  final String? hintText;

  ///value
  final String? content;

  /// show error on focus or not
  final bool showErrorOnFocus;

  /// Height text field
  final double? height;

  /// Is TextFormField required
  final bool isRequired;

  /// Is enabled
  final bool enabled;

  /// Read only mode
  final bool readOnly;

  /// onClear callback
  final VoidCallback? onClear;

  /// Prefix
  final Widget? prefix;

  /// Suffix
  final Widget? suffix;

  /// AlignmentGeometry
  final AlignmentGeometry? alignment;

  /// On tap text field
  final VoidCallback? onTap;

  final String? Function(String?)? validator;

  final Widget? contentWidget;

  const DropdownCustomWidget({
    super.key,
    this.labelText,
    this.labelSuffix,
    this.hintText,
    this.showErrorOnFocus = true,
    this.height = 44,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.onClear,
    this.alignment = Alignment.center,
    this.onTap,
    this.prefix,
    this.suffix,
    this.content,
    this.validator,
    this.contentWidget,
  });

  @override
  State<DropdownCustomWidget> createState() => _DropdownCustomWidgetState();
}

class _DropdownCustomWidgetState extends State<DropdownCustomWidget> {
  String? _errorString;
  bool _hasError = false;

  TextStyle _textFieldStyle() {
    return context.textStyles.body2Regular.copyWith(
      color: widget.enabled
          ? context.colors.backgroundBlack
          : context.colors.secondary,
    );
  }

  TextStyle _errorTextStyle() {
    return context.textStyles.caption1Medium.copyWith(
      color: context.colors.error,
    );
  }

  Color _borderColor({required bool enabled, required bool hasError}) {
    return enabled
        ? hasError
              ? context.colors.errorBorder
              : AppColors.neutral100
        : context.colors.backgroundDisable;
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.content ?? '').isNotEmpty) {
      _errorString = "";
      _hasError = false;
    }

    return CustomFormField(
      initialValue: '',
      validator: (value) {
        setState(() {
          String? errorString = widget.validator?.call(widget.content ?? '');
          _errorString = errorString;
          if ((_errorString ?? '').isNotEmpty) {
            _hasError = true;
          } else {
            _hasError = false;
          }
        });
        return _errorString;
      },
      onSaved: (value) {},
      builder: (FormFieldState<String> state) {
        return InkWellWidget(
          onTap: () {
            if (widget.enabled) {
              FocusScope.of(context).unfocus();
              widget.onTap?.call();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.labelText != null) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: _buildExternalLabel(),
                ),
              ],
              Container(
                constraints: BoxConstraints(minHeight: widget.height ?? 44),
                alignment: widget.alignment,
                padding: EdgeInsets.only(
                  left: widget.prefix != null ? 16 : 0,
                  right: widget.suffix != null ? 16 : 0,
                ),
                decoration: BoxDecoration(
                  color: _backgroundColor(
                    enabled: widget.enabled,
                    hasError: _hasError,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _borderColor(
                      enabled: widget.enabled,
                      hasError: _hasError,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    if (widget.prefix != null) ...[
                      SizedBox(height: 20, width: 20, child: widget.prefix!),
                    ],
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child:
                            (widget.content ?? '').isNotEmpty ||
                                widget.contentWidget != null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    widget.contentWidget ??
                                    Text(
                                      widget.content ?? '',
                                      style: _textFieldStyle(),
                                    ),
                              )
                            : Text(
                                widget.hintText ?? '',
                                style: context.textStyles.body2Regular.copyWith(
                                  color: AppColors.neutral500,
                                ),
                              ),
                      ),
                    ),
                    if (widget.suffix != null) ...[
                      SizedBox(height: 20, width: 20, child: widget.suffix!),
                    ],
                  ],
                ),
              ),
              if ((_errorString ?? '').isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 4),
                  child: Text(_errorString!, style: _errorTextStyle()),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Color _backgroundColor({required bool enabled, required bool hasError}) {
    if (!enabled) {
      return context.colors.backgroundDisable;
    }
    return AppColors.neutral50;
  }

  Widget _buildExternalLabel() {
    final labelStyle = context.textStyles.body2Regular.copyWith(
      color: AppColors.neutral500,
    );
    final requiredStyle = labelStyle.copyWith(color: context.colors.error);

    if (widget.labelSuffix != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: labelStyle,
              children: <TextSpan>[
                TextSpan(text: widget.labelText ?? ''),
                if (widget.isRequired) ...[
                  TextSpan(text: ' *', style: requiredStyle),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          widget.labelSuffix!,
        ],
      );
    }

    return RichText(
      text: TextSpan(
        style: labelStyle,
        children: <TextSpan>[
          TextSpan(text: widget.labelText ?? ''),
          if (widget.isRequired) ...[
            TextSpan(text: ' *', style: requiredStyle),
          ],
        ],
      ),
    );
  }
}
