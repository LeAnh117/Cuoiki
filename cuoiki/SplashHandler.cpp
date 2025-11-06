#include "SplashHandler.h"
#include <QTimer>

SplashHandler::SplashHandler(QObject *parent)
    : QObject(parent)
{
    QTimer::singleShot(3000, this, &SplashHandler::splashFinished);
}
