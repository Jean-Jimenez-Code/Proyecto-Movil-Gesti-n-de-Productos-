const mongoose = require('mongoose')
const server = '127.0.0.1:27017'; 
const database = 'lista';

const connectDB = async () => { //para que se conecte la base de datos
    try {
        await mongoose.connect(`mongodb://${server}/${database}`)

        console.log('MongoDB connected!!'); //si se conecta en la terminal dira "MongoDB connected!!"
    } catch (err) {
        console.log('Failed to connect to MongoDB', err);//si no se conecta en la terminal dira "Failed to connect to MongoDB"
    }
};

module.exports= connectDB