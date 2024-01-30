

import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ktpproject/application/pages/indexPage/index_page.dart';

import '../../pages/createPage/create_page.dart';
import '../../pages/detailPage/detail_page.dart';
import '../../pages/editPage/edit_page.dart';

class RouterNavigation {
  // varibel
  var _router;

  RouterConfig<Object> getRoute(){
    _router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            name: 'indexktp',
            path: '/',
            // builder: (context, state) => CreateKtpPage(),
            builder: (context, state) => IndexPageWrapperProvider(),
          ),
          GoRoute(
            name: 'createktp',
            path: '/create',
            builder: (context, state) => CreateKtpPage(),
          ),
          GoRoute(
              name: 'detailktp',
              path: '/detail/:penduduk_id',
              builder: (context, state){
                var _penduduk = state.pathParameters['penduduk_id'];
                return DetailKtpPage(_penduduk);
              }
          ),
          GoRoute(
              name: 'editktp',
              path: '/edit/:penduduk_id',
              builder: (context, state){
                var _penduduk = state.pathParameters['penduduk_id'];
                return EditKtpPage(_penduduk);
              }
          ),
        ]
    );
    return _router;
  }
}

