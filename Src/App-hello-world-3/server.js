var express = require("express"),
    app = express()

var router = express.Router()
var date = new Date()

var seat_model = "Seat 600"
var seat_image = "https://www.salvat.com/colecciones/seat600/res/img/600DFront_OK.png"

var kawa_model = "Kawasaki Ninja"
var kawa_image = "https://content.kawasaki.com/Content/Uploads/Products/7304/Colors/jkm5wu0v.04c.png"

var ferrari_model = "La Ferrari"
var ferrari_image = "https://vignette1.wikia.nocookie.net/egamia/images/f/f9/Ferrari-LaFerrari.png/revision/latest?cb=20140801010229"

app.use(function(req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
	  next();
});

router.get('/hello', function (req, res) {
    res.json(
    	{
		msg: "hello World v2! ",
		model: ferrari_model,
		image: ferrari_image,
		date: date.getFullYear()+":"+(date.getMonth()+1)+":"+date.getDate(),
		hostname: process.env.HOSTNAME,
		svc: process.env.DOCKER_SERVICE_NAME
    	})	
    })

app.use(router)

app.listen(3000, function() {
    console.log("Node server running on http://localhost:3000");
});
