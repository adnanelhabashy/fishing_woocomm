//import 'package:ecom/product_screen.dart';
//import 'package:ecom/services/auth-service/auth-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Animation for sliding the login form into view
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          SlideTransition(
            position: _slideAnimation,
            child: _buildLoginForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: Color(0xFF0077be), end: Color(0xFF00c6ff)).evaluate(_controller)!,
                ColorTween(begin: Color(0xFF00c6ff), end: Color(0xFF0077be)).evaluate(_controller)!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.9],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildLogo(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 30),
            _buildLoginButton(context),
            const SizedBox(height: 20),
            _buildForgotPasswordText(),
            const SizedBox(height: 40),
            _buildSocialLoginButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png', // Make sure to add your logo image to the assets folder and update the path here
          height: 100,
        ),
        const SizedBox(height: 20),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, double opacity, child) {
            return Opacity(
              opacity: opacity,
              child: Text(
                'E-Comm',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: TextStyle(color: Colors.teal[200]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        prefixIcon: const Icon(Icons.email, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: Colors.teal[200]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        prefixIcon: const Icon(Icons.lock, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.1, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: ElevatedButton(
            onPressed: () {
             // context.read<AuthCubit>().login(
             //   _emailController.text,
             //   _passwordController.text,
             // );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              shadowColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
              elevation: MaterialStateProperty.all<double>(10),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 18, horizontal: 60),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_open, color: Colors.white),
                const SizedBox(width: 10),
                const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildForgotPasswordText() {
    return TextButton(
      onPressed: () {
        // Handle forgot password action
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSocialButton(Icons.facebook, Colors.blue),
        const SizedBox(width: 20),
        _buildSocialButton(Icons.g_mobiledata, Colors.red),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: Icon(icon, color: Colors.white, size: 32),
    );
  }
}
