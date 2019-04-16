#include "Server.h"
#include <iostream>

using namespace std;

Server::Server()
{
    serverAddr.sin_family = PF_INET;
    serverAddr.sin_port = htons(SERVER_PORT);
    serverAddr.sin_addr.s_addr = inet_addr(SERVER_IP);
    //listener
    listener = 0;
    //epoll fd
    epfd = 0;
}
void Server::init()
{
    cout << "Init Server ... " << endl;

    listener = socket(PF_INET, SOCK_STREAM, 0);
    if (listener < 0) {
        perror("listener error");
        exit(-1);
    }
    if (bind(listener, (sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
        perror("bind error");
        exit(-1);
    }

    int ret = listen(listener, 5);
    if (ret < 0) {
        perror("listen error");
        exit(-1);
    }

    cout << "start to listen: " << SERVER_IP << endl;

    epfd = epoll_create(EPOLL_SIZE);
    if (epfd < 0) {
        perror("epoll create error");
        exit(-1);
    }
    addfd(epfd, listener, true);
}

void Server::close()
{
    ::close(epfd);
    ::close(listener);
}

int Server::sendBroadcastMessage(int clientfd)
{
    //buf: rec the new mes
    //message: save the format message
    char buf[BUF_SZIE], message[BUF_SZIE];
    bzero(buf, BUF_SZIE);
    bzero(message, BUF_SZIE);
    cout << "read form client : clientId--" << clientfd << endl;
    int len = recv(clientfd, buf, BUF_SZIE, 0);
    //if the client close the connection
    if (len == 0) {
        ::close(clientfd);
        //remove the clientfd from clinets_list
        clients_list.remove(clientfd);

        cout << "ClientId :" << clientfd << " closed , there are " << clients_list.size() << "int the chatroom" << endl;
    }
    //send the message broadcast
    else {
        //if there are  clients in the chatroom
        if (clients_list.size() == 1) {
            send(clientfd, CAUTION, strlen(CAUTION), 0);
            return len;
        }
        //format send the message
        sprintf(message, SERVER_MESSAGE, clientfd, buf);

        list<int>::iterator it;
        for (it = clients_list.begin(); it != clients_list.end(); ++it) {
            if (*it != clientfd) {
                if (send(*it, message, BUF_SZIE, 0) < 0) {
                    return -1;
                }
            }
        }
    }
    return len;
}

void Server::start()
{
    //epoll queue
    static epoll_event events[EPOLL_SIZE];
    //init the server
    init();

    while (1) {
        //the num of the event
        int epoll_events_count = epoll_wait(epfd, events, EPOLL_SIZE, -1);

        if (epoll_events_count < 0) {
            perror("epoll error");
            break;
        }

        cout << "epoll_events_count =\n"
             << epoll_events_count << endl;
        //handle the event
        for (int i = 0; i < epoll_events_count; i++) {
            int sockfd = events[i].data.fd;
            //new user connect
            if (sockfd == listener) {
                sockaddr_in client_address;
                socklen_t client_addrLength = sizeof(sockaddr_in);
                int clientfd = accept(listener, (sockaddr*)&client_address, &client_addrLength);

                cout << "client connection from: "
                     << inet_ntoa(client_address.sin_addr) << ":"
                     << ntohs(client_address.sin_port) << ", cientfd = "
                     << clientfd << endl;

                addfd(epfd, clientfd, true);

                //clients_list save the client
                clients_list.push_back(clientfd);
                cout << "add new clientfd = " << clientfd << "to epoll " << endl;
                cout << "Now there are " << clients_list.size() << "clients in the chatroom" << endl;
                //server send the message
                cout << "welcome message" << endl;
                char message[BUF_SZIE];
                memset(&message, 0, BUF_SZIE);
                //clientg -> SERVER_WELCOME -> message,return strlen(message)
                sprintf(message, SERVER_WELCOME, clientfd);
                int ret = send(clientfd, message, BUF_SZIE, 0);
                if (ret < 0) {
                    perror("send error");
                    close();
                    exit(-1);
                }

            }
            //handle the message from client , broadcast the message
            else {
                int ret = sendBroadcastMessage(sockfd);
                if (ret < 0) {
                    perror("");
                    close();
                    exit(-1);
                }
            }
        }
    }
    //close the server
    close();
}