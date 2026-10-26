import 'package:base_ui/base_ui.dart';
import 'package:base_project/generated/assets.gen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';

class PlusMinusWidget extends StatefulWidget {
  final int? value;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;
  final double space;
  final dynamic label;
  final bool isExpanded;
  final double iconSize;

  const PlusMinusWidget({
    super.key,
    this.value,
    this.min = 1,
    this.max = 100000,
    this.onChanged,
    this.space = 10,
    this.label,
    this.isExpanded = true,
    this.iconSize = 14,
  });

  @override
  State<PlusMinusWidget> createState() => _PlusMinusWidgetState();
}

class _PlusMinusWidgetState extends State<PlusMinusWidget> {
  int _value = 1;

  @override
  void initState() {
    _setupValue();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PlusMinusWidget oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value ?? -1;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setupValue() {
    _value = widget.value ?? widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_value >= (widget.min))
            InkWell(
              onTap: () {
                if (_value > (widget.min)) {
                  _value--;
                  setState(() {});

                  _onchange(_value);
                } else {
                  AppDialog.showDialogOverlay(
                    context,
                    message: 'Số lượng không thể nhỏ hơn ${widget.min}',
                    status: DialogStatus.success,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
                child: MyAssets.icons.iconMinusLinear.svg(
                  width: widget.iconSize,
                  height: widget.iconSize,
                ),
              ),
            ),
          if (_value > 0)
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 24),
              child: Center(
                child: Text(
                  '$_value',
                  style: context.textStyles.body2SemiBold.copyWith(
                    color: AppColors.neutral900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          InkWell(
            onTap: () {
              if (_value < widget.max) {
                _value++;
                setState(() {});

                _onchange(_value);
              } else {
                AppDialog.showDialogOverlay(
                  context,
                  message: 'Số lượng không thể lớn hơn ${widget.max}',
                  status: DialogStatus.success,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
              child: MyAssets.icons.iconAddLinear.svg(
                width: widget.iconSize,
                height: widget.iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onchange(int val) {
    if (widget.onChanged != null) {
      widget.onChanged!(_value);
    }
  }
}
