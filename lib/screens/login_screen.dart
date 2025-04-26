import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/screens/signup_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/green_wave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          
          child: Container(
            color: AppTheme.primaryGreenColor.withAlpha(10),
            child: Stack(
              children: [
                Align(
              alignment: Alignment.bottomRight,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.96),
                painter: GreenWavePainter(),
              ),
            ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                      // Logo/Image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                          
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            'assets/logo.jpeg', // Make sure to add this image to your assets
                            height: 120,
                            
                          ),
                                                      ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkLavenderColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to your account',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.secondaryGreenColor,
                            ),
                      ),
                      const SizedBox(height: 40),
                      // Email Field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.primaryGreenColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline,  color: AppTheme.primaryGreenColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: AppTheme.darkLavenderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Login Button
                      Obx(
                        ()=> Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 150,
                            child: Get.find<AuthController>().isLoading.value? Center(child: CircularProgressIndicator(),):ElevatedButton(
                              onPressed: () {
                                Get.find<AuthController>().login(_emailController.text, _passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor:  AppTheme.darkLavenderColor
                                  , // Light purple color
                                    shadowColor: AppTheme.primaryLavenderColor,
                                    elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Face ID Option
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.secondaryGreenColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.face,
                              color: AppTheme.secondaryGreenColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Login with Face ID',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.secondaryGreenColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.darkLavenderColor,
                            ),
                            child: const Text('Sign Up'),
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
