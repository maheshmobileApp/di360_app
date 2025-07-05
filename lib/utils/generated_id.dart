import 'package:uuid/uuid.dart';

class GeneratedId {
  
  static String generateId() {

var uuid = Uuid();
    return  uuid.v4();
  }
}