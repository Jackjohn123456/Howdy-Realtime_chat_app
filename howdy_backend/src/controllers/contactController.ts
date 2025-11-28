import { Request, Response } from "express";
import pool from "../models/db";
import { log } from "console";

export const fetchContacts = async (req: Request, res: Response) => {
    let userId = null;
    if (req.user) {
        userId = req.user.id;
    }
    try {
        const result = await pool.query(
            `
            SELECT u.id AS contact_id,u.username,u.email
            FROM contacts c
            JOIN users u ON u.id = c.contact_id
            WHERE c.user_id = $1
            ORDER BY u.username ASC
            `,
            [userId]
        );
        return res.json(result.rows);
    }
    catch (e) {
        log(e)
        return res.status(500).json({ error: "Failed to fetch contacts" });
    }
}

export const addContact = async (req: Request, res: Response) => {
    let userId = null;
    if (req.user) {
        userId = req.user.id;
    }
    const { contactEmail } = req.body;

    try {

        const contactExist = await pool.query(
            `
            SELECT id FROM users WHERE email=$1  
            `,
            [contactEmail]
        );

        if (contactExist.rowCount === 0) {
            return res.status(400).json({ error: 'Contact Not Found' });
        }

        const contactId = contactExist.rows[0].id;

        await pool.query(
            `
            INSERT INTO contacts (user_id,contact_id)
            VALUES ($1,$2)
            ON CONFLICT DO NOTHING
            `,
            [userId, contactId]
        );
        return res.status(201).json({ message: 'Contact Added Succefully' })
    } catch (error) {
        log(error)
        return res.status(500).json({ error: 'Failed to add contact' });
    }
}

export const recentContacts = async(req:Request, res:Response) =>{
    let userId = null;
    if (req.user) {
        userId = req.user.id;
    }
    try {
        const result = await pool.query(
            `
            SELECT u.id AS contact_id,u.username,u.email
            FROM contacts c
            JOIN users u ON u.id = c.contact_id
            WHERE c.user_id = $1
            ORDER BY c.created_at DESC
            LIMIT 8
            `,
            [userId]
        );
        return res.json(result.rows);
    } catch (error) {
        log(error)
        res.status(500).json({error:"Error Fetching recent contacts"});
    }
}