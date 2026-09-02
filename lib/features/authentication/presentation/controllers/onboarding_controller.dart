import 'package:flutter/foundation.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingController extends ChangeNotifier {
  final List<OnboardingItem> items = const [
    OnboardingItem(
      title: 'Welcome aboard',
      description: 'Manage your account and stay in sync everywhere.',
      imageUrl: 'https://picsum.photos/seed/onboard-1/400/300',
    ),
    OnboardingItem(
      title: 'Fast access',
      description: 'Login quickly with secure authentication and saved sessions.',
      imageUrl: 'https://picsum.photos/seed/onboard-2/400/300',
    ),
    OnboardingItem(
      title: 'Stay protected',
      description: 'Your personal data is protected with modern security flows.',
      imageUrl: 'https://picsum.photos/seed/onboard-3/400/300',
    ),
  ];

  int _currentPage = 0;

  int get currentPage => _currentPage;
  bool get isLastPage => _currentPage == items.length - 1;

  void nextPage() {
    if (_currentPage < items.length - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void skip() {
    _currentPage = items.length - 1;
    notifyListeners();
  }
}
