import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getcollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
          fromFirestore: (docSnapshot, _) =>
              TaskModel.fromjson(docSnapshot.data()!),
          toFirestore: (taskmodel, _) => taskmodel.toJson());

  static Future<void> addToFireStore(TaskModel task) async {
    // create or get the collection if exist
    CollectionReference<TaskModel> taskCollection = getcollection();
    // create the document
    DocumentReference<TaskModel> docRef = taskCollection.doc();

    task.id = docRef.id;
    //  put the task inside the doc
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    CollectionReference<TaskModel> taskCollection = getcollection();
    // get a snapshoot of the collection
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTask(String taskId) async {
    CollectionReference<TaskModel> taskCollection = getcollection();
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTask(TaskModel updatedTask) async {
    CollectionReference<TaskModel> taskCollection = getcollection();
    DocumentReference<TaskModel> docRef = taskCollection.doc(updatedTask.id);
    return docRef.set(updatedTask);
  }
}
