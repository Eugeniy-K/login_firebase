import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:login_firebase/logic/cubits/signup/signup_cubit.dart';
import 'package:login_firebase/screens/finish_signup_page.dart';
import 'package:login_firebase/theme.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: ListView(

        children: [
          Row(
            children: [
              _BackButton()
            ],
          ),
          const SizedBox(height: 100.0),
          _EmailText(),
          // const SizedBox(height: 3.0),
          _EmailInput(),
          // _UsernameText(),
          // const SizedBox(height: 3.0),
          // _UsernameInput(),
          _PasswordText(),
          // const SizedBox(height: 3.0),
          _PasswordInput(),
          _RepeatPasswordText(),
          _ConfirmPasswordInput(),
          // const SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SignUpButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.alternate_email),
        Text('Email',
          style: TextStyle(
            fontSize: 18
          ),)],);
  }
}

class _PasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.lock_outline),
        Text('Password',
          style: TextStyle(
              fontSize: 18
          ),)],);
  }
}

class _UsernameText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.account_circle_outlined),
        Text('Username',
          style: TextStyle(
              fontSize: 18
          ),)],);
  }
}

class _RepeatPasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 25,),
        Text('Repeat password',
          style: TextStyle(
              fontSize: 18
          ),)],);
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(false),
      child: Container(
        width: 50,
        height: 50,
        child: Icon(Icons.arrow_back, color: Colors.white, size: 40,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: theme.accentColor
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            // labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          // onChanged: (value) => context.read<SignUpCubit>().emailChanged(email),
          // keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            helperText: '',
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
      previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
              key: const Key('signUpForm_continue_raisedButton'),
              child: const Text('SIGN UP'),
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            primary: theme.accentColor,
          ),
          onPressed: state.status.isValidated
              ? () => context.read<SignUpCubit>().signUpFormSubmitted()
              : null,
        );
      },
    );
  }
}