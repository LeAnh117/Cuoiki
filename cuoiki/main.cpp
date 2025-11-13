#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQuickWindow>
#include <QQmlContext>
#include <QSerialPort>
#include <QDebug>

class SerialHandler : public QObject {
    Q_OBJECT
public:
    explicit SerialHandler(QObject *parent = nullptr) : QObject(parent) {
        connect(&serial, &QSerialPort::readyRead, this, &SerialHandler::onReadyRead);

        serial.setPortName("/dev/ttyUSB0");   // ⚙️ Thay bằng cổng thật của bạn (COM3, COM5, v.v.)
        serial.setBaudRate(QSerialPort::Baud115200);
        serial.setDataBits(QSerialPort::Data8);
        serial.setParity(QSerialPort::NoParity);
        serial.setStopBits(QSerialPort::OneStop);
        serial.setFlowControl(QSerialPort::NoFlowControl);

        if (!serial.open(QIODevice::ReadOnly)) {
            qWarning() << "⚠️ Không thể mở cổng serial:" << serial.errorString();
        } else {
            qDebug() << "✅ Đã mở cổng serial thành công.";
        }
    }

signals:
    void incomingCall(QString callerName);
    void endCall();

private slots:
    void onReadyRead() {
        QByteArray data = serial.readAll();
        qDebug() << "📩 ESP32 gửi:" << data;

        if (data.startsWith("CALL_INCOMING")) {
            QString callerName = "Huynh Cong Vinh";
            int idx = data.indexOf(':');
            if (idx != -1)
                callerName = QString::fromUtf8(data.mid(idx + 1).trimmed());
            emit incomingCall(callerName);
        }
        else if (data.contains("CALL_END")) {
            emit endCall();
        }
        qDebug() << "Raw data:" << data;

    }

private:
    QSerialPort serial;
};

#include "main.moc"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    SerialHandler* serialHandler = new SerialHandler(&app);
    engine.rootContext()->setContextProperty("serialHandler", serialHandler);


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
