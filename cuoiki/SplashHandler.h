#ifndef SPLASHHANDLER_H
#define SPLASHHANDLER_H

#include <QObject>

class SplashHandler : public QObject
{
    Q_OBJECT

public:
    explicit SplashHandler(QObject *parent = nullptr);

signals:
    void splashFinished();
};

#endif // SPLASHHANDLER_H
