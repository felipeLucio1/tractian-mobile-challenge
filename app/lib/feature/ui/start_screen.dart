import 'package:app/data/model/company.dart';
import 'package:app/di/dependencies_register.dart';
import 'package:app/feature/bloc/management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late final ManagementBloc bloc;

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartPageWdget(),
    );
  }
}

class StartPageWdget extends StatefulWidget {
  const StartPageWdget({super.key, String title = ''});

  @override
  State<StartPageWdget> createState() => _StartPageWdgetState();
}

class _StartPageWdgetState extends State<StartPageWdget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tractian App'),
        ),
        body: const CompaniesList());
  }
}

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Company> companiesList = [];

    return BlocProvider<ManagementBloc>(
        create: (_) => ManagementBloc(),
        child: BlocBuilder<ManagementBloc, ManagementState>(
          builder: (context, state) {
            switch (state) {
              case LoadingScreenState():
                context.read<ManagementBloc>().add(LoadingCompaniesEvent());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SuccessDataRetrievingCompaniesState():
                companiesList = state.companies;
                return Center(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: companiesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.lightBlue,
                        child: TextButton(
                            onPressed: () {
                              LoggerWrapper().logger.info('botão pressionado');
                              context.read<ManagementBloc>().add(
                                  LoadOrphanElementsEvent(
                                      company: companiesList[index]));
                            },
                            child: Text(
                              companiesList[index].companyName,
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                );
              case ErrorDataRetrievingCompaniesState():
                return const Center(
                  child: Text('Oops! Algo saiu errado.'),
                );
              default:
                break;
            }

            return Center(
              child: ErrorWidget('Error'),
            );
          },
        ));
  }
}
