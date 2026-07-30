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
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/project_plan_cubit.dart';
import '../cubit/project_plan_state.dart';
import '../widgets/custom_project_planner_text_field.dart';
import '../constants/project_planner_constant.dart';

class ProjectPlannerScreen extends StatelessWidget {
  const ProjectPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProjectPlanCubit>(),
      child: const ProjectPlannerView(),
    );
  }
}

class ProjectPlannerView extends StatefulWidget {
  const ProjectPlannerView({super.key});

  @override
  State<ProjectPlannerView> createState() => _ProjectPlannerViewState();
}

class _ProjectPlannerViewState extends State<ProjectPlannerView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Timer? _slowLoadingTimer;
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _slowLoadingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocConsumer<ProjectPlanCubit, ProjectPlanState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage ||
          previous.planResult != current.planResult,
      listener: (context, state) {
        if (state.isLoading) {
          _slowLoadingTimer?.cancel();
          _slowLoadingTimer = Timer(const Duration(seconds: 4), () {
            if (mounted && state.isLoading) {
              CustomSnackBar.show(
                context,
                message: S.of(context).processingMayTakeLonger,
                backgroundColor: Theme.of(context).colorScheme.primary,
                time: 8,
                textColor: Theme.of(context).colorScheme.onPrimary,
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
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
          context.read<ProjectPlanCubit>().clearError();
        }

        if (state.planResult != null && !state.isLoading) {
          context.pushNamed(
            RouteName.ansewerEplainCode,
            extra: state.planResult,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(title: local.projectPlanner),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 20),
                  CustomProjectPlannerTextField(
                    controller: _titleController,
                    title: local.projectTitle,
                    description: local.enterProjectName,
                  ),
                  const HeightSpace(height: 20),
                  CustomProjectPlannerTextField(
                    controller: _descriptionController,
                    title: local.projectDes,
                    description: local.enterProjectDes,
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.platform,
                    hintText: local.selectPlatform,
                    items: ProjectPlannerConstant.platforms,
                    initialValue: state.platform,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProjectPlanCubit>().updatePlatform(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.programmingLang,
                    hintText: local.selectProgrammingLang,
                    items: LanguageHelper.languages,
                    initialValue: state.programmingLanguage,
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<ProjectPlanCubit>()
                            .updateProgrammingLanguage(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.experienceLevel,
                    hintText: local.selectExperienceLevel,
                    items: ProjectPlannerConstant.experienceLevel,
                    initialValue: state.experienceLevel,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProjectPlanCubit>().updateExperienceLevel(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.architecture,
                    hintText: local.selectArchitecture,
                    items: ProjectPlannerConstant.architectures,
                    initialValue: state.architecture,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProjectPlanCubit>().updateArchitecture(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.deadline,
                    hintText: local.selectDeadline,
                    items: ProjectPlannerConstant.deadline,
                    initialValue: state.deadline,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProjectPlanCubit>().updateDeadline(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.deploymentTarget,
                    hintText: local.selectDeploymentTarget,
                    items: ProjectPlannerConstant.deploymentTarget,
                    initialValue: state.deploymentTarget,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProjectPlanCubit>().updateDeploymentTarget(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 30),
                  CustomFeatureButton(
                    text: local.planProject,
                    isLoading: state.isLoading,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<ProjectPlanCubit>().generatePlan(
                              title: _titleController.text,
                              description: _descriptionController.text,
                            );
                            FocusScope.of(context).unfocus();
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
