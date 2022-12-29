var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors=require('cors');


var indexRouter = require('./routes/index');
var todoRouter = require('./routes/todo');
var borrarRouter = require('./routes/borrar');
const connectDB = require('./config/dbconnect');//obtenemos los datos de la carpeta config que el que tiene la base de datos

var app = express();

connectDB()//para iniciar la base de datos

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

//app.use(require('./routes/todo'));
app.use('/', indexRouter);
app.use('/todo', todoRouter);//para conectar a la ruta de todo
app.use('/borrar', borrarRouter);//para conectar a la ruta de borrar


module.exports = app;
