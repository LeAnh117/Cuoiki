#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQuickWindow>
#include <QQmlContext>

#include "serialhandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // KHÔNG tạo thêm SerialHandler trong QML nữa,
    // nên không cần qmlRegisterType nếu bạn không dùng ở chỗ khác.
    // qmlRegisterType<SerialHandler>("EspDemo", 1, 0, "SerialHandler");

    // 👉 Instance duy nhất của SerialHandler
    SerialHandler serialHandler;
    engine.rootContext()->setContextProperty("serialHandler", &serialHandler);

    // === Cửa sổ Cluster (main.qml) ===
    QQmlComponent clusterComponent(&engine, QUrl(QStringLiteral("qrc:/main.qml")));
    QObject *clusterWindowObj = clusterComponent.create();
    if (auto clusterWindow = qobject_cast<QQuickWindow*>(clusterWindowObj)) {
        clusterWindow->show();
    } else {
        qWarning() << "Không thể load Cluster HMI!";
        if (clusterComponent.isError())
            qWarning() << "Cluster QML errors:" << clusterComponent.errors();
    }

    // === Cửa sổ IVI (IVImain.qml) ===
    QQmlComponent iviComponent(&engine, QUrl(QStringLiteral("qrc:/IVImain.qml")));
    QObject *iviWindowObj = iviComponent.create();
    if (auto iviWindow = qobject_cast<QQuickWindow*>(iviWindowObj)) {
        iviWindow->show();
    } else {
        qWarning() << "Không thể load IVI HMI!";
        if (iviComponent.isError())
            qWarning() << "IVI QML errors:" << iviComponent.errors();
    }

    return app.exec();
}
