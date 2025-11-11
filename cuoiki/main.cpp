#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQuickWindow>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Tạo cửa sổ Cluster (main.qml)
    QQmlComponent clusterComponent(&engine, QUrl(QStringLiteral("qrc:/main.qml")));
    QObject *clusterWindow = clusterComponent.create();

    // Tạo cửa sổ IVI (IVImain.qml)
    QQmlComponent iviComponent(&engine, QUrl(QStringLiteral("qrc:/IVImain.qml")));
    QObject *iviWindow = iviComponent.create();

    // Hiển thị cả hai cửa sổ
    if (auto cluster = qobject_cast<QQuickWindow*>(clusterWindow))
        cluster->show();
    else
        qWarning() << "Không thể load Cluster HMI!";

    if (auto ivi = qobject_cast<QQuickWindow*>(iviWindow))
        ivi->show();
    else
        qWarning() << "Không thể load IVI HMI!";

    // if (iviComponent.isError()) {
    //     qWarning() << "IVI QML errors:" << iviComponent.errors();
    // }

    return app.exec();
}
