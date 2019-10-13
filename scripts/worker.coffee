module.exports = (robot) ->
    robot.hear /List crq/i, (res) ->
        @exec = require('child_process').exec
        command = "curl -i http://google.com"
        res.send("Getting your pods")
        @exec command, (error, stdout, stderror) ->
            if stdout
                res.send "```\n" + stdout + "\n```"
            else
                res.send ("Sorry that didn't work")