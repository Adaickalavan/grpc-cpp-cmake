#include <boost/beast/core.hpp>
#include <boost/beast/http.hpp>
// #include <boost/beast/version.hpp>
// #include <boost/asio/connect.hpp>
// #include <boost/asio/ip/tcp.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <cstdlib>
#include <iostream>
#include <iterator>
#include <iterator>
#include <string>
#include <vector>
#include "opencv2/opencv.hpp"

namespace pt = boost::property_tree;
namespace beast = boost::beast;     // from <boost/beast.hpp>
namespace http = beast::http;       // from <boost/beast/http.hpp>
namespace net = boost::asio;        // from <boost/asio.hpp>

using std::cout;
using tcp = net::ip::tcp;           // from <boost/asio/ip/tcp.hpp>
using std::ostream;
using std::ostream_iterator;
using std::pair;
using std::vector;

template<class T>
ostream& operator<<(ostream& os, const vector<T>& v){
    copy(v.begin(), v.end(), ostream_iterator<T>(os, " ")); 
    return os;
}

// Performs an HTTP GET and prints the response
int main(int argc, char** argv)
{
    cv::VideoCapture cap(0);
    // open the default camera, use something different from 0 otherwise;
    // Check VideoCapture documentation.
    // Check if camera opened successfully
    if(!cap.isOpened()){
        std::cout << "Error opening video stream or file" << std::endl;
        return -1;
    }
    // while(1){
        cv::Mat frame;
        // Capture frame-by-frame
        cap >> frame;
        // If the frame is empty, break immediately
        // if (frame.empty())
        //     break;

        vector<unsigned char> imBytes;
        cv::imencode(".jpg", frame, imBytes);
        
        // cout<< imBytes;
        // return 1;

        // Display the resulting frame
        // cv::imshow( "Frame", frame );
        // Press  ESC on keyboard to exit
        // char c = (char)cv::waitKey(25);
        // if(c == 27)
        //     break;
    // }




    try
    {
        // Check command line arguments.
        // if(argc != 4 && argc != 5)
        // {
        //     std::cerr <<
        //         "Usage: http-client-sync <host> <port> <target> [<HTTP version: 1.0 or 1.1(default)>]\n" <<
        //         "Example:\n" <<
        //         "    http-client-sync www.example.com 80 /\n" <<
        //         "    http-client-sync www.example.com 80 / 1.0\n";
        //     return EXIT_FAILURE;
        // }
        // auto const host = argv[1];
        auto const host = "http://localhost:8501/v1/models";
        auto const port = "8501";
        auto const target = "/tfModel:predict";
        cout << argv[1] <<" - " << argv[2] << " - "<< argv[3] << "\n";
        // return 1;
        int version = 11;

        // The io_context is required for all I/O
        net::io_context ioc;

        // These objects perform our I/O
        tcp::resolver resolver(ioc);
        beast::tcp_stream stream(ioc);

        // Look up the domain name
        auto const results = resolver.resolve(host,port);

        // Make the connection on the IP address we get from a lookup
        stream.connect(results);

        // Set up an HTTP POST request message
        http::request<http::string_body> req{http::verb::post, target, version};
        req.set(http::field::host, host);
        req.set(beast::http::field::content_type, "application/json; charset=utf-8");

        // POST JSON message
        // {
        //     "signature_name" : "serving_default",
        //     "instances" : [                
        //         {
		   // 		      "image_bytes": 
        //                 {
        //                     "b64": "aW1hZ2UgYnl0ZXM=",
        //                 }
        //         },
        //     ]
		// }
        // Form JSON message
        pt::ptree request;
        request.put("signature_name", "serving_default");
        pt::ptree image;
        image.put("b64", imBytes);
        pt::ptree instance_node;
        instance_node.add_child("image_bytes",image);      
        pt::ptree instances_node;
        instances_node.push_back(std::make_pair("", instance_node));
        request.add_child("instances", instances_node);

        // Print the generated JSON
        pt::write_json(cout, request);

        // Send the HTTP request to the remote host
        http::write(stream, req);

        // This buffer is used for reading and must be persisted
        beast::flat_buffer buffer;

        // Declare a container to hold the response
        http::response<http::string_body> res;

        // Receive the HTTP response
        http::read(stream, buffer, res);

        // Response JSON message
        // {
        //     "predictions":[
        //         {
        //             "classes": int,
        //             "probabilities": int[],
        //         },
        //     ]
        // }       
        // Parse response
        std::istringstream istrstream(res.body());
        pt::ptree response;
        pt::read_json(istrstream, response);
        vector<std::pair<int,vector<float>>> predictions;
        for (pt::ptree::value_type &prediction : response.get_child("predictions")){
            int classes = prediction.second.get<int>("classes");

            vector<float> prob;
            for (pt::ptree::value_type &probabilities : prediction.second.get_child("probabilities")){
                prob.push_back(probabilities.second.get_value<float>());
            }
            
            predictions.push_back(std::pair(classes, prob));
        }

        // Print response partially
        pt::write_json(cout, response);
        // cout << predictions[0].first << " -- " << predictions[0].second << "\n";

        // Gracefully close the socket
        beast::error_code ec;
        stream.socket().shutdown(tcp::socket::shutdown_both, ec);

        // not_connected happens sometimes
        // so don't bother reporting it.
        if(ec && ec != beast::errc::not_connected)
            throw beast::system_error{ec};

        // If we get here then the connection is closed gracefully
    }
    catch(std::exception const& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    // When everything done, release the video capture object
    cap.release();

    // Closes all the frames
    cv::destroyAllWindows();


    return EXIT_SUCCESS;
}
