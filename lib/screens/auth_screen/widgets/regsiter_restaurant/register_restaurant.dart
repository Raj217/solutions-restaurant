import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/screens/auth_screen/widgets/regsiter_restaurant/register_form.dart';

class RegisterRestaurant extends StatefulWidget {
  final void Function() onTap;
  const RegisterRestaurant({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterRestaurant> createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Register',
                  style: Theme.of(context).textTheme.headlineLarge),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  'Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const RegisterForm(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
