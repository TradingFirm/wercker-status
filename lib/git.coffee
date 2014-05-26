iniparser = require 'iniparser'

class WerckerGit
    get_local_git_config: (cb) ->
        branch = atom.project.getRepo()?.branch?.split('/')?[2]
        git_project = atom.project.getRepo()
        if git_project
            iniparser.parse "#{git_project.path}/config", (err, data) ->
                returnobj =
                    url    : data['remote "origin"']?.url
                    branch : branch
                return cb('Git params invalid') if !returnobj.url or !returnobj.branch
                cb(null, returnobj)
        else
            cb('This package does not have repository')

module.exports = new WerckerGit