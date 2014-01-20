# Description:
#   Fortune command from Gigaset Fortune-RSS generator
#
# Dependencies:
#   ent
#
# Configuration:
#   None
#
# Commands:
#   hubot fortune me
#   hubot cookie me
#
# Author:
# slabgorb@gmail.com
ent = require 'ent'
module.exports = (robot) ->

  robot.respond /fortune|cookie me/i, (msg) ->
    msg.http("http://wertarbyte.de/gigaset-rss/?limit=140&cookies=1&lang=en&format=rss&jar_id=47890485652059026823698344598484774845208695815536698")
      .get() (err, res, body) ->
        try
          [_, response] = body.match "<item>\n<title>(.+?)</title"
        catch error
          response = "Ask again later." + error
        msg.reply ent.decode(response)

