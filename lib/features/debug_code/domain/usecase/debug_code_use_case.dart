import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';
import 'package:dev_mate_ai/features/debug_code/domain/repositories/debug_code_repository.dart';

class DebugCodeUseCase {
  final DebugCodeRepository repository;

  DebugCodeUseCase({required this.repository});
  
  Future<String> call(DebugCodeRequestEntity request){
    return repository.debugCode(request);
  }
}