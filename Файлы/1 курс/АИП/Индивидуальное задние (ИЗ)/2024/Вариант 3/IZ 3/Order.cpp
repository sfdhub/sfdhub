#include "Order.h"

using namespace AirlineApp;

Order::Order(DateTime orderDate) : orderDate(orderDate) {
    ticketOrders = gcnew List<TicketOrder^>();
    services = gcnew List<Service^>();
}

DateTime Order::OrderDate::get() {
    return orderDate;
}

List<TicketOrder^>^ Order::TicketOrders::get() {
    return ticketOrders;
}

List<Service^>^ Order::Services::get() {
    return services;
}

void Order::AddTicketOrder(TicketOrder^ ticketOrder) {
    ticketOrders->Add(ticketOrder);
}

void Order::AddService(Service^ service) {
    services->Add(service);
}
