import UIKit

// Скажите, а вы знакомы с принципами SOLID?
// Как думаете, изменение поведения метода в подклассе при наследовании нарушает какой-нибудь принцип из SOLID?

// Полагаю, таким образом нарушается принцип открытости-закрытости, open closed principle.
// Знаком, однако в работе ими пользоваться не доводилось — затратно по времени на планирование архитектуры и реализацию, а фичи, придуманные дизайнерами, должны приносить деньги уже сейчас. Так что у нас есть и гигантский мегакласс GameController, нужный всегда, даже время узнать у него спрашиваем, и нет прокладок в виде интерфейсов (в С++ — чисто абстрактных классов) и потому минорное изменение/дополнение какого-то мелкого часто используемого класса приводит к долгой перекомпиляции проекта. Не, мы потом-то взялись за ум и перестали пихать весь функционал в мегакласс, но такое решение в начале разработки игры привело к тому, что есть.


// Так и не понял, зачем нужен был пустой протокол Obstacle.

// Чтобы typeкастить оператором as. Подразумевается, что мы определяем проходимость ячейки на карте так: есть ли что-то в ячейке? если есть, кастуем находящийся объест к Obstacle и не идём туда, если результат приведения типа не nil. Для этой операции никакие дополнительные данные не нужны, только пустой тип.


// 1. Посмотреть видео про методы композиции и агрегации по ссылке https://www.youtube.com/watch?v=N7DzmfLBolM

// Автор путано изложил, мне больше нравится https://habr.com/ru/post/354046/ и https://ru.wikipedia.org/wiki/Агрегирование_(программирование)
// В этих статьях композиция описывается как такой способ владения, когда компонент существует только как часть целого, уничтожается вместе с этим объектом. Агрегация — когда компонент может существовать отдельно от объекта. Как пример можно привести отношения внутри простого окна с TableView внутри:
/*
class RatingDialog {
public:
    RatingDialog() { // конструктор
        m_tableView = TableView.create(m_dataSource)
    }
    ~RatingDialog() {
        if (m_tableView != nullptr) {
            delete m_tableView;
        }
    }
private:
    somesdk::TableView* m_tableView;
    RatingDataSource m_dataSource;
}
*/
// RatingDialog состоит из m_dataSource и m_tableView, оба компонента включены в диалог с помощью композиции. Создаваемая внутри диалога таблица требует источник данных, он ей предоставляется извне, это агрегация — я могу удалить таблицу, создать новую и передать ей тот же DataSource.


// 2. Привести по два примера с использованием композиции и агрегации. Объяснить, почему в каждом примере использована композиция/агрегация.

/*

 protocol Stream {
    func write(String, Int)
 }

 class Logger {
    init(stream: Stream)
    func log(_ str: String, severity: Int = 0)
 }

 Класс Logger пишет логи в Stream. Куда именно эти логи попадают в конечном итоге скрыто реализацией. В файл, в консоль, в эппл, в базу данных.

 protocol Listener {}

 class Processor {}

 class Server {
    var listeners = [Listener]
    var processor = Processor
 }

 Какой-то абстрактный сервер, обрабатывающий запросы. Просто суёт запрос в Processor и возвращает полученный ответ обратно в Listener.
 Запросы в данном случае однотипные, потому нужен только один и только этот Processor и потому здесь композиция
 Запросы могут поступать из разных источников, по разным протоколам, например UPD, HTTPS, в разных форматах — plain text, JSON. Для каждого конкретного случая пишется свой Listener, который получает запрос и преобразует его к утверждённому виду. Здесь использована агрегация, позволяющая менять эти объекты

 struct Point {
    var x, y: Float
 }

 struct Size {
    var width, height: Float
 }

 struct Rect {
    var origin: Point
    var size: Size
 }

 Здесь композиция во всех трех структурах — базовые вещи, не предназначенные как-то измениться в будущем. Rect всегда состоит из Point и Size. Только композиция

*/


// 3. Создается приложение интернет-магазин для продажи книг.
// Реализуйте модели данных (используя классы, структуры, перечисления на ваш выбор):
// - заказ
// - платеж
// - чек
// - книга
// - пользователь
// Добавьте любые свойства на ваше усмотрение, которые необходимы для работоспособности интернет-магазина.

struct Order {
    let orderId: Int
    let clientId: Int
    let date: Int64 // UNIX time
    let books: [String]
    let isPaid: Bool // false, станет true когда будет получен Receipt с таким orderId
    let isShipped: Bool // false, станет true когда товар будет передан в доставку
    let shipmentData: ShipmentData
}

struct Receipt {
    let receiptId: Int
    let orderId: Int
    let date: Int64 // UNIX time
    let paymentProvider: PaymentProvider
}

struct PaymentProvider {
    // любые данные для идентификации и связи с банком, эплстором, ОПСОСом
}

struct Book {
    let bookId: String
    let authorId: Int // для удобности поиска
    let title: String
    let description: String
    let cover: String // обложка
}

struct Author {
    let authorId: Int64
    let name: String
}

struct Client {
    let clientId: Int
    let firstName, lastName, MiddleName: String // а то СДЭКом не отправить
    let email: String // чтобы задалбывать скидками и акциями
    let birthDate: Int64 // чтобы задалбывать персональными предложениями
    var discount: Float // пересчитывается в момент получения очередного Receipt, зависит от суммы всех платежей

    enum OrdersKind {case All, Created, Paid, Shipped}
    func getOrders(_ kind: OrdersKind) -> [Order] {
        return []
    }

    var address: [ShipmentData]
}

struct ShipmentData {
    var address: String
    var shipmentProvider: Int
    // тут ещё данные о доставке, о которых я не могу знать
}


// 4. Создать модель данных для приложения TODO.

struct Entry {
    var icon: Int // индекс
    var Title: String
    var Description: String? // на случай, если надо что-то дополнить
    enum Priority { case Lowest, Low, Medium, High, Highest}
    var priority: Priority
    var dueDate: Int64
    var isComplete: Bool
    var children: [Entry]? // для подзадач, когда понадобится
}

struct Entries {
    var icon: Int // индекс
    var name: String
    var entries: [Entry]
}

// TODO List представлен как структура Entries, в которой есть икона, название и массив записей. Таких списков может быть несколько
// Запись Entry имеет икону, текст, большой текст на всякий случай не на каждый день, значок приоритетности, дедлайн, по желанию поздзадачи
