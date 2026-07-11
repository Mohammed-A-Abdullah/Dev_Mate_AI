import 'package:dev_mate_ai/features/generate_readme/domain/entities/generate_readme_entity.dart';

abstract class GenerateReadmeRepository {
  Future<String> generateReadme(GenerateReadmeEntity request);
}
