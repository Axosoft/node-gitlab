BaseModel = require '../BaseModel'
Utils = require '../Utils'

class ProjectBuilds extends BaseModel

  # === Builds
  listBuilds: (projectId, fn = null) =>
    @debug "Projects::listBuilds()"
    @get "projects/#{Utils.parseProjectId projectId}/builds", fn

  showBuild: (projectId, buildId, fn = null) =>
    @debug "Projects::build()"
    @get "projects/#{Utils.parseProjectId projectId}/builds/#{buildId}", null, fn

  triggerBuild: (params={}, fn = null) =>
    @debug "Projects::triggerBuild()"
    @post "projects/#{Utils.parseProjectId params.projectId}/trigger/builds", params, null, fn

module.exports = (client) -> new ProjectBuilds client
