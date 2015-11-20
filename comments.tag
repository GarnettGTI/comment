<comment-box>
  <h1 class="ui center aligned icon header">{ opts.title}</h1>

  <comment-list comments={ comments } />
  <comment-form />

  this.comments = [];

  add(comment) {
    comments.push(comment)
    this.update()
  }
</comment-box>

<comment-list>
  <comment each={ opts.comments } name={ this.name } message={ this.message } />
  console.log(opts.comments)
</comment-list>

<comment-form>
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
  <div>
    <h2>{ opts.name }</h2>
    <p>{ opts.message }</p>
  </div>
</comment>
