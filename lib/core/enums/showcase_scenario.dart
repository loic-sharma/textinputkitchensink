enum ShowcaseScenario {
  login(
    title: 'Login',
    description: 'Demonstrate login form with email and password fields',
  ),
  purchase(
    title: 'Purchase',
    description: 'Showcase purchase form with autofill capabilities',
  ),
  profile(
    title: 'Profile Creation',
    description: 'Multi-field data entry form for profile creation',
  ),
  chat(title: 'Chat', description: 'Message input field with send button'),
  settings(title: 'Settings', description: 'Profile editing form in settings');

  final String title;
  final String description;

  const ShowcaseScenario({required this.title, required this.description});
}
