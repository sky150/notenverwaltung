import 'package:server/controller/noten_controller.dart';
import 'package:server/controller/semester_controller.dart';

import 'controller/fach_controller.dart';
import 'server.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ServerChannel extends ApplicationChannel {
  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        "nv_user", "1234", "localhost", 5433, "notenverwaltung");

    context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router.route("/noten/[:id]").link(() => NotenController(context));
    router
        .route("/noten/fach_id/[:fach_id]")
        .link(() => NotenController(context));
    router.route("/semester/[:id]").link(() => SemesterController(context));
    router.route("/faecher/[:id]").link(() => FachController(context));
    router
        .route("/faecher/semester_id/[:semester_id]")
        .link(() => FachController(context));

    return router;
  }
}
