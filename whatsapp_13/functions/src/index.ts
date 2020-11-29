import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

export const sendNotifications = functions.firestore
    .document("conversations/{conversationId}/messages/{messageId}")
    .onCreate(async (snapshot, context) => {
        const { message, senderId } = snapshot.data();
        const { conversationId } = context.params;

        const conversation = await db.collection("conversations").doc(conversationId).get();

        const members :string[] = conversation.get("members");

        members.filter(member => member !== senderId).forEach(async (value, index) => {
            const profile = await db.collection("profile").doc(value).get();
            const token = profile.get("token");

            if (!token) {
                return;
            }

            await admin.messaging().sendToDevice(token, {
                data: {
                    conversationId,
                },
                notification: {
                    title: "You have a message",
                    body: message,
                },
            });
        });
     });
