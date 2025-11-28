import { error, log } from "console";
import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";

export const verifyToken = (req:Request,res:Response,next:NextFunction):void =>{
    const token  = req.headers.authorization?.split(' ')[1];
    //bearer auth
    if(!token){
        res.status(403).json({
            error:'No Token Provided'
        });
        return ;
    }
    try{
        const decoded = jwt.verify(token,process.env.JWT_SECRET || 'howdysecretkey');
        req.user = decoded as {id:string};
        next();
    }
    catch(e){
        log(e)
        res.status(401).json({
            error:"Invalid Token"
        });
    }
} 