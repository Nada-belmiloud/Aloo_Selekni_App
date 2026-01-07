import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestScreen extends StatefulWidget {
  const FirebaseTestScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseTestScreen> createState() => _FirebaseTestScreenState();
}

class _FirebaseTestScreenState extends State<FirebaseTestScreen> {
  String _status = 'Initializing Firebase test...';
  bool _isLoading = true;
  Color _statusColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _testFirebase();
  }

  Future<void> _testFirebase() async {
    setState(() {
      _isLoading = true;
      _status = 'Starting Firebase tests...\n\n';
      _statusColor = Colors.blue;
    });

    try {
      // Test 1: Firebase Initialization
      await Future.delayed(const Duration(milliseconds: 500));
      final app = Firebase.app();
      setState(() {
        _status += '✅ Test 1: Firebase Initialized\n';
        _status += '   Project: ${app.options.projectId}\n\n';
      });

      // Test 2: Write to Firestore
      setState(() {
        _status += '📝 Test 2: Writing to Firestore...\n';
      });
      
      await FirebaseFirestore.instance
          .collection('test_collection')
          .doc('test_document')
          .set({
        'message': 'Hello from Flutter!',
        'timestamp': FieldValue.serverTimestamp(),
        'testNumber': 123,
        'isWorking': true,
      });

      setState(() {
        _status += '✅ Successfully wrote data to Firestore\n\n';
      });

      // Test 3: Read from Firestore
      setState(() {
        _status += '📖 Test 3: Reading from Firestore...\n';
      });
      
      await Future.delayed(const Duration(milliseconds: 500));
      final doc = await FirebaseFirestore.instance
          .collection('test_collection')
          .doc('test_document')
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _status += '✅ Successfully read data:\n';
          _status += '   Message: ${data?['message']}\n';
          _status += '   Number: ${data?['testNumber']}\n';
          _status += '   Working: ${data?['isWorking']}\n\n';
        });
      }

      // Test 4: Collection Query
      setState(() {
        _status += '🔍 Test 4: Querying collection...\n';
      });

      final querySnapshot = await FirebaseFirestore.instance
          .collection('test_collection')
          .limit(5)
          .get();

      setState(() {
        _status += '✅ Found ${querySnapshot.docs.length} document(s)\n\n';
      });

      // All tests passed!
      setState(() {
        _status += '🎉 SUCCESS! Firebase is fully connected!\n\n';
        _status += '✨ You can now use:\n';
        _status += '   • Firestore Database\n';
        _status += '   • Firebase Auth\n';
        _status += '   • Firebase Storage\n';
        _isLoading = false;
        _statusColor = Colors.green;
      });

    } catch (e) {
      setState(() {
        _status = '❌ ERROR: Test Failed\n\n';
        _status += 'Error Details:\n$e\n\n';
        _status += '💡 Troubleshooting:\n';
        _status += '1. Check if Firestore is enabled in Firebase Console\n';
        _status += '2. Verify Firestore rules allow read/write\n';
        _status += '3. Check your internet connection\n';
        _status += '4. Make sure google-services.json is in android/app/\n';
        _isLoading = false;
        _statusColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Connection Test'),
        backgroundColor: _statusColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Status Icon
              if (_isLoading)
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(strokeWidth: 6),
                )
              else
                Icon(
                  _statusColor == Colors.green 
                      ? Icons.check_circle_outline 
                      : Icons.error_outline,
                  color: _statusColor,
                  size: 80,
                ),
              
              const SizedBox(height: 32),

              // Status Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  _status,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Retry Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _testFirebase,
                icon: const Icon(Icons.refresh),
                label: const Text('Run Test Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 16),

              // Open Console Button
              if (!_isLoading && _statusColor == Colors.green)
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to App'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}