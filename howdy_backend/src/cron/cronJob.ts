// import nodeCron from "node-cron";
// import pool from "../models/db";
// import { generationDailyQuestion } from "../services/openAiService";
// import { log } from "console";

//0 9 * * *
//* * * * *
// nodeCron.schedule('0 9 * * *', async () => {
//     try {
//         log("Job Scheduled:::::::::::::::::")
//         const conversation = await pool.query(`SELECT id FROM conversations `);
//         for (const conv of conversation.rows) {
//             const question = await generationDailyQuestion();
//             log(question);
//             await pool.query(
//                 `
//             INSERT INTO messages (conversation_id,sender_id,content)
//             VALUES ($1,'00000000-0000-0000-0000-000000000000',$3)
//             `,
//                 [conv.id,question]
//             );
//             log("Daily Question Sent for conversation",conv.id);
//         }
//     } catch (error) {
//          log("Error sending Daily question",error);
//     }
// });