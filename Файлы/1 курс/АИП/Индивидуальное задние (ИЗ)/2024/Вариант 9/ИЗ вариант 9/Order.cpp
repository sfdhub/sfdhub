#include "Order.h"

using namespace TaxiApp;

Order::Order() {
    destinationOrders = gcnew List<DestinationOrder^>();
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

List<DestinationOrder^>^ Order::DestinationOrders::get() {
    return destinationOrders;
}

void Order::AddDestinationOrder(DestinationOrder^ destinationOrder) {
    destinationOrders->Add(destinationOrder);
}
