const functions = require("firebase-functions");
const admin = require("firebase-admin");
const csv = require("csv-parser");
const {Storage} = require("@google-cloud/storage");
const {Readable} = require("stream");

admin.initializeApp();
const firestore = admin.firestore();
const storage = new Storage();

exports.parseCsvAndStoreSchedule = functions.storage
  .object()
  .onFinalize(async (object) => {
    const bucketName = object.bucket;
    const filePath = object.name;

    if (!filePath.endsWith(".csv")) {
      console.log("Not a CSV file. Skipping.");
      return null;
    }

    const file = storage.bucket(bucketName).file(filePath);
    const contents = await file.download();
    const data = contents[0].toString("utf-8");

    const results = [];
    await new Promise((resolve, reject) => {
      Readable.from([data])
        .pipe(csv())
        .on("data", (row) => {
          results.push(row);
        })
        .on("end", resolve)
        .on("error", reject);
    });

    const batch = firestore.batch();
    results.forEach((row) => {
      const busRef = firestore.collection("buses").doc();
      batch.set(busRef, {
        name: row.name,
        route: row.route,
        schedule: row.schedule,
        district: row.district,
        seats: Array.from({length: 40}, (_, i) => ({
          id: `S${i + 1}`,
          isBooked: false,
          userId: null,
        })),
      });
    });

    await batch.commit();
    console.log("CSV processed and buses added.");
    return null;
  });
