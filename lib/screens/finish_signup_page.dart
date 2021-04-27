import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/logic/blocs/authentication/authentication_bloc.dart';
import 'package:login_firebase/logic/cubits/new_user/finish_signup_cubit.dart';
import 'package:login_firebase/logic/cubits/new_user/finish_signup_state.dart';
import 'package:login_firebase/repositories/authentication_repository.dart';
import 'package:login_firebase/theme.dart';
import 'package:login_firebase/widgets/sign_up_form.dart';


class FinishSignUpPage extends StatelessWidget {
  const FinishSignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => FinishSignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: BlocProvider(
            create: (_) => FinishSignupCubit(),
            child: FinishSignUpForm(),),
        // child: BlocProvider<FinishSignupCubit>(
        //   create: (_) => FinishSignupCubit(context.read<AuthenticationRepository>()),
        //   child: FinishSignUpForm(),
        // ),
      ),
    );
  }
}

class FinishSignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          // onChanged: (value) =>
            // context.read<FinishSignupCubit>().userNameChanged(value),
          onChanged: (value) =>
              context.read<FinishSignupCubit>().userNameChanged(value),
          decoration: InputDecoration(
            // labelText: 'email',
            helperText: 'username',
          ),
        ),
         SizedBox(height: 40),
        BlocBuilder<FinishSignupCubit, FinishSignupState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return state.status == ProgressStatus.inProgress
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                  key: const Key('signUpForm_continue_raisedButton'),
                  child: const Text('FINISH'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    primary: theme.accentColor,
                  ),
                  onPressed: () async {
                    var user = await context.read<FinishSignupCubit>().addNewUser();
                    if (user != null) {
                      BlocProvider.of<AuthenticationBloc>(context).add(SignUpUserAddedEvent(user));
                    }
                  }
              );
            }
        )
      ],
    );
  }
}