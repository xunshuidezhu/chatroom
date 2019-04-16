#include <iostream>

#include "Client.h"

using namespace std;

Client::Client()
{
    serverAddr.sin_family = PF_INET;
    serverAddr.sin_port = htons(SERVER_PORT);
    serverAddr.sin_addr.s_addr = inet_addr(SERVER_IP);

    //init the socket
    sock = 0;
    //init the pid
    pid = 0;
    //the client stat
    isClientWork = true;
    //epoll fd
    epfd = 0;
}
void Client::Connect()
{
    cout << "Connect server: " << SERVER_IP << " : " << SERVER_PORT << endl;
    //create the socket
    sock = socket(PF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        perror("sock error");
        exit(-1);
    }
    //connect the server
    if (connect(sock, (sockaddr*)&serverAddr, sizeof(serverAddr)) < 0) {
        perror("connect error");
        exit(-1);
    }
    //create the pipe, the pipe[0] used to the father read, the pipe[1] used to the child write
    if (pipe(pipe_fd) < 0) {
        perror("pipe error");
        exit(-1);
    }
    //create the epoll
    epfd = epoll_create(EPOLL_SIZE);
    if (epfd < 0) {
        perror("epfd error");
        exit(-1);
    }
    //add the sock and the pipe_fd[0](the read) to the epfd
    addfd(epfd, sock, true);
    addfd(epfd, pipe_fd[0], true);
}
void Client::Close()
{
    if (pid) {
        //close the father pipe(read)
        close(pipe_fd[0]);
        //close the socket
        close(sock);
    } else {
        //close the child pipe(write)
        close(pipe_fd[1]);
    }
}
void Client::Start()
{
    //epoll events queue
    static epoll_event events[2];
    //conect the server
    Connect();
    //create the child process
    pid = fork();
    if (pid < 0) {
        //fork error
        perror("fork error");
        close(sock);
        exit(-1);
    } else if (pid == 0) {
        /**
         * -----------------
         * the child process
         * -----------------
         **/
        //close the read pipe
        close(pipe_fd[0]);
        cout << "input 'exit' to  exit the chatroom" << endl;
        //if the client work send message to the server
        while (isClientWork) {
            bzero(&message, BUF_SZIE);
            fgets(message, BUF_SZIE, stdin);
            //if client exit
            if (strncasecmp(message, EXIT, strlen(EXIT)) == 0) {
                isClientWork = 0;
            }
            //child write the message to the pipe[1]
            else {
                if (write(pipe_fd[1], message, strlen(message) - 1) < 0) {
                    perror("fork error");
                    exit(-1);
                }
            }
        }
    }
    /**
    --------------
    father process
    --------------
    **/
    else {
        //father process : read the message from the pipe
        //close the pipe[1](child pipe to write)
        close(pipe_fd[1]);
        while (isClientWork) {
            int epoll_events_count = epoll_wait(epfd, events, 2, -1);
            //handle the events in the queue
            for (int i = 0; i < epoll_events_count; ++i) {
                bzero(&message, BUF_SZIE);
                //the message from the server
                if (events[i].data.fd == sock) {
                    int ret = recv(sock, message, BUF_SZIE, 0);
                    if (ret == 0) {
                        cout << "Server closed connection: " << sock << endl;
                        close(sock);
                        isClientWork = 0;
                    } else {
                        cout << message << endl;
                    }
                } 
                //child process write the message, father process send it to the server
                else {
                    //father process read the message from the pipe
                    int ret = read(events[i].data.fd, message, BUF_SZIE);
                    if (ret == 0){
                        isClientWork = 0;
                    }else{
                        send(sock, message, BUF_SZIE, 0);
                    }
                }
            }
        }
    }
    Close();
}