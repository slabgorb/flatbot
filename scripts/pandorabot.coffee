# Description:
#   Interface with pandorabots
#
# Dependencies:
#   querystring
#
# Configuration:
#   HUBOT_PANDORABOT_ID - your pandorabot's botid
#   HUBOT_BOTNAME - your bot name
#
# Commands:
#   hubot, [text] - chat with the pandorabot
#   hubot: [text] - chat with the pandorabot

QS = require 'querystring'

module.exports = (robot) ->
  robot.hear "^#{process.env.HUBOT_BOTNAME}, (.*)"i, (msg) ->
    url = "http://www.pandorabots.com/pandora/talk?botid="
    url += process.env.HUBOT_PANDORABOT_ID
    query = query.replace / /g, "+"
    query = query.replace /'/g, ""
    chatter = msg.message.user.name
    data = QS.stringify({'message': query, 'botcust2': chatter,
                         'botid': process.env.HUBOT_PANDORABOT_ID})
    msg.http(url)
      .post(data) (err, res, body) ->
        response = body.match "#{process.env.HUBOT_BOTNAME}:<\/b>(.+?)<br>"[0]
        response = response.replace /\["|"\]|/, ""
        msg.send response

  robot.hear "^#{process.env.HUBOT_BOTNAME}: (.*)"i, (msg) ->
    url = "http://www.pandorabots.com/pandora/talk?botid="
    url += process.env.HUBOT_PANDORABOT_ID
    query = query.replace / /g, "+"
    query = query.replace /'/g, ""
    chatter = msg.message.user.name
    data = QS.stringify({'message': query, 'botcust2': chatter,
                         'botid': process.env.HUBOT_PANDORABOT_ID})
    msg.http(url)
      .post(data) (err, res, body) ->
        response = body.match "#{process.env.HUBOT_BOTNAME}:<\/b>(.+?)<br>"[0]
        response = response.replace /\["|"\]|/, ""
        msg.send response
