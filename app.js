var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const io = require('./socketio/io');
const passport = require('./middleware/passport_auth');

var indexRouter = require('./routes/index');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(passport.initialize());

app.use('/', indexRouter);
app.use('/register',require('./routes/register'));
app.use('/login',require('./routes/login'));
app.use('/logout', require('./routes/logout'));
app.use('/refresh', require('./routes/refresh'));
app.use('/hotel',require('./routes/hotel'));
app.use('/files',require('./routes/files'));
app.use('/dateBooking',require('./routes/dateBooking'));
app.use('/rating',require('./routes/rating'));
app.use('/car',require('./routes/car'));
app.use('/legal_doc',require('./routes/confidentialFiles'));
app.use('/article', require('./routes/article'));
app.use('/avatar', require('./routes/avatars'));
app.use('/user', require('./routes/user'));
app.use('/favorite', require('./routes/favorite'));
app.use('/tour', require('./routes/tour'));
app.get('/upload_ui', (req, res) => {
    return  res.sendFile(path.join(__dirname, 'views', 'uploadView.html'));
});
app.get('/socket_ui', (req, res) => {
    return res.sendFile(path.join(__dirname, 'views', 'sockettest.html'));
})

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = {app, io};
