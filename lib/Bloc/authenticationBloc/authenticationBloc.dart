/*
 * Copyright (c) 2020. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:async';

import 'package:fins_user/Bloc/authenticationBloc/authenticationEvent.dart';
import 'package:fins_user/repository/userRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authenticationState.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  UserRepository userRepository=UserRepository();

  AuthenticationBloc(AuthenticationState initialState) : super(initialState);
  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)async* {
    // TODO: implement mapEventToState
    if(event is AppStarted){
      await Future.delayed(Duration(milliseconds: 0000));

      final bool hasVisited=await userRepository.hasVisitedApp();
      if(hasVisited){
        yield AuthenticationHomeScreen();
      }
      else{
        yield AuthenticationInitialized();
      }
    }

    if(event is MobileRegistered){
      await userRepository.makeVisited();
      yield AuthenticationHomeScreen();
    }

  }



}