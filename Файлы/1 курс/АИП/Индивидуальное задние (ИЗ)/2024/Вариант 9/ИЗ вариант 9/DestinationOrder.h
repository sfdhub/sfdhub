#pragma once
using namespace System;

namespace TaxiApp {
    public ref class DestinationOrder {
    private:
        String^ destination;

    public:
        DestinationOrder(String^ destination);

        property String^ Destination {
            String^ get();
            void set(String^ value);
        }
    };
}
