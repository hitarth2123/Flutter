import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Concepts Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D5C63)),
        fontFamily: 'RobotoSlab',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD8E4E2)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/form': (context) => const FormScreen(),
        '/images': (context) => const ImageGridScreen(),
        '/animation': (context) => const AnimationScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        'User Input & Forms',
        'Validate details with a real Flutter form.',
        Icons.fact_check_outlined,
        '/form',
        const Color(0xFFE5F4F1),
      ),
      (
        'Images & Fonts',
        'Explore local assets in a responsive grid.',
        Icons.photo_library_outlined,
        '/images',
        const Color(0xFFFFEBD6),
      ),
      (
        'Animations',
        'Tap to transform a container smoothly.',
        Icons.auto_awesome_outlined,
        '/animation',
        const Color(0xFFE9E4F8),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Concepts Lab')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
        children: [
          Text(
            'Three ideas, one app.',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF12343B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a station to see Flutter in action.',
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: Colors.blueGrey.shade700),
          ),
          const SizedBox(height: 28),
          ...cards.map(
            (card) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                elevation: 0,
                color: card.$5,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.pushNamed(context, card.$4),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(card.$3, size: 38, color: const Color(0xFF12343B)),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.$1,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(card.$2),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, ${_nameController.text.trim()}!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input & Forms')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Tell us about yourself',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Every field is validated before the form is submitted.',
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.trim().length < 2
                  ? 'Enter at least 2 characters.'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)
                    ? null
                    : 'Enter a valid email address.';
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Submit information'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGridScreen extends StatelessWidget {
  const ImageGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const images = [
      (
        'Stormy River',
        'assets/images/nature-aesthetic-phone-au3ozg94rwuzypfu.webp',
      ),
      ('Golden Sunrise', 'assets/images/200440.webp'),
      ('Moonlit Mountains', 'assets/images/vXuyZn.webp'),
      ('Forest Trail', 'assets/images/16126834.webp'),
      ('Autumn Glow', 'assets/images/2710490.webp'),
      ('Pink Sunset', 'assets/images/3018535.webp'),
      (
        'Lakeside Morning',
        'assets/images/1466738-hd-phone-wallpapers-nature-1080x1920-ipad-retina.webp',
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Images, Assets & Fonts')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: .85,
        children: images
            .map(
              (image) => Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Image.asset(image.$2, fit: BoxFit.cover)),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        image.$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final color = _expanded ? const Color(0xFFE98A15) : const Color(0xFF0D5C63);
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeInOutCubic,
              width: _expanded ? 260 : 150,
              height: _expanded ? 180 : 150,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(_expanded ? 36 : 12),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .25),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _expanded ? 'Expanded' : 'Tap below',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            FilledButton.icon(
              onPressed: () => setState(() => _expanded = !_expanded),
              icon: Icon(_expanded ? Icons.compress : Icons.open_in_full),
              label: Text(_expanded ? 'Shrink container' : 'Animate container'),
            ),
          ],
        ),
      ),
    );
  }
}
