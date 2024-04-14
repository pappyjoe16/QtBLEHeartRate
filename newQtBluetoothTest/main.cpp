#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QQuickView>
#include "device.h"
#include "deviceinfo.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    Device d;
    // QQmlApplicationEngine engine;

    // qmlRegisterType<Device>("Device", 1, 0, "Device");

    // const QUrl url(QStringLiteral("qrc:/main.qml"));
    // QObject::connect(
    //     &engine,
    //     &QQmlApplicationEngine::objectCreated,
    //     &app,
    //     [url](QObject *obj, const QUrl &objUrl) {
    //         if (!obj && url == objUrl)
    //             QCoreApplication::exit(-1);
    //     },
    //     Qt::QueuedConnection);
    // engine.load(url);

    QQuickView *view = new QQuickView;
    view->rootContext()->setContextProperty("device", &d);
    view->setSource(QUrl("qrc:/main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);

    QObject *item = dynamic_cast<QObject *>(view->rootObject());
    QObject::connect(&d, SIGNAL(sendAddress(QVariant)), item, SLOT(qmlSlot(QVariant)));
    QObject::connect(&d, SIGNAL(measuringChanged(QVariant)), item, SLOT(qmlHrSlot(QVariant)));
    view->show();

    return app.exec();
}
