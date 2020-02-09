import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

// class Bloc extends Object with Validators { // <------ fixes line 5 in older versions
class Bloc with Validators {
  // These variables are considered "private" due to their underscore in front of their identifiers
  final _email = StreamController<String>();
  final _password = StreamController<String>();

  // Add data to stream
  // Note: Function(String) means "a function that takes a string as a parameter"
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => 
    Rx.combineLatest2(email, password, (e, p) => true);

  dispose() {
    _email.close();
    _password.close();
  }
}