#include "DestinationOrder.h"

using namespace TaxiApp;

DestinationOrder::DestinationOrder(String^ destination) : destination(destination) {}

String^ DestinationOrder::Destination::get() {
    return destination;
}

void DestinationOrder::Destination::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Destination cannot be empty");
    }
    destination = value;
}
