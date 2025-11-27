import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

typedef FormFieldValidator<T> = String? Function(T? value);

/// Primary text form field
class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.labelTextStyle,
    this.labelSuffix,
    this.hintText,
    this.hintTextStyle,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.autofocus = false,
    this.showErrorOnFocus = true,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.height = 56,
    this.isRequired = false,
    this.enabled = true,
    this.clear = true,
    this.readOnly = false,
    this.onClear,
    this.alignment = Alignment.center,
    this.onChanged,
    this.onTap,
    this.scrollPadding,
    this.contextMenuBuilder,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onFieldSubmitted,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.focusNode,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius,
    this.border,
    this.contentPadding,
    this.isTextArea = false,
    this.onFocusChange,
    this.maxSizeSuffix,
  });

  /// text form field are
  const TextFieldWidget.area({
    super.key,
    required this.controller,
    this.labelText,
    this.labelTextStyle,
    this.labelSuffix,
    this.hintText,
    this.hintTextStyle,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.inputFormatters,
    this.autofocus = false,
    this.showErrorOnFocus = true,
    this.obscureText = false,
    this.minLines,
    this.maxLines,
    this.height,
    this.isRequired = false,
    this.enabled = true,
    this.clear = true,
    this.readOnly = false,
    this.onClear,
    this.alignment = const Alignment(0, 0),
    this.onChanged,
    this.onTap,
    this.scrollPadding,
    this.contextMenuBuilder,
    this.autovalidateMode,
    this.onFieldSubmitted,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.focusNode,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius,
    this.border,
    this.contentPadding,
    this.isTextArea = true,
    this.onFocusChange,
    this.maxSizeSuffix,
  });

  /// if controller is null, a private widget controller will be used instead
  final TextEditingController controller;

  /// label text
  final String? labelText;

  final TextStyle? labelTextStyle;

  /// Label suffix
  final Widget? labelSuffix;

  /// hint text
  final String? hintText;

  final TextStyle? hintTextStyle;

  final EdgeInsetsGeometry? contentPadding;

  /// keyboard input type
  final TextInputType keyboardType;

  final AutovalidateMode? autovalidateMode;

  final ValueChanged<String?>? onFieldSubmitted;

  final int? maxLength;

  final FocusNode? focusNode;

  final TextCapitalization textCapitalization;

  final BorderRadiusGeometry? borderRadius;

  final BoxBorder? border;

  /// auto focus
  final bool autofocus;

  /// An action the user has requested the text input control to perform.
  final TextInputAction textInputAction;

  /// Text input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Text input validator
  final String? Function(String)? validator;

  /// show error on focus or not
  final bool showErrorOnFocus;

  /// obscureText
  final bool obscureText;

  /// Text min line
  final int? minLines;

  /// Text max line
  final int? maxLines;

  /// Height text field
  final double? height;

  /// Is TextFormField required
  final bool isRequired;

  /// Is enabled
  final bool enabled;

  /// Read only mode
  final bool readOnly;

  /// Has clear button or not
  final bool clear;

  /// onClear callback
  final VoidCallback? onClear;

  /// Prefix
  final Widget? prefix;

  /// Suffix
  final Widget? suffix;

  /// AlignmentGeometry
  final AlignmentGeometry? alignment;

  /// Scroll padding
  final EdgeInsets? scrollPadding;

  /// On text change
  final ValueChanged<String>? onChanged;

  /// On tap text field
  final VoidCallback? onTap;

  /// EditableTextContextMenuBuilder
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  final bool isTextArea;

  final ValueChanged<bool>? onFocusChange;

  final bool? maxSizeSuffix;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController _controller;

  bool _hasError = false;
  String? _errorString;
  bool _hasText = false;
  bool _hasFocus = false;

  TextStyle _textFieldStyle() {
    return context.textStyles.body1Regular.copyWith(
      color: widget.enabled
          ? context.colors.backgroundBlack
          : context.colors.secondary,
    );
  }

  TextStyle _errorTextStyle() {
    return context.textStyles.body3Regular.copyWith(
      color: context.colors.primary,
    );
  }

  Color _borderColor({
    required bool enabled,
    required bool hasFocus,
    required bool hasError,
  }) {
    return enabled
        ? hasError
              ? context.colors.primary
              : hasFocus
              ? context.colors.borderFocus
              : context.colors.borderDefault
        : context.colors.borderDefault;
  }

  void _listener() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
      _errorString = widget.validator?.call(_controller.text);
      _hasError = _errorString?.isNotEmpty ?? false;
    });
  }

  @override
  void initState() {
    _controller = widget.controller;
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: widget.height,
              alignment: widget.alignment,
              padding: EdgeInsets.only(
                left: widget.prefix != null ? 16 : 8,
                right: widget.suffix != null ? 16 : 8,
              ),
              decoration: BoxDecoration(
                color: _backgroundColor(
                  enabled: widget.enabled,
                  hasError: _hasError,
                ),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                border:
                    widget.border ??
                    Border.all(
                      color: _borderColor(
                        enabled: widget.enabled,
                        hasFocus: _hasFocus,
                        hasError: _hasError,
                      ),
                    ),
              ),
              child: Row(
                children: [
                  if (widget.prefix != null) ...[
                    SizedBox(height: 24, width: 24, child: widget.prefix!),
                  ],
                  Expanded(
                    child: widget.onTap != null
                        ? IgnorePointer(child: _textFormField())
                        : _textFormField(),
                  ),
                  if (_hasFocus &&
                      widget.clear &&
                      _hasText &&
                      !widget.readOnly &&
                      widget.enabled) ...[
                    _buildClearTextButton(),
                  ],
                  if (widget.suffix != null) ...[
                    (widget.maxSizeSuffix ?? false)
                        ? widget.suffix!
                        : SizedBox(
                            height: 24,
                            width: 24,
                            child: widget.suffix!,
                          ),
                  ],
                ],
              ),
            ),
            if (widget.onTap != null) ...[
              Positioned(
                child: InkWell(
                  onTap: widget.onTap,
                  child: const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (_hasError) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(_errorString ?? '', style: _errorTextStyle()),
          ),
        ],
      ],
    );
  }

  Widget _buildClearTextButton() {
    return Padding(
      padding: EdgeInsets.only(right: widget.suffix == null ? 0 : 8),
      child: InkWell(
        onTap: () {
          _controller.clear();
          setState(() {
            _hasText = false;
          });
          widget.onClear?.call();
        },
        child: BaseAssets.icons.iconCloseCircle.svg(height: 24, width: 24),
      ),
    );
  }

  Widget _textFormField() {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          setState(() {
            _hasFocus = focus;
            if (!focus) {
              _controller.text = _controller.text.trim();
            }
          });
          widget.onFocusChange?.call(focus);
        },
        child: TextFormField(
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          controller: _controller,
          style: _textFieldStyle(),
          autofocus: widget.autofocus,
          obscureText: widget.obscureText,
          focusNode: widget.focusNode,
          cursorColor: context.colors.backgroundBlack,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters ?? [SpaceInputFormatter()],
          autovalidateMode: widget.autovalidateMode,
          textCapitalization: widget.textCapitalization,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          contextMenuBuilder: widget.contextMenuBuilder,
          onFieldSubmitted: widget.onFieldSubmitted,
          scrollPadding:
              widget.scrollPadding ?? const EdgeInsets.only(bottom: 116),
          validator: (value) {
            final errorString = widget.validator?.call(_controller.text);
            _errorString = errorString;
            if ((errorString ?? '').isNotEmpty) {
              _hasError = true;
            } else {
              _hasError = false;
            }

            return _hasError ? '' : null;
          },
          decoration: InputDecoration(
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            label: _label(),
            labelStyle: widget.labelTextStyle,
            hintText: widget.hintText,
            hintStyle:
                widget.hintTextStyle ??
                context.textStyles.body1Regular.copyWith(
                  color: context.colors.textBody,
                ),
            counterText: "",
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            errorStyle: const TextStyle(height: 0),
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ),
    );
  }

  Color _backgroundColor({required bool enabled, required bool hasError}) {
    return enabled
        ? hasError
              ? context.colors.backgroundWhite
              : context.colors.backgroundWhite
        : context.colors.backgroundDisable;
  }

  Widget? _label() {
    if (!widget.isTextArea) {
      if (widget.labelText == null) {
        return null;
      }

      if (widget.labelSuffix != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Label(
              labelText: widget.labelText!,
              enabled: widget.enabled,
              hasFocus: _hasFocus,
              hasError: _hasError,
              hasText: _controller.text.isNotEmpty,
              required: widget.isRequired,
            ),
            if (_controller.text.isNotEmpty) ...[
              const SizedBox(width: 12),
              widget.labelSuffix!,
            ],
          ],
        );
      }

      return _Label(
        labelText: widget.labelText!,
        enabled: widget.enabled,
        hasFocus: _hasFocus,
        hasError: _hasError,
        hasText: _controller.text.isNotEmpty,
        required: widget.isRequired,
      );
    } else {
      if (_hasText) {
        return _Label(
          labelText: widget.hintText ?? '',
          enabled: widget.enabled,
          hasFocus: _hasFocus,
          hasError: _hasError,
          hasText: _controller.text.isNotEmpty,
          required: widget.isRequired,
        );
      } else {
        return null;
      }
    }
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.labelText,
    required this.enabled,
    required this.hasFocus,
    required this.hasError,
    required this.hasText,
    this.required = false,
  });

  final String labelText;

  final bool enabled;
  final bool hasFocus;
  final bool hasError;
  final bool hasText;

  final bool required;

  TextStyle _labelTextStyle(
    BuildContext context, {
    required bool hasText,
    required bool hasFocus,
    required bool hasError,
    required bool enabled,
  }) {
    return hasFocus
        ? context.textStyles.caption1Regular.copyWith(
            color: !hasError ? context.colors.textBody : context.colors.primary,
          )
        : hasText
        ? context.textStyles.caption1Regular.copyWith(
            color: enabled
                ? !hasError
                      ? context.colors.textBody
                      : context.colors.primary
                : context.colors.textBody,
          )
        : context.textStyles.body1Regular.copyWith(
            color: context.colors.textBody,
          );
  }

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = _labelTextStyle(
      context,
      hasText: hasText,
      hasFocus: hasFocus,
      hasError: hasError,
      enabled: enabled,
    );

    final requiredTextStyle = labelTextStyle.copyWith(
      color: context.colors.primary,
    );

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: labelTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: labelText,
            style: context.textStyles.body1Regular.copyWith(
              color: context.colors.textSubtitle,
            ),
          ),
          if (required) ...[TextSpan(text: ' *', style: requiredTextStyle)],
        ],
      ),
    );
  }
}
