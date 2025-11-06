#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "SplashHandler.h"
#include <QDebug>

static void openIVI() {
    qDebug() << "Opening IVI...";
    QQmlApplicationEngine *iviEngine = new QQmlApplicationEngine();
    iviEngine->load(QUrl(QStringLiteral("qrc:/IVImain.qml")));
    if (iviEngine->rootObjects().isEmpty()) {
        qWarning() << "Cannot load IVIMain.qml";
        return;
    }
    QObject *root = iviEngine->rootObjects().first();
    QQuickWindow *win = qobject_cast<QQuickWindow *>(root);
    if (win) {
        win->show();
        win->raise();
        win->requestActivate();
    } else {
        root->setProperty("visible", true);
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    SplashHandler splash; // emits splashFinished after timer or QML event

    QQmlApplicationEngine clusterEngine;
    clusterEngine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (clusterEngine.rootObjects().isEmpty()) return -1;

    QObject::connect(&splash, &SplashHandler::splashFinished, [](){
        openIVI();
    });

    return app.exec();
}
