import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void test() {
    print("Login clicked!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Welcome', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Image.asset('assets/images/logo.png', height: 192),
                const SizedBox(height: 24),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Please login to continue",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),

                          CheckboxListTile(
                            title: const Text('Remember me'),
                            value: true,
                            onChanged: (bool? value) {},
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => test(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
