import 'secure_storage_service.dart';
import 'shared_prefs_service.dart';
import 'hive_storage_service.dart';

import 'package:flutter_starter_project_dev/core/storage/storage_constant.dart';

// =============================================================================
// STEP 1: Bootstrapping in main.dart
// =============================================================================
void initializeStorageServices() async {
  // 1. Initialize Hive DB Engine
  await HiveStorageService.init();

  // 2. Initialize Shared Preferences Instance
  final sharedPrefsService = await SharedPrefsService.init();

  // 3. Instantiate Secure Storage Service
  final secureStorageService = SecureStorageService();

  // 4. Instantiate Hive Service
  final hiveService = HiveStorageService();

  // ===========================================================================
  // STEP 2: Usage Examples Across Features
  // ===========================================================================

  // --- Shared Preferences Example (Theme / Onboarding Flag) ---
  await sharedPrefsService.setBool(StorageConstants.keyIsFirstLaunch, false);
  final isFirstLaunch = sharedPrefsService.getBool(
    StorageConstants.keyIsFirstLaunch,
  );
  print('Is First Launch: $isFirstLaunch');

  // --- Secure Storage Example (JWT Tokens) ---
  await secureStorageService.write(
    StorageConstants.keyAuthToken,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  );
  final token = await secureStorageService.read(StorageConstants.keyAuthToken);
  print('Retrieved Encrypted Token: $token');

  // --- Hive Example (Caching User Profile DTO / JSON) ---
  final userCacheMap = {
    'id': 'usr_101',
    'name': 'John Doe',
    'email': 'john@example.com',
  };

  await hiveService.put(
    StorageConstants.boxUserCache,
    'current_user',
    userCacheMap,
  );

  final cachedUser = await hiveService.get<Map>(
    StorageConstants.boxUserCache,
    'current_user',
  );
  print('Cached User Profile Name: ${cachedUser?['name']}');
}
