var express = require("express")
var Participants = require("./participants.js")
var app = express()
var bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({
  extended: false
}))
app.use(bodyParser.json())

const part = new Participants();

app.get("/oracle/participants/:type/:id", (req, res, next) => {
  const participant = part.getParticipantsByTypeId(req.params.type, req.params.id)
  console.log(participant)
  res.json(participant)
 });

 app.post("/oracle/participants/:type/:id", (req, res, next) => {
   const newParticipant = part.createParticipantsByTypeAndId(req.params.type, req.params.id, req.body.fspId, req.body.currency, req.body.partySubIdOrType)
   res.send(newParticipant)
   res.status(201).end()
 });

 app.put("/oracle/participants/:type/:id", (req, res, next) => {
  const participant = part.updateParticipantsByTypeAndId(req.params.type, req.params.id, req.body.fspId, req.body.currency, req.body.partySubIdOrType)
  res.json(participant)
});

app.delete("/oracle/participants/:type/:id", (req, res, next) => {
  deleteParticipantsByTypeAndId(req.params.type, req.params.id)
  res.status(200).end();
});

app.post("/oracle/participants", (req, res, next) => {
  // Not implemented
  res.status(200).end();
});

app.get("/oracle/requests/:type/:id", (req, res, next) => {
  const request = getRequestsByTypeId(req.params.type, req.params.id)
  res.json(request)
 });

app.get("/oracle/requests/:requestId", (req, res, next) => {
  const request = getRequestsById(req.params.requestId)
  res.json(request)
 });

app.listen(4100, () => {
 console.log("Server running on port 4100");
});