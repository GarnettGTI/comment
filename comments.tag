<comment-box>
  <div class="ui container">
    <h1 class="ui center aligned header">{ opts.title }</h1>
    <div class="ui grid">
      <div class="ui right floated six wide column">
        20 comments in total
      </div>
    </div>
  </div>
  <comment-list comments={ comments } />
  <comment-form />

  this.comments = [];

  add(comment) {
    this.comments.push(comment)
    this.update()
  }
</comment-box>

<comment-list>
  <div class="ui container">
    <div class="ui horizontal divider">
      most popular comments:
    </div>
    <div class="ui red segment">
      <div class="ui segment">
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
      </div>
    </div>
    <div class="ui divider"></div>
    <comment each={ opts.comments } name={ this.name } message={ this.message } />
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


  add(e) {
    var comment = {
      name: this.name.value,
      message: this.message.value
    }
    this.parent.add(comment)
    e.target.reset()
  }
</comment-form>

<comment>
  <div class="ui blue segment">
    <h3>
      { opts.name }
      <a>
        <i class="thumbs up icon">1024</i>
      </a>
    </h3>
    <div class="ui segment">
      <p>{ opts.message }</p>
    </div>
    <a>
      <i class="remove circle outline icon">Delete</i>
    </a>
  </div>
</comment>
