# Description:
#   Random facts from mentalfloss.com's amazing fact generator
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot fact me - Receive an amazing fact

module.exports = (robot) ->

  robot.respond /fact me/i, (msg) ->
    msg.http("http://mentalfloss.com/api/1.0/views/amazing_facts.json")
      .get() (err, res, body) ->
        msg.send JSON.parse(body)[0].nid.replace /<\/?p>/g, ""
