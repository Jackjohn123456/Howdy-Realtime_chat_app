import { Router } from "express";
import { verifyToken } from "../middlewares/authMiddleware";
import { addContact, fetchContacts, recentContacts } from "../controllers/contactController";

const route = Router();

route.get('/',verifyToken,fetchContacts);
route.post('/',verifyToken,addContact);
route.get('/recent',verifyToken,recentContacts);

export default route;