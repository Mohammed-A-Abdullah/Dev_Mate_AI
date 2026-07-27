import '../entities/generate_readme_entity.dart';

abstract class GenerateReadmeRepository {
  Future<String> generateReadme(GenerateReadmeEntity request);
}
