#pragma once

#include "TicketOrder.h"
#include "Service.h"

using namespace System;
using namespace System::Collections::Generic;

namespace AirlineApp {
    public ref class Order {
    private:
        DateTime orderDate;
        List<TicketOrder^>^ ticketOrders;
        List<Service^>^ services;

    public:
        Order(DateTime orderDate);

        property DateTime OrderDate {
            DateTime get();
        }

        property List<TicketOrder^>^ TicketOrders {
            List<TicketOrder^>^ get();
        }

        property List<Service^>^ Services {
            List<Service^>^ get();
        }

        void AddTicketOrder(TicketOrder^ ticketOrder);
        void AddService(Service^ service);
    };
}
