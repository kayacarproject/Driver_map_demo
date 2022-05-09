import 'package:firebase_database/firebase_database.dart';

class chatModel{
  String? Description,id, imageURL, recieverId, senderId, timeStamp, to, type, group, key, videoURL;

  chatModel(
      {this.Description,
      this.id,
      this.imageURL,
      this.recieverId,
      this.senderId,
      this.timeStamp,
      this.to,
      this.type,
      this.group, this.key, this.videoURL});

  chatModel.fromSnapshot(DataSnapshot snapshot){
    key = snapshot.key.toString();
    Description  = snapshot.child("Description").value.toString();
    id  = snapshot.child("id").value.toString();
    imageURL  = snapshot.child("imageURL").value.toString();
    recieverId  = snapshot.child("recieverId").value.toString();
    senderId  = snapshot.child("senderId").value.toString();
    timeStamp  = snapshot.child("timeStamp").value.toString();
    to  = snapshot.child("to").value.toString();
    type  = snapshot.child("type").value.toString();
    group = snapshot.child("group").value.toString();
    videoURL = snapshot.child("videoURL").value.toString();
  }

  toJson(){
    return{
      "key":key,
      "Description":Description,
      "id":id,
      "imageURL": imageURL,
      "recieverId":recieverId,
      "senderId":senderId,
      "timeStamp":timeStamp,
      "to":to,
      "type":type,
      "group":group,
      "videoURL":videoURL
    };
  }
}