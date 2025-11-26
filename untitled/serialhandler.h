#ifndef SERIALHANDLER_H
#define SERIALHANDLER_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>

class SerialHandler : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString message  READ message  NOTIFY messageChanged)
    Q_PROPERTY(QString portName READ portName WRITE setPortName NOTIFY portNameChanged)

    // SPD1..SPD4 (0..220)
    Q_PROPERTY(double speed  READ speed  NOTIFY speedChanged)   // alias SPD1
    Q_PROPERTY(double speed1 READ speed1 NOTIFY speed1Changed)
    Q_PROPERTY(double speed2 READ speed2 NOTIFY speed2Changed)
    Q_PROPERTY(double speed3 READ speed3 NOTIFY speed3Changed)
    Q_PROPERTY(double speed4 READ speed4 NOTIFY speed4Changed)

public:
    explicit SerialHandler(QObject* parent = nullptr);

    QString message() const { return m_message; }
    QString portName() const { return m_portName; }

    // alias: speed = SPD1
    double  speed()  const { return m_speeds[0]; }
    double  speed1() const { return m_speeds[0]; }
    double  speed2() const { return m_speeds[1]; }
    double  speed3() const { return m_speeds[2]; }
    double  speed4() const { return m_speeds[3]; }

    Q_INVOKABLE QStringList availablePorts() const;
    Q_INVOKABLE bool open();
    Q_INVOKABLE void close();

public slots:
    void setPortName(const QString& name);

signals:
    void messageChanged();
    void portNameChanged();
    void status(const QString& text);

    // BTN cũ (nếu còn dùng), nhưng giờ chủ yếu dùng buttonEvent
    void buttonPressed();

    // phát ra khi nhận BTN1..BTN10
    void buttonEvent(const QString& label);

    // SPD signals
    void speedChanged();   // alias SPD1
    void speed1Changed();
    void speed2Changed();
    void speed3Changed();
    void speed4Changed();

    // ==== CALL / MSG từ ESP32 ====
    void incomingCall(QString callerName);
    void endCall();
    void messageReceived(QString sender, QString content);

private slots:
    void onReadyRead();

private:
    void setMessage(const QString& m);
    void setSpeedChannel(int ch, double v);  // ch = 0..3

    QSerialPort m_port;
    QString m_portName;
    QString m_message = "(chưa có dữ liệu)";
    QByteArray m_buf;

    // SPD1..SPD4
    double m_speeds[4] = {0.0, 0.0, 0.0, 0.0};
};

#endif // SERIALHANDLER_H
