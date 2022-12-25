import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/module/global/global_cubit.dart';
import 'package:vinhmdev/src/module/global/global_state.dart';

import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      var googleAuthProvider = GoogleAuthProvider();
      googleAuthProvider.addScope('https://www.googleapis.com/auth/calendar '
          'https://www.googleapis.com/auth/drive.appdata '
          'https://www.googleapis.com/auth/userinfo.profile');
      googleAuthProvider.setCustomParameters({
        'login_hint': 'user@example.com',
      });
      return await XData.fau.signInWithPopup(googleAuthProvider);
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    var credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    return await XData.fau.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    final bloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var user = (await signInWithGoogle()).user;
            if (null != user) {
              globalCubit.refreshSigin();
            }
          },
          child: Text('Sign in with Google'), // todo lang
        ),
      ),
    );
  }
}

