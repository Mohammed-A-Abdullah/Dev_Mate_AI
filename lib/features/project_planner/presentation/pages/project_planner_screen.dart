import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/project_plan_cubit.dart';
import '../cubit/project_plan_state.dart';
import '../widgets/custom_project_planner_text_field.dart';
import 'project_planner_constant.dart';

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
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    final state = context.read<ProjectPlanCubit>().state;
    _titleController.text = state.title;
    _descriptionController.text = state.description;

    _titleController.addListener(() {
      context.read<ProjectPlanCubit>().updateTitle(_titleController.text);
    });
    _descriptionController.addListener(() {
      context.read<ProjectPlanCubit>().updateDescription(
        _descriptionController.text,
      );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectPlanCubit, ProjectPlanState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ProjectPlanCubit>().clearError();
        }
        if (state.planResult != null && !state.isLoading) {
          final navigator = GoRouter.of(context);
          Future.microtask(() async {
            final prompt = [
              'Project Title: ${state.title}',
              'Description: ${state.description}',
              'Platform: ${state.platform}',
              'Language: ${state.programmingLanguage}',
              'Experience: ${state.experienceLevel}',
              'Architecture: ${state.architecture}',
              'Deadline: ${state.deadline}',
              'Deployment: ${state.deploymentTarget}',
            ].join('\n');

            try {
              await FirebaseChatDataSource(
                firestore: FirebaseFirestore.instance,
              ).saveQuickToolConversation(
                title: 'Project Planner',
                type: 'Project Planner',
                prompt: prompt,
                response: state.planResult!,
              );
            } catch (_) {}

            if (!mounted) return;
            navigator.pushNamed(
              RouteName.ansewerEplainCode,
              extra: state.planResult,
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const CustomAppBar(title: 'Project Planner'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  CustomProjectPlannerTextField(
                    controller: _titleController,
                    title: 'Project Title',
                    description: 'Enter your project name here...',
                  ),
                  const HeightSpace(height: 20),
                  CustomProjectPlannerTextField(
                    controller: _descriptionController,
                    title: 'Project Description',
                    description: 'Enter a brief description of your project...',
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: 'Platform',
                    hintText: 'Select platform',
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
                    labelText: 'Programming Language',
                    hintText: 'Select programming language',
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
                    labelText: 'Experience Level',
                    hintText: 'Select experience level',
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
                    labelText: 'Architecture',
                    hintText: 'Select architecture',
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
                    labelText: 'Deadline',
                    hintText: 'Select deadline',
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
                    labelText: 'Deployment Target',
                    hintText: 'Select deployment target',
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
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    text: 'Plan Project',
                    isLoading: state.isLoading,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<ProjectPlanCubit>().generatePlan();
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
