import 'dart:io';

import 'package:cleopatra/features/collection1/productionhall/production/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/repos/injectionmachinerepoimp.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_cubit.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/repos/injectionworkerrepoimp.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_cubit.dart';
import 'package:cleopatra/features/qc/data/repos/repos/qcrepoimp.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_cubit.dart';
import 'package:cleopatra/features/splash/splash%20copy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/data/repos/loginrepoimp.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';
import 'package:cleopatra/features/collection1/average/data/repo/averagerepoimp.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/components/data/repos/componentsrepoimp.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';

import 'package:cleopatra/features/collection1/injcollection/data/repo/injectioncorepoimp.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/viewmodel/cubit/injextionco_dart_cubit.dart';

import 'package:cleopatra/features/home/presentation/viewmodel/cubit/home_cubit.dart';
import 'package:cleopatra/features/hr/data/repo/hrrepoimp.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';
import 'package:cleopatra/features/injections/injectionorders/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/produsage.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/repos/maintenancerepo.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/molds/data/repos/moldrepoimp.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/repos/moldrepoimp.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:cleopatra/features/paints/paint/data/repos/paintreportrepoimp.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportcuibt.dart';
import 'package:cleopatra/features/paints/paintaverage/data/repo/paintaveragerepoimp.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintorders/data/repos/paintrepoimp.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagecuibt.dart';
import 'package:cleopatra/features/injections/injection/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/repos/workersrepoimp.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';
import 'package:cleopatra/features/workers/data/repos/workerrepoimp.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

 await cashhelper.initcashhelper();

 // await Firebase.initializeApp(
 //   options: DefaultFirebaseOptions.currentPlatform,
  //);
 OneSignal.initialize("5bcd661f-dc56-4fb9-865a-94b700e59400");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateCubit(),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => productioncuibt(
                productionrepoimplementatio: productionrepoimplementation()),
          ),
          BlocProvider(
            create: (context) => attendanceworkersCubit(
                workerrepoimp: attendanceWorkerrepoimp()),
          ),
          
          BlocProvider(create: (context) => HrCubit(Hrrepoimp())),
          BlocProvider(
            create: (context) =>
                AddemployeeCubit(addemployeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) =>
                showemployeescuibt(employeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) => paintreportcuibt(
                paintreportrepoimplementatio: Paintreportrepoimp()),
          ),
          BlocProvider(
            create: (context) => paintaverageCubit(paintaveragerepoimp()),
          ),
          BlocProvider(
            create: (context) => paintusagecuibt(
                paintrepoimplementatio: paintrepoimplementation()),
          ),
          BlocProvider(
            create: (context) => injectionhallcuibt(
                injectionrepoimplementatio: injectionhallrepoimplementation()),
          ),
          BlocProvider(
            create: (context) => WorkerCubit(Workersrepoimp()),
          ),
          BlocProvider(
            create: (context) => InjectionmachinesCubit(Injectionmachinerepoimp()),
          ),
          BlocProvider(
            create: (context) => qcsCubit(qcrepoimp()),
          ),
          BlocProvider(
            create: (context) => InjectionworkersCubit(Injectionworkerrepoimp()),
          ),
         
          BlocProvider(
            create: (context) => injectionusagecuibt(
                injectionrepoimplementatio: injectionhallrepoimplementation()),
          ),
          BlocProvider(
            create: (context) => injectionusagecuibt(
                injectionrepoimplementatio: injectionhallrepoimplementation()),
          ),
          BlocProvider(
            create: (context) => AverageCubit(Averagerepoimp()),
          ),
         
          BlocProvider(
            create: (context) => componentCubit(Componentsrepoimp()),
          ),
         
          BlocProvider(
            create: (context) => AuthCubit(authrepoimp()),
          ),
          BlocProvider(
            create: (context) => MoldsCubit(moldrepoimp()),
          ),
          BlocProvider(
            create: (context) => productionhallcuibt(
                productionrepoimplementatio:
                    productionhallrepoimplementation()),
          ),
         
          BlocProvider(
            create: (context) => productionusagecuibt(
                productionrepoimplementatio:
                    productionusagerepoimplementation()),
          ),
        
          BlocProvider(
            create: (context) => maintenancesCubit(Maintenancerepoimp()),
          ),
          BlocProvider(
            create: (context) => moldusagesCubit(moldusagerepoimp()),
          ),
          BlocProvider(
            create: (context) => InjextioncoDartCubit(Injectioncorepoimp()),
          ),
          
          BlocProvider(
            create: (context) =>
                paintcuibt(paintrepo: paintrepoimplementation()),
          ),
        ],
        child: GetMaterialApp(
          locale: Locale("ar"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate, // Here !
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'), // Arabic

            Locale('en'), // English
          ],
          home: LogoAnimationScreen(),
        ));
  }
}
Future<void> initializeFirebase() async {
  try {
    if (Platform.isAndroid) {
    //  await Firebase.initializeApp(
      //  options: DefaultFirebaseOptions.android,
      //);
     OneSignal.initialize("5bcd661f-dc56-4fb9-865a-94b700e59400");
  OneSignal.Notifications.requestPermission(true);
    } else if (Platform.isWindows) {
     /* await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyC7kGcAALwmqhZmSrnNJoEeXJgKeEext-I",
          appId: "1:721741049198:android:b2006caf4575894dc3a57f",
          messagingSenderId: "721741049198",
          projectId: "mega-3c222",
          storageBucket: "mega-3c222.firebasestorage.app",
        ),
      );*/
    }
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      print('تم تهيئة Firebase مسبقاً');
    }
  }}
