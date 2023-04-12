const mongoose = require('mongoose')

const connectDb = async ()=>{
    try{
        await mongoose.connect(process.env.DATABASE_URI,
            {
                useUnifiedTopology: true,
                useNewUrlParser: true,
                family:4,
            }
        );
    }catch (e){
        console.log(e);
    }
}

module.exports = connectDb;