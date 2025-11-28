// import OpenAI from "openai";
// import { opneAiKey } from "../utils/config";

// const  openAi =new OpenAI({
//     apiKey:opneAiKey
// });

// export const generationDailyQuestion = async():Promise<string> =>{
//     try {
//         const message = await openAi.chat.completions.create(
//             {
//                 model:'gpt-3.5-turbo',
//                 messages:[
//                     {
//                         role:'user',
//                         content:'Generate a fun and Engaging question for a chat application',
//                     }
//                 ],
//                 max_completion_tokens:50
//             }
//         );
//         return message.choices[0]?.message?.content?.trim() || 'What\'s your favourite Hobby?';
//     } catch (error) {
//         console.error("error generating daily question",error);
//         return 'What\'s your favourite Hobby?';
//     }
// }