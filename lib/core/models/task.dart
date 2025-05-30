class Task{
  int? id;
  String title='';
  String description='';
  bool isDone = false;
  bool highPriority = false;

  Task({required this.title,this.description='',this.isDone=false,this.highPriority=false,this.id});

  @override
  String toString() {
    return 'Task --> ID = $id , Title = $title , Des=$description';
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) { return true;}

    return other is Task && other.title == title && other.description == description;
  }
  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ id.hashCode;

  Task copy()=> Task(title: title,description: description);

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'isDone':isDone,
      'highPriority':highPriority
    };
  }
  factory Task.fromMap(Map<String,dynamic>map){
    return Task(
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      highPriority: map['highPriority'],
      id:map['id']
    );
  }
}