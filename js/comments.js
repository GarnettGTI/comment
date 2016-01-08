riot.tag2('comment-box', '<div class="ui container"> <h1 class="ui center aligned header">{opts.title}</h1> <div class="ui grid"> <div class="ui right floated six wide column" id="counts"> </div> </div> </div> <comment-form></comment-form> <comment-list comments="{comments}" most_liked_comments="{most_liked_comments}"></comment-list>', '', '', function(opts) {
      var self = this;
      self.on('mount', function () {
        $.getJSON('http://127.0.0.1:5000/comments', function (data) {
          self.comments = data.data;
          var wds = self.comments.length + " comments in total";
          document.getElementById("counts").innerHTML = wds;
          self.update();
        });
        $.getJSON('http://127.0.0.1:5000/most_liked_comments', function (data) {
          self.most_liked_comments = data.data;
          self.update();
        });
      });

      this.add = function(comment) {
        this.comments.push(comment)
        var wds = this.comments.length + " comments in total";
        document.getElementById("counts").innerHTML = wds;
        this.update();
        swal("评论已添加");
      }.bind(this)
}, '{ }');

riot.tag2('comment-list', '<div class="ui container"> <div class="ui horizontal divider"> most popular comments: </div> <div class="ui red segment"> <div class="ui hidden divider"></div> <comment each="{comment in opts.most_liked_comments}" comment="{comment}"></comment> </div> <div class="ui divider"></div> <div class="ui blue segment"> <div class="ui hidden divider"></div> <comment each="{comment in opts.comments}" comment="{comment}"></comment> </div> </div>', '', '', function(opts) {
}, '{ }');

riot.tag2('comment-form', '<div class="ui container"> <div class="ui horizontal divider"> leave your comments here: </div> <div class="ui orange segment"> <form class="ui form" onsubmit="{add}"> <div class="ui text container"> <div class="field"> <label>Name</label> <input type="text" name="name" placeholder="name"> </div> <div class="field"> <label>Message</label> <textarea name="message" placeholder="message"></textarea> </div> <button class="ui green button" type="submit">Submit</button> <button class="ui red button" type="reset">Reset</button> </div> </form> </div> </div>', '', '', function(opts) {
  this.add = function(e) {
    var target = this.parent
    var comment = {
      name: this.name.value,
      message: this.message.value,
      like: 0,
    };
    $.ajax({
      url: "http://127.0.0.1:5000/comment",
      type: "POST",
      data: JSON.stringify({data: comment}),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(data){
        target.add(data)
      }
    });
    e.target.reset()
}.bind(this)
}, '{ }');

riot.tag2('comment', '<div class="ui raised segment"> <h3> {opts.comment.name} <a onclick="{favourite}"> <i class="thumbs up icon">{opts.comment.like}</i> </a> </h3> <div class="ui segment"> <p>{opts.comment.message}</p> </div> <a onclick="{delete}"> <i class="remove circle outline icon">Delete</i> </a> </div> <div class="ui hidden divider"></div>', '', '', function(opts) {
  this.favourite = function(e) {
    opts.comment.like += 1
    $.ajax({
      url: "http://127.0.0.1:5000/comment/" + opts.comment.id,
      type: "PUT",
      data: JSON.stringify({data: "1"}),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(){
        this.alert("Comment saved!");
      }
    });
    this.update()
  }.bind(this)

  this.delete = function(e) {
  var self = this;
    $.ajax({
      url: "http://127.0.0.1:5000/comment/" + opts.comment.id,
      type: "DELETE",
      success: function(){
        self.update();
        location.reload();
      },
      error: function(){

        swal({
          title: "出错了",
          text: "删除失败",
          type: "error",
          confirmButtonColor: "#DD6B55",
          confirmButtonText: "知道了"
          }, function(){
            location.reload();
          });
      }
    })
    this.update();
  }.bind(this)
}, '{ }');
