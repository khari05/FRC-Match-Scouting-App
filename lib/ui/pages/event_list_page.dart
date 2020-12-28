import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:frc_scouting/ui/dialogs/add_event_dialog.dart';
// import 'package:frc_scouting/ui/pages/settings_page.dart';
import 'package:frc_scouting/ui/pages/event_pages.dart';

class EventListPage extends StatelessWidget {
  final EventRepository eventRepository;

  const EventListPage({Key key, @required this.eventRepository})
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
                          context: context,
                          builder: (context) => AddEventDialog()).then((value) {
                        if (value == true) {
                          BlocProvider.of<EventBloc>(context)
                              .add(EventsRequested());
                        }
                      });
                    });
              } else {
                return Container();
              }
            })));
  }
}

class _EventCenter extends StatefulWidget {
  @override
  __EventCenterState createState() => __EventCenterState();
}

class __EventCenterState extends State<_EventCenter> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventBloc>(context).add(EventsRequested());
    return Center(
      child: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        if (state is EventLoadSuccess) {
          final events = state.events;
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<EventBloc>(context).add(EventsRequested());
              return _refreshCompleter.future;
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.separated(
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
                              return EventPages(
                                  eventKey: events[index].blueAllianceId,
                                  eventName: events[index].name);
                            },
                          ));
                        });
                  }),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
