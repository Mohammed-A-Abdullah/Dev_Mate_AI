import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';

abstract class DebugCodeRepository {
  Future<String> debugCode(DebugCodeRequestEntity request);
}