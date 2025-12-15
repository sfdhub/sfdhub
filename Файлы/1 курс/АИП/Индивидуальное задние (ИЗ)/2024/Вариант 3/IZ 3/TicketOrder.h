#pragma once
using namespace System;

namespace AirlineApp {
    public ref class TicketOrder {
    private:
        String^ flightNumber;

    public:
        TicketOrder(String^ flightNumber);

        property String^ FlightNumber {
            String^ get();
            void set(String^ value);
        }
    };
}
