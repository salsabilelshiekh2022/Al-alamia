import 'dart:async';

import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/transactions_cubit.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<TransactionsCubit>();
    _controller = TextEditingController(text: cubit.searchFilter ?? '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _requestSearch(String value) {
    final cubit = context.read<TransactionsCubit>();
    final normalizedSearch = value.trim();
    final currentSearch = cubit.searchFilter ?? '';

    if (normalizedSearch == currentSearch) {
      return;
    }

    cubit.getTransactionList(
      transaction: cubit.state.currentFilter,
      status: cubit.statusFilters,
      fromDate: cubit.fromDateFilter,
      toDate: cubit.toDateFilter,
      search: normalizedSearch.isEmpty ? null : normalizedSearch,
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      _requestSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        style: context.textStyles.font15MediumGrayColor.copyWith(
          color: context.colors.whiteColor,
        ),
        controller: _controller,
        onChanged: _onSearchChanged,
        cursorColor: context.colors.whiteColor,
        onFieldSubmitted: (value) {
          _debounce?.cancel();
          _requestSearch(value);
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
          _debounce?.cancel();
          _requestSearch(_controller.text);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: context.search,
          hintStyle: context.textStyles.font15MediumGrayColor.copyWith(
            color: context.colors.whiteColor,
          ),
          filled: true,
          fillColor: context.colors.whiteColor.withValues(alpha: 0.12),
          border: _buildBorder(context),
          enabledBorder: _buildBorder(context),
          focusedBorder: _buildBorder(
            context,
            color: context.colors.whiteColor,
          ),

          prefixIcon: CustomSvgBuilder(
            path: AppAssets.svgsSearchIcon,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context, {Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: color ?? context.colors.whiteColor.withValues(alpha: 0.22),
        width: 1,
      ),
    );
  }
}
