import 'package:injectable/injectable.dart';

/// The reason of this helper class is to keep testable the class that needs to work with DateTime.now()
@injectable
class DateTimeHelper {
  DateTime get now => DateTime.now();
}
