import {Router} from "express";
import { verifyToken } from "../middlewares/authMiddleware";
import {checkOrCreateconversation, fetchAllconversationsByUserId} from "../controllers/conversationController";

const router = Router();

router.get('/',verifyToken,fetchAllconversationsByUserId);
router.post('/check-or-create',verifyToken,checkOrCreateconversation);
//router.get('/:id/get-daily-question',verifyToken,getDailyQuestion);

export default router;