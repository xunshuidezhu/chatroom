#ifndef CHARTROOM_COMMON_H
#define CHARTROOM_COMMON_H

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <iostream>
#include <list>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/epoll.h>
#include <sys/socket.h>
#include <unistd.h>
#include <pthread.h>

using namespace std; 

//default ip
#define SERVER_IP "127.0.0.1"
//default port
#define SERVER_PORT 8080
//epoll max handle
#define EPOLL_SIZE 5000
//buffer size 65536
#define BUF_SZIE 0xFFFF
//the welcome information
#define SERVER_WELCOME "Welcome to the chatroom, the client id is#%d"
//the user rec the chat message
#define SERVER_MESSAGE "ClinetID %d say >> %s"
//exit the chatroom
#define EXIT "EXIT"
//the caution message
#define CAUTION "You are the only one in the chatroom"
//add fd to the epollfd
//enable_et:true ET/false LT
static void addfd(int epollfd, int fd, bool enable_et)
{
    epoll_event ev;
    
    ev.data.fd = fd;
    ev.events = EPOLLIN;
    if (enable_et)
        ev.events = EPOLLIN | EPOLLET;
    epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);

    fcntl(fd, F_SETFL, fcntl(fd, F_GETFD, 0) | O_NONBLOCK);
    cout << "fd added to epoll " << endl; 
}
#endif