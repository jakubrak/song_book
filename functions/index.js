// const functions = require("firebase-functions");
// const {defineString, defineSecret} = require("firebase-functions/params");
// const {Client} = require("@elastic/elasticsearch");
//
// const elasticUrl = defineString("ELASTIC_URL");
// const elasticUsername = defineSecret("ELASTIC_USERNAME");
// const elasticPassword = defineSecret("ELASTIC_PASSWORD");
//
// exports.onSongCreated = functions
//     .runWith({secrets: [elasticUsername, elasticPassword]})
//     .firestore.document("songs/{songId}")
//     .onCreate(async (snap, context) => {
//       const song = snap.data();
//       const id = context.params.songId;
//
//       const client = new Client({
//         node: elasticUrl.value(),
//         auth: {
//           username: elasticUsername.value(),
//           password: elasticPassword.value(),
//         },
//       });
//
//       await client.index({
//         index: "songs",
//         id: id,
//         body: song,
//       });
//     });
//
// exports.searchSongs = functions
//     .runWith({secrets: [elasticUsername, elasticPassword]})
//     .https.onCall(async (data, context) => {
//       const client = new Client({
//         node: elasticUrl.value(),
//         auth: {
//           username: elasticUsername.value(),
//           password: elasticPassword.value(),
//         },
//       });
//
//       const query = data.query;
//
//       const searchRes = await client.search({
//         index: "notes",
//         body: {
//           query: {
//             query_string: {
//               query: `*${query}*`,
//               fields: [
//                 "text",
//               ],
//             },
//           },
//         },
//       });
//
//       const hits = searchRes.body.hits.hits;
//
//       const songs = hits.map((h) => h["_source"]);
//       return {
//         songs: songs,
//       };
//     });
const functions = require("firebase-functions");
const vision = require("@google-cloud/vision");

const client = new vision.ImageAnnotatorClient();

// This will allow only requests with an auth token to access the Vision
// API, including anonymous ones.
// It is highly recommended to limit access only to signed-in users. This may
// be done by adding the following condition to the if statement:
//    || context.auth.token?.firebase?.sign_in_provider === 'anonymous'
//
// For more fine-grained control, you may add additional failure checks, ie:
//    || context.auth.token?.firebase?.email_verified === false
// Also see: https://firebase.google.com/docs/auth/admin/custom-claims
exports.annotateImage = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "unauthenticated",
        "annotateImage must be called while authenticated.",
    );
  }
  try {
    return await client.annotateImage(data);
  } catch (e) {
    throw new functions.https.HttpsError("internal", e.message, e.details);
  }
});
