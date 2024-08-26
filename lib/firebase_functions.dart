import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUserscollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
          fromFirestore: (docSnapshot, _) =>
              UserModel.fromjson(docSnapshot.data()!),
          toFirestore: (usermodel, _) => usermodel.toJson());

  static CollectionReference<TaskModel> getTaskscollection(String userid) =>
      getUserscollection()
          .doc(userid)
          .collection('tasks')
          .withConverter<TaskModel>(
              fromFirestore: (docSnapshot, _) =>
                  TaskModel.fromjson(docSnapshot.data()!),
              toFirestore: (taskmodel, _) => taskmodel.toJson());

  static Future<void> addToFireStore(TaskModel task, String userid) async {
    // create or get the collection if exist
    CollectionReference<TaskModel> taskCollection = getTaskscollection(userid);
    // create the document
    DocumentReference<TaskModel> docRef = taskCollection.doc();

    task.id = docRef.id;
    //  put the task inside the doc
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTasks(String userid) async {
    CollectionReference<TaskModel> taskCollection = getTaskscollection(userid);
    // get a snapshoot of the collection
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTask(String taskId, String userid) async {
    CollectionReference<TaskModel> taskCollection = getTaskscollection(userid);
    return taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTask(TaskModel updatedTask, String userid) async {
    CollectionReference<TaskModel> taskCollection = getTaskscollection(userid);
    DocumentReference<TaskModel> docRef = taskCollection.doc(updatedTask.id);
    return docRef.set(updatedTask);
  }

  static Future<UserModel> register(
      {required String name,
      required String email,
      required String password}) async {
    // Auth part
    final credintials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // This is the firebase part , to make a user collection and connect the firebase with the Auth
    final user = UserModel(id: credintials.user!.uid, name: name, email: email);
    final userCollection = getUserscollection();
    // create doc with the user id and set the user data in it
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    final credintials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final userCollection = getUserscollection();
    final docSnapshot = await userCollection.doc(credintials.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
