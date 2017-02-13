BaseModel = require '../BaseModel'
Utils = require '../Utils'

class ProjectServices extends BaseModel
  
  show: (projectId, serviceName, fn = null) =>
    @debug "Projects::showService()"
    @get "projects/#{Utils.parseProjectId projectId}/services/#{serviceName}", fn

  update: (projectId, serviceName, params, fn = null) =>
    @debug "Projects::updateService()"
    @put "projects/#{Utils.parseProjectId projectId}/services/#{serviceName}", params, fn

  remove: (projectId, serviceName, fn = null) =>
    @debug "Projects:removeService()"
    @delete "projects/#{Utils.parseProjectId projectId}/services/#{serviceName}", fn

module.exports = (client) -> new ProjectServices client
