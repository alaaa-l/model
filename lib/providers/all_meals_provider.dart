import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:application/models/meal.dart';
import 'package:application/data/dummy_data.dart';

final allmealsProvider = Provider((ref) {
  return dummy_data;
});
