# Description
#   A hubot plugin that gets recommended gas settings
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   .ethgas - fetch current ethereum network gas price recommendations
#
# Notes:
#   This plugin fetches data from ethgasstation.info and is not endorsed by ethgasstation.info.
#
# Author:
#   Chip Wasson <chip@wasson.io>

module.exports = (robot) ->
  robot.hear /^.ethgas$/, (msg) ->
    robot.http("https://ethgasstation.info/json/ethgasAPI.json")
      .get() (err, res, body) ->
        body = JSON.parse(body)
        blockNum = body.blockNum
        safelow = body.safeLow / 10
        fast = body.fast / 10
        average = body.average / 10
        fastest = body.fastest / 10
        msg.send "As of block #{blockNum}: SafeLow (<30m) #{safelow} GWei, Average (<5m) #{average} GWei, Fast (<2m) #{fast} GWei, Fastest #{fastest} GWei. More at https://ethgasstation.info/."
