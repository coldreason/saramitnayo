const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();
exports.check = functions.https.onRequest(async(request, response) => {
    const doc = await admin.firestore().collection('current').doc('current').get();
    response.status(200).send(doc.data());
  });

exports.initialize = functions.https.onRequest(async(request, response) => {
    const doc = await admin.firestore().collection('setting').doc('setting').get();
    response.status(200).send(doc.data());
});

exports.update = functions.https.onRequest(async(request, response) => {
    const timestamp = admin.firestore.FieldValue.serverTimestamp();
    console.log(request.body);
    await admin.firestore().collection('current').doc('current').update({forceUpdate:false,lastUpdatedAt:timestamp,state:request.body['state']});    
    await admin.firestore().collection('data').doc().set({state:request.body['state'],time:timestamp});
    response.status(200).send(request.body);
});

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.status(200).send("Hello from Firebase!");
});
