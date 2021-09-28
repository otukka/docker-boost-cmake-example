#include <boost/asio.hpp>
#include <iostream>
#include <sstream>

#include <functional>


#include <ctime>
#include <chrono>



std::string current_time_string()
{
    std::stringstream ss;
    auto t = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    ss << std::ctime(&t);
    return ss.str();

}


void timer_print_handler()
{
    std::cout << "Timer triggered : " << current_time_string() << "\n";
}


int main(int argc, char const *argv[])
{
    std::cout << "Program started.\n";

    // "runner"
    boost::asio::io_service service;

    boost::asio::deadline_timer timer(service, boost::posix_time::seconds(1));


    // add handler with lambda
    timer.async_wait([](auto){std::cout << "Timer triggered : " << current_time_string() << "\n";});

    // alternative way with bind
    timer.async_wait(std::bind(timer_print_handler));

    std::cout << "The clock before run : " << current_time_string() << "\n";

    service.run();

    std::cout << "The clock after run : " << current_time_string() << "\n";

    std::cout << "Program ended.\n";
    return 0;
}
