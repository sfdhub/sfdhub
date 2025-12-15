#include "Order.h"

using namespace BookStoreApp;

Order::Order() {
    bookOrders = gcnew List<BookOrder^>();
}

int Order::OrderNumber::get() {
    return orderNumber;
}

void Order::OrderNumber::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("Order number must be positive");
    }
    orderNumber = value;
}

List<BookOrder^>^ Order::BookOrders::get() {
    return bookOrders;
}

void Order::AddBookOrder(BookOrder^ bookOrder) {
    bookOrders->Add(bookOrder);
}
