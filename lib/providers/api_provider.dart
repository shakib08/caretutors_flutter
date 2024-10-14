import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/care_tutors.dart';
import '../services/api_service.dart';

final nasaImageProvider = FutureProvider.family<CareTutors, String>((ref, date) async {
  return ApiService().fetchNasaImage(date);
});
