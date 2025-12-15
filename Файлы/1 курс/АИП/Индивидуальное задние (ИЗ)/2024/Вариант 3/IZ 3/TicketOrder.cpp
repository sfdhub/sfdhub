#include "TicketOrder.h"

using namespace AirlineApp;

TicketOrder::TicketOrder(String^ flightNumber) : flightNumber(flightNumber) {}

String^ TicketOrder::FlightNumber::get() {
    return flightNumber;
}

void TicketOrder::FlightNumber::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Flight number cannot be empty");
    }
    flightNumber = value;
}
