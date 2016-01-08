<comment-box>
  <div class="ui container">
    <h1 class="ui center aligned header">{ opts.title }</h1>
    <div class="ui grid">
      <div class="ui right floated six wide column" id="counts">
      </div>
    </div>
  </div>
  <comment-form />
  <comment-list comments={ comments } most_liked_comments={ most_liked_comments }/>


    <script>
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


      add(comment) {
        this.comments.push(comment)
        var wds = this.comments.length + " comments in total";
        document.getElementById("counts").innerHTML = wds;
        this.update();
        swal("评论已添加");
      }
    </script>
</comment-box>

<comment-list>
  <div class="ui container">
    <div class="ui horizontal divider">
      most popular comments:
    </div>
    <div class="ui red segment">
      <!--<div class="ui segment">
        <h3>
          GarnettGTI
          <a>
            <i class="thumbs up icon">1024</i>
          </a>
        </h3>
        <div class="ui segment">
          <p>This web page sucks!</p>
        </div>
        <a>
          <i class="remove circle outline icon">Delete</i>
        </a>
      </div>-->
      <div class="ui hidden divider"></div>
      <comment each={ comment in opts.most_liked_comments } comment={ comment }/>
    </div>
    <div class="ui divider"></div>
    <div class="ui blue segment">
      <div class="ui hidden divider"></div>
      <comment each={ comment in opts.comments } comment={ comment }/>
    </div>
  </div>

</comment-list>

<comment-form>
  <div class="ui container">
    <div class="ui horizontal divider">
      leave your comments here:
    </div>
    <div class="ui orange segment">
      <form class="ui form" onsubmit={ add }>
        <div class="ui text container">
          <div class="field">
            <label>Name</label>
            <input type="text" name="name" placeholder="name">
          </div>
          <div class="field">
            <label>Message</label>
            <textarea name="message" placeholder="message"></textarea>
          </div>
          <button class="ui green button" type="submit">Submit</button>
          <button class="ui red button" type="reset">Reset</button>
        </div>
      </form>
    </div>
  </div>
<script>
  add(e) {
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
}
</script>

</comment-form>

<comment>
  <div class="ui raised segment">
    <h3>
      { opts.comment.name }
      <a onclick={ favourite }>
        <i class="thumbs up icon">{ opts.comment.like }</i>
      </a>
    </h3>
    <div class="ui segment">
      <p>{ opts.comment.message }</p>
    </div>
    <a onclick={ delete }>
      <i class="remove circle outline icon">Delete</i>
    </a>
  </div>

  <div class="ui hidden divider"></div>
  favourite(e) {
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
  }

  delete(e) {
  var self = this;
    $.ajax({
      url: "http://127.0.0.1:5000/comment/" + opts.comment.id,
      type: "DELETE",
      success: function(){
        self.update();
        location.reload();
      },
      error: function(){
        // 弹出提示
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
  }
</comment>
