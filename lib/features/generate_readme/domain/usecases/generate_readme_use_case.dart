import '../entities/generate_readme_entity.dart';
import '../repositories/generate_readme_repository.dart';

class GenerateReadmeUseCase {
  final GenerateReadmeRepository repository;

  GenerateReadmeUseCase(this.repository);

  Future<String> call(GenerateReadmeEntity request) {
    return repository.generateReadme(request);
  }
}
