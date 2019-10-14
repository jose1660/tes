module.exports = (robot) ->
    robot.hear /ver (.*)$/i, (res) ->
        grupo = res.match[1]
        @exec = require('child_process').exec
        command = "sh consultas.sh #{grupo}"
        res.send("Getting your pods")
        @exec command, (error, stdout, stderror) ->
            if stdout
                res.send "```\n" + stdout + "\n```"
            else
                res.send ("Sorry that didn't work")