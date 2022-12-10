const { Schema, model } = require('mongoose');

const ProdSchema = new Schema( //se asignara los atributos a las variables
  {
    nombre: {
      type: String, 
      //string osea que guardara los datos tipo texto
    },
    cantidad: {
      type: String,
    },
    precio: {
        type: String,
    } 
  },
  { timestamps: true },
);

module.exports= model('prodSchema',ProdSchema)