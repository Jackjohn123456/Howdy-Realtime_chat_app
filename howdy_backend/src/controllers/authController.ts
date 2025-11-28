import { Request, Response } from "express";
import bcrypt from "bcrypt";
import pool from "../models/db";
import jwt from 'jsonwebtoken'
import { log } from "console";


const SALT_ROUNDES = 10;
const JWT_SECRET = process.env.JWT_SCRET || 'howdysecretkey';

export const register = async (req: Request, res: Response):Promise<any> => {
    try {
        log("Regestration Called");
        const { username, email, password } = req.body;
        const hashedPassword = await bcrypt.hash(password, SALT_ROUNDES);
        const result = await pool.query(
            'INSERT INTO users (username,email,password) VALUES ($1,$2,$3) RETURNING *',
            [username, email, hashedPassword]
        );
        const user = result.rows[0];
        res.status(201).json({
            message: 'User Registered Successfully', user
        });
    }
    catch (e) {
        log(e)
        res.status(500).json({
            error: 'User Registration Error'
        });
    }
};

export const login = async (req: Request, res: Response):Promise<any> => {
    try {
        const { email, password } = req.body;
        const result = await pool.query(
            'SELECT * FROM users WHERE email=$1',
            [email]
        );
        const user = result.rows[0];
        if (!user) return res.status(404).json({
            message: 'User Not Found'
        });
        const isMatch = bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({
            message: 'Invalid Credentials'
        });
        const token = jwt.sign({id:user.id}, JWT_SECRET, { expiresIn: '10h' });
        const finalresult = {...user,token}
        res.status(200).json({
            user: finalresult,
        });
    }
    catch (e) {
        log(e)
        res.status(500).json({
            error: 'Error logging In',
        });
    }
};