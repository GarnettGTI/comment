var gulp = require('gulp');
var riot = require('gulp-riot');
var watcher = gulp.watch('comments.tag', ['riot']);
watcher.on('change', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});

gulp.task('riot', function() {
  gulp.src('comments.tag')
      .pipe(riot())
      .pipe(gulp.dest('js'));
});
