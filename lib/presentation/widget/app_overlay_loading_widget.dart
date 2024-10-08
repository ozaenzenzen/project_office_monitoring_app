import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_indicator.dart';

class AppOverlayLoadingWidget extends StatelessWidget {
  final Stream<bool> loadingStatus;
  final Widget child;
  final bool dismissible;

  const AppOverlayLoadingWidget({
    super.key,
    required this.loadingStatus,
    required this.child,
    this.dismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    var progressWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: <Widget>[
              Center(
                child: AppLoadingIndicator(),
              ),
              // Center(
              //   child: Lottie.asset(
              //     Assets.ltLoading,
              //     width: 120,
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 14.0,
        ),
        Material(
          type: MaterialType.transparency,
          child: Text('Loading...', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
        )
      ],
    );

    return StreamBuilder<bool>(
      stream: loadingStatus,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        List<Widget> widgetList = [];
        widgetList.add(child);
        if (snapshot.hasData && snapshot.data!) {
          Widget layOutProgressIndicator;
          layOutProgressIndicator = Center(child: progressWidget);
          final modal = [
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(
                dismissible: dismissible,
                color: Colors.black,
              ),
            ),
            layOutProgressIndicator
          ];
          widgetList += modal;
        }
        return Stack(
          children: widgetList,
        );
      },
    );
  }
}
