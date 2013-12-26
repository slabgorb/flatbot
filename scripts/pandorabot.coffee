# Description:
#   Interface with pandorabots
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_PANDORABOT_ID - your pandorabot's botid
#   HUBOT_BOTNAME - your bot name
#
# Commands:
#   hubot, [text] - chat with the pandorabot
#   hubot: [text] - chat with the pandorabot
#
# Author:
#   drosile

QS = require 'querystring'

module.exports = (robot) ->
  robot.hear "^#{process.env.HUBOT_BOTNAME}[,:] (.*)", (msg) ->
    url = "http://www.pandorabots.com/pandora/talk-xml"
    query = msg.match[1]
    query = query.replace /\s/g, "+"
    chatter = msg.message.user.name
    botid = process.env.HUBOT_PANDORABOT_ID
    data = QS.stringify({'botid': botid, 'input': query, 'custid': chatter})
    req = msg.http("http://www.pandorabots.com")
      .path("/pandora/talk-xml")
      .header("Content-Type", "application/x-www-form-urlencoded")
    req.post(data) (err, res, xml) ->
        switch res.statusCode
          when 200
            [_, response] = xml.match "<that>(.+?)</that>"
            response = response.replace /&quot;/g, '"'
            response = response.replace /&amp;/g, '&'
            response = response.replace /&apos;/g, "'"
            response = response.replace /&lt;/g, '<'
            response = response.replace /&gt;/g, '>'
            msg.reply response
          else
            msg.reply "I am too sleepy to chat."
