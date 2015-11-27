riot.tag('comment-box', '<h1 class="ui center aligned icon header">{ opts.title}</h1> <comment-list comments="{ comments }"></comment-list> <comment-form ></comment-form>', function(opts) {

  this.comments = [];

  this.add = function(comment) {
    comments.push(comment)
    this.update()
  }.bind(this);

});

riot.tag('comment-list', '<comment each="{ opts.comments }" name="{ this.name }" message="{ this.message }"></comment>', function(opts) {
  console.log(opts.comments)

});

riot.tag('comment-form', '<form class="ui form" onsubmit="{ add }"> <div class="ui text container"> <div class="field"> <label>Name</label> <input type="text" name="name" placeholder="name"> </div> <div class="field"> <label>Message</label> <textarea name="message" placeholder="message"></textarea> </div> <button class="ui green button" type="submit">Submit</button> <button class="ui red button" type="reset">Reset</button> </div> </form>', function(opts) {

  this.add = function(e) {
    var comment = {
      name: this.name.value,
      message: this.message.value
    }
    this.parent.add(comment)
    e.target.reset()
  }.bind(this);

});

riot.tag('comment', '<div> <h2>{ opts.name }</h2> <p>{ opts.message }</p> </div>', function(opts) {

});
