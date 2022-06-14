import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//bool _isLoggedIn = false;
String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  try {
    await _googleSignIn.signIn();
  } catch (err) {
    print(err);
    print("Error al ingresar");
  }
  final GoogleSignInAccount user = _googleSignIn.currentUser;

  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;
    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();
  print("User Signed Out");
}
