import { log } from "console";
import { Request, Response } from "express";
import pool from "../models/db";

export const fetchAllMessagesByConversationId = async(req:Request,res:Response)=>{
    const {conversationId} = req.params;
    try{
         const result  = await pool.query(
            ` 
            SELECT m.id,m.content,m.sender_id,m.conversation_id,m.created_at
            FROM messages m
            WHERE m.conversation_id = $1
            ORDER BY m.created_at ASC
            `,
            [conversationId]
        );
        return res.json(result.rows);
    }   
    catch(e){
        log(e);
        res.status(500).json({
            error:"Message Fetch Error",conversationId
        })
    } 
}

export const saveMessage = async(conversationId:string,senderId:string,content:string)=>{
     try{
         const result  = await pool.query(
            ` 
            INSERT INTO messages (conversation_id,sender_id,content)
            VALUES($1,$2,$3)
            RETURNING *;
            `,
            [conversationId,senderId,content]
        );
        return result.rows[0];
    }   
    catch(e){
        log(e);
        throw new Error(`Falied to Save Message ${e}`);
    } 
}