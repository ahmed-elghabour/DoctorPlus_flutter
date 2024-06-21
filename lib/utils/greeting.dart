String getGreeting() {
  final now = DateTime.now();
  if (now.hour < 12) {
    return 'Good Morning ';
  } else {
    return 'Good Evening ';
  }
}