#include "Service.h"

using namespace AirlineApp;

Service::Service(String^ serviceName) : serviceName(serviceName) {}

String^ Service::ServiceName::get() {
    return serviceName;
}

void Service::ServiceName::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Service name cannot be empty");
    }
    serviceName = value;
}
