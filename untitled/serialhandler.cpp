#include "serialhandler.h"
#include <QDebug>
#include <QtGlobal>

SerialHandler::SerialHandler(QObject* parent) : QObject(parent) {
    connect(&m_port, &QSerialPort::readyRead,
            this, &SerialHandler::onReadyRead);

    // Tự chọn 1 cổng USB/ACM nếu có
    for (const auto& info : QSerialPortInfo::availablePorts()) {
        const QString n = info.portName();     // vd: "ttyUSB0", "ttyACM0", "COM3"
        if (n.contains("ttyUSB") || n.contains("ttyACM")) {
            m_portName = n;
            emit portNameChanged();
            break;
        }
    }

    if (m_portName.isEmpty())
        m_portName = "ttyUSB0";               // fallback trên Linux

    if (!m_portName.isEmpty())
        open();
}

QStringList SerialHandler::availablePorts() const {
    QStringList list;
    for (const auto& info : QSerialPortInfo::availablePorts())
        list << info.portName();              // "ttyUSB0", "ttyACM0", "COM3", ...
    return list;
}

void SerialHandler::setPortName(const QString& name) {
    if (m_portName == name)
        return;
    m_portName = name;
    emit portNameChanged();
}

bool SerialHandler::open() {
    if (m_port.isOpen())
        m_port.close();
    if (m_portName.isEmpty()) {
        emit status("Chưa chọn cổng");
        return false;
    }

    m_port.setPortName(m_portName);          // ví dụ "ttyUSB0" hoặc "COM3"
    m_port.setBaudRate(115200);
    m_port.setDataBits(QSerialPort::Data8);
    m_port.setParity(QSerialPort::NoParity);
    m_port.setStopBits(QSerialPort::OneStop);
    m_port.setFlowControl(QSerialPort::NoFlowControl);

    if (!m_port.open(QIODevice::ReadOnly)) {
        const QString err = m_port.errorString();
        emit status(QString("Mở cổng lỗi: %1").arg(err));
        qDebug() << "Serial open error:" << err;
        return false;
    }

    emit status(QString("Đã mở %1").arg(m_portName));
    qDebug() << "Serial opened on" << m_portName;
    return true;
}

void SerialHandler::close() {
    if (m_port.isOpen()) {
        m_port.close();
        emit status("Đã đóng cổng");
    }
}

void SerialHandler::onReadyRead() {
    m_buf.append(m_port.readAll());
    int idx;
    while ((idx = m_buf.indexOf('\n')) >= 0) {
        QByteArray line = m_buf.left(idx);
        m_buf.remove(0, idx + 1);

        QString s = QString::fromUtf8(line).trimmed();
        if (s.isEmpty()) continue;

        qDebug() << "[Serial recv]" << s;
        setMessage(s);     // lưu để debug UI

        // ----- 1) BTN1..BTN10 -----
        // ESP gửi đúng dạng: BTN1, BTN2,..., BTN10
        if (s.startsWith("BTN")) {
            emit buttonEvent(s);
            // giữ lại buttonPressed() cũ nếu bạn vẫn dùng cho BTN nào đó
            if (s == "BTN" || s == "BTN1")
                emit buttonPressed();
            continue;
        }

        // ----- 2) SPD1..SPD4:xxx -----
        // ví dụ: "SPD1:137"
        if (s.startsWith("SPD", Qt::CaseInsensitive)) {
            int colon = s.indexOf(':');
            if (colon > 3) {
                QString tag    = s.left(colon);      // SPD1
                QString numStr = s.mid(colon + 1);   // 137
                bool okVal = false;
                int val = numStr.toInt(&okVal);
                if (!okVal) continue;

                if (val < 0)   val = 0;
                if (val > 220) val = 220;

                bool okIdx = false;
                int idxCh = tag.mid(3).toInt(&okIdx);   // "1","2","3","4"
                if (okIdx && idxCh >= 1 && idxCh <= 4) {
                    setSpeedChannel(idxCh - 1, val);
                }
            }
            continue;
        }

        // ----- 3) MSG / CALL -----
        // ESP có thể gửi:
        //   CALL_INCOMING:TenNguoiGoi
        //   CALL_END
        //   MSG:Noi dung tin nhan
        if (s.startsWith("CALL_INCOMING")) {
            QString callerName = "Unknown";
            int colon = s.indexOf(':');
            if (colon != -1) {
                callerName = s.mid(colon + 1).trimmed();
                if (callerName.isEmpty())
                    callerName = "Unknown";
            }
            emit incomingCall(callerName);
            continue;
        }

        if (s.contains("CALL_END")) {
            emit endCall();
            continue;
        }

        if (s.startsWith("MSG:")) {
            QString msg = s.mid(4).trimmed();
            if (!msg.isEmpty()) {
                emit messageReceived("ESP32", msg);
            }
            continue;
        }

        // Các format khác: chỉ hiển thị debug qua message
    }
}

void SerialHandler::setMessage(const QString& m) {
    if (m == m_message) return;
    m_message = m;
    emit messageChanged();
}

void SerialHandler::setSpeedChannel(int ch, double v) {
    if (ch < 0 || ch >= 4) return;
    double &ref = m_speeds[ch];
    if (qFuzzyCompare(ref, v))
        return;
    ref = v;

    switch (ch) {
    case 0:
        emit speed1Changed();
        emit speedChanged();  // alias cho speed1
        break;
    case 1:
        emit speed2Changed();
        break;
    case 2:
        emit speed3Changed();
        break;
    case 3:
        emit speed4Changed();
        break;
    default:
        break;
    }
}
