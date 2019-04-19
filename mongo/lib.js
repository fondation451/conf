//// Library of usefull function for mongoDB

// Find the collection of an object with its ID
function FIND(id, field) {
    db.getCollectionNames().forEach(function(collName) {
        const doc = db.getCollection(collName).findOne({ field: ObjectId(id)});
        if(doc != null) print(doc._id + " was found in " + collName);
     });
}
