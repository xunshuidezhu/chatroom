# chatroom
##the chatroom with the epoll

###1.0版本聊天室，基于**epoll**
###**环境**：ubuntu16.04 + gcc + vscode + gdb
###**说明**此聊天室具备客户端和服务端，服务端接受新的客户端链接，并将每个客户端发来的信息发给所有客户端。客户端接受服务端发来的消息，并且可以将信息发送给服务端
###**how to start**make Server.o make Clinet.o make all
###**改进**后续会增加更多功能，增加线程池提高并发量，提高健壮性，使用reactor模型
