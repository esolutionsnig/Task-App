const functions = require('firebase-functions');
const admin = require('firebase-admin');

// initialise 
admin.initializeApp(functions.config().firebase);

const db = admin.firestore();
const fcm = admin.messaging();

const icon = 'https://firebasestorage.googleapis.com/v0/b/tasks-etech.appspot.com/o/taskIcon.png?alt=media&token=1ec9f338-39a5-4e86-9235-a664cb3b5a79';

// New User notification
// exports.newUser = functions.firestore.document("User/{any}").onCreate((change, context) => {
//     const 
// });

// Listen to new task added and send notification to all users
exports.sendToTopic = functions.firestore.document('tasks/{id}').onCreate(async snapshot => {
    const task = snapshot.data();
    const payload = {
        notification: {
            title: 'New task alert!',
            body: `${task.title} has been successfully created and added to your list of tasks.`,
            icon: icon,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    return fcm.sendToTopic('tasks', payload);
});

// Send notification to a specific device
exports.sendToDevice = functions.firestore.document('tasks/{id}').onCreate(async snapshot => {
    const task = snapshot.data();
    const querySnapshort = await db.collection('users').doc(task.userId).collection('tokens').get();
    
    const tokens = querySnapshort.docs.map(snap => snap.id);

    const payload = {
        notification: {
            title: 'Task expiration alert!',
            body: `You task is expring soon. Expriation date and time: ${task.endDateTime}. Task status: ${task.status}.`,
            icon: icon,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    return fcm.sendToDevice('tasks', payload);
});

exports.helloworld = functions.database.ref('notifications/{id}').onWrite(evt => {
    const payload = {
        notifications: {
            title: 'Message From Cloud',
            body: 'This is the body',
            badge: icon,
            sound: 'default',
        }
    };
    return db.ref('fcm_tokens').once('value').then(allToken => {
        if (allToken.val()) {
            console.log('Token Available');
            const token = Object.keys(allToken.val());
            return fcm.sendToDevice(token, payload);
        } else {
            console.log('No Token Found');
        }
    });
});