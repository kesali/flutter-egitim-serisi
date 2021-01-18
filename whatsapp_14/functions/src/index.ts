import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

exports.sendNotifications = functions.firestore
  .document('conversations/{conversationId}/messages/{messageId}')
  .onCreate(async (snapshot, context) => {
    const { message, senderId } = snapshot.data();

    const { conversationId } = context.params;

    const conversation = await db
      .collection('conversations')
      .doc(conversationId)
      .get();

    const members: string[] = conversation.get('members');

    members
      .filter((member) => member !== senderId)
      .map(async (member) => {
        const profile = await db.collection('profile').doc(member).get();
        const token = profile.get('token');

        if (!token) {
          return;
        }

        await admin.messaging().sendToDevice(token, {
          data: {
            conversationId,
            userId: member,
            senderId,
          },
          notification: {
            title: 'You have a message',
            body: message,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
          },
        });
      });
  });
