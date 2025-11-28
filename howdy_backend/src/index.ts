import express ,{Request,Response} from 'express';
import {json} from "body-parser";
import { log } from 'console';
import {Server} from 'socket.io';
import http from 'http';
import authRoutes from './routes/authRoutes';
import conversationRoutes from './routes/conversationRoutes';
import messageRoutes from './routes/messageRoutes';
import contactRoutes from './routes/contactRoutes';
import { saveMessage } from './controllers/messageController';
const app = express();

const server = http.createServer(app);
app.use(json());

const io = new Server(server,{
    cors:{
        origin:'*',
    }
});

app.use('/auth',authRoutes);
app.use('/conversation',conversationRoutes);
app.use('/messages',messageRoutes);
app.use('/contacts',contactRoutes);

io.on('connection',(socket)=>{
     
    log('A User Connected',socket.id);

    socket.on('joinConversation',(conversationId)=>{
        socket.join(conversationId);
        log("User Joined conversation:",conversationId);
    });

    socket.on('sendMessage',async (message)=>{

        const {conversationId,senderId,content} = message;
        try {
            const savedMessage = await saveMessage(conversationId,senderId,content);
            log(saveMessage); 
            io.to(conversationId).emit('newMessage',savedMessage); 
            io.emit('conversationUpdated',{
                conversationId,
                lastMessage:savedMessage.content,
                lastMessageTime:savedMessage.created_at
            })
        } catch (error) {
            log('failed to save message',error)
        }
    });

    socket.on('disconnect',()=>{
        log("User Disconnected",socket.id);
    });
});

const PORT = process.env.PORT || 6000;

server.listen(PORT,()=>{
    log(`Server is running on port ${PORT}`);
});