import 'dart:async';

import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/readme_cubit.dart';
import '../cubit/readme_state.dart';
import '../constants/generarte_readme_constant.dart';
import '../widgets/costom_readme_text_field.dart';

class GenerateReadmeScreen extends StatelessWidget {
  const GenerateReadmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReadmeCubit>(),
      child: const GenerateReadmeView(),
    );
  }
}

class GenerateReadmeView extends StatefulWidget {
  const GenerateReadmeView({super.key});

  @override
  State<GenerateReadmeView> createState() => _GenerateReadmeViewState();
}

class _GenerateReadmeViewState extends State<GenerateReadmeView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _featureController = TextEditingController();
  final _githubLinkController = TextEditingController();
  Timer? _slowLoadingTimer;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _featureController.dispose();
    _githubLinkController.dispose();
    _slowLoadingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocConsumer<ReadmeCubit, ReadmeState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage ||
          previous.readmeResult != current.readmeResult,
      listener: (context, state) {
        if (state.isLoading) {
          _slowLoadingTimer?.cancel();
          _slowLoadingTimer = Timer(const Duration(seconds: 4), () {
            if (mounted && state.isLoading) {
              CustomSnackBar.show(
                context,
                message: S.of(context).processingMayTakeLonger,
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                time: 8,
              );
            }
          });
          
        } else {
          _slowLoadingTimer?.cancel();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
          context.read<ReadmeCubit>().clearError();
        }

        if (state.readmeResult != null && !state.isLoading) {
          context.pushNamed(
            RouteName.readmeResultScreen,
            extra: state.readmeResult,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(title: local.generateReadMe),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 20),
                  CostomReadmeTextField(
                    controller: _titleController,
                    title: local.projectTitle,
                    description: local.enterProjectName,
                  ),
                  const HeightSpace(height: 20),
                  CostomReadmeTextField(
                    controller: _descriptionController,
                    title: local.projectDes,
                    description: local.enterProjectDes,
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.projectType,
                    hintText: local.selectType,
                    initialValue: state.projectType,
                    items: GenerarteReadmeConstant.projectTypes,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ReadmeCubit>().updateProjectType(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  _buildFeatureInput(context, state),
                  const HeightSpace(height: 20),
                  _buildTechnologiesChips(context, state),
                  const HeightSpace(height: 20),
                  CostomReadmeTextField(
                    controller: _githubLinkController,
                    title: local.githubLink,
                    description: local.githubDes,
                    icon: Icons.link,
                  ),
                  const HeightSpace(height: 30),
                  CustomFeatureButton(
                    text: local.generateReadMe,
                    isLoading: state.isLoading,
                    onTap: state.isLoading ? null : _onGeneratePressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onGeneratePressed() {
    context.read<ReadmeCubit>().generateReadme(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      githubLink: _githubLinkController.text.trim(),
    );
    FocusScope.of(context).unfocus();
  }

  Widget _buildFeatureInput(BuildContext context, ReadmeState state) {
    final local = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: _featureController,
          label: local.feature,
          hintText: local.addFeature,
          keyBoardType: TextInputType.multiline,
          suffixIconWidget: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addFeature,
          ),
          onFieldSubmitted: (_) => _addFeature(),
        ),
        if (state.features.isNotEmpty) ...[
          const HeightSpace(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.features.map((feature) {
              return Chip(
                backgroundColor: Theme.of(context).colorScheme.outline,
                label: Text(
                  feature,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onDeleted: () =>
                    context.read<ReadmeCubit>().removeFeature(feature),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  void _addFeature() {
    final text = _featureController.text.trim();
    if (text.isNotEmpty) {
      context.read<ReadmeCubit>().addFeature(text);
      _featureController.clear();
    }
  }

  Widget _buildTechnologiesChips(BuildContext context, ReadmeState state) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: GenerarteReadmeConstant.technologies.map((tech) {
        final selected = state.technologies.contains(tech);

        return FilterChip(
          showCheckmark: false,
          backgroundColor: colorScheme.outline,
          selectedColor: colorScheme.secondary,
          label: Text(
            tech,
            style: GoogleFonts.inter(
              color: selected ? colorScheme.outline : colorScheme.secondary,
            ),
          ),
          selected: selected,
          onSelected: (_) => context.read<ReadmeCubit>().toggleTechnology(tech),
        );
      }).toList(),
    );
  }
}
