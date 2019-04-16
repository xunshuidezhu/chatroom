#ifndef CHATROOM_CLIENT_H
#define CHATROOM_CLIENT_H

#include <string>
#include "Common.h"
#include <sys/types.h>
using namespace std;

//client class...
class Client
{
public:
    //constructor
    Client();
    //connect the server
    void Connect();
    //close the client
    void Close();
    //start the client
    void Start();
private:
    //the server socket
    int sock;
    //the process id
    pid_t pid;
    //the epoll_create return 
    int epfd;
    //create pipe, fd[0] the father read, fd[1] the child write
    int pipe_fd[2];
    //if the client work
    bool isClientWork;
    //chat message buffer
    char message[BUF_SZIE];
    //server ip + port
    sockaddr_in serverAddr;

};


#endif //CHATROOM_CLINET_H