import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:frc_scouting/widgets/AddDialog.dart';
import 'package:frc_scouting/widgets/EventPage.dart';
// import 'package:frc_scouting/widgets/settings_page.dart';

class EventView extends StatelessWidget {
  final EventRepository eventRepository;

  const EventView({Key key, @required this.eventRepository})
      : assert(eventRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventBloc>(
        create: (context) => EventBloc(eventRepository: eventRepository),
        child: Scaffold(
            appBar: AppBar(
              //* appbar is the header
              title: Text('Event List'),
              // TODO: Add a settings page
              // actions: [
              //   FlatButton(
              //     child: Icon(Icons.settings),
              //     onPressed: () =>
              //         Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return SettingsPage();
              //     })),
              //   )
              // ],
            ),
            body: _EventCenter(),
            floatingActionButton:
                BlocBuilder<EventBloc, EventState>(builder: (context, state) {
              if (state is EventLoadSuccess) {
                return FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                          context: context, builder: (context) => AddDialog());
                    });
              } else {
                return Container();
              }
            })));
  }
}

class _EventCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventBloc>(context).add(EventsRequested());
    return Center(
      child: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        if (state is EventInitial) {
          return Container();
        }
        if (state is EventLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EventLoadSuccess) {
          final events = state.events;
          return ListView.separated(
              itemCount: events.length,
              separatorBuilder: (context, index) =>
                  Padding(padding: EdgeInsets.all(2.5)),
              itemBuilder: (context, index) {
                return RaisedButton(
                    child: ListTile(
                      title: Text(events[index].name),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                        // when clicked, it opens the match list and scouting for said item
                        builder: (BuildContext context) {
                          return EventPage(
                              eventKey: events[index].blueAllianceId,
                              eventName: events[index].name);
                        },
                      ));
                    });
              });
        }
        if (state is EventLoadFailure) {
          return Text(
            "Something went wrong!",
            style: TextStyle(color: Colors.red),
          );
        }
      }),
    );
  }
}
