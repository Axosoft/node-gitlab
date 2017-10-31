BaseModel = require '../BaseModel'
Utils = require '../Utils'

class Projects extends BaseModel
  init: =>
    @members = @load 'ProjectMembers'
    @hooks =   @load 'ProjectHooks'
    @issues =  @load 'ProjectIssues'
    @labels =  @load 'ProjectLabels'
    @repository = @load 'ProjectRepository'
    @milestones = @load 'ProjectMilestones'
    @deploy_keys = @load 'ProjectDeployKeys'
    @merge_requests = @load 'ProjectMergeRequests'
    @services = @load 'ProjectServices'
    @builds = @load 'ProjectBuilds'

  all: (params={}, fn=null) =>
    if 'function' is typeof params
      fn = params
      params={}
    @debug "Projects::all()"

    params.page ?= 1
    params.per_page ?= 100

    data = []
    cb = (err, retData) =>
      if err
        return fn err, (retData || data) if fn
      else if retData.length == params.per_page
        @debug "Recurse Projects::all()"
        data = data.concat(retData)
        params.page++
        return @get "projects", params, cb
      else
        data = data.concat(retData)
        return fn err, data if fn

    @get "projects", params, cb

  allAdmin: (params={}, fn=null) =>
    if 'function' is typeof params
      fn = params
      params={}
    @debug "Projects::allAdmin()"

    params.page ?= 1
    params.per_page ?= 100

    data = []
    cb = (err, retData) =>
      if err
        return fn err, (retData || data) if fn
      else if retData.length == params.per_page
        @debug "Recurse Projects::allAdmin()"
        data = data.concat(retData)
        params.page++
        return @get "projects/all", params, cb
      else
        data = data.concat(retData)
        return fn err, data if fn

    @get "projects/all", params, cb

  owned: (params={}, fn=null) =>
    if 'function' is typeof params
      fn = params
      params={}
    @debug "Projects::owned()"

    params.page ?= 1
    params.per_page ?= 100

    data = []
    cb = (err, retData) =>
      if err
        return fn err, (retData || data) if fn
      else if retData.length == params.per_page
        @debug "Recurse Projects::owned()"
        data = data.concat(retData)
        params.page++
        return @get "projects/all", params, cb
      else
        data = data.concat(retData)
        return fn err, data if fn

    @get "projects/owned", params, cb

  show: (projectId, fn=null) =>
    @debug "Projects::show()"
    @get "projects/#{Utils.parseProjectId projectId}", fn

  showFromNamespaceAndProjectName: (namespace, projectName, fn=null) =>
    @debug "Projects::showFromNamespaceAndProjectName"
    @get "projects/#{namespace}%2F#{projectName}", fn

  create: (params={}, fn=null) =>
    @debug "Projects::create()"
    @post "projects", params, fn

  create_for_user: (params={}, fn=null) =>
    @debug "Projects::create_for_user()"
    @post "projects/user/#{params.user_id}", params, fn

  edit: (projectId, params={}, fn=null) =>
    @debug "Projects::edit()"
    @put "projects/#{Utils.parseProjectId projectId}", params, fn

  addMember: (params={}, fn=null) =>
    @debug "Projects::addMember()"
    @post "projects/#{params.id}/members", params, fn

  editMember: (params={}, fn=null) =>
    @debug "Projects::editMember()"
    @put "projects/#{params.id}/members/#{params.user_id}", params, fn

  listMembers: (params={}, fn=null) =>
    @debug "Projects::listMembers()"
    @get "projects/#{params.id}/members", fn

  listCommits: (params={}, fn=null) =>
    @debug "Projects::listCommits()"
    @get "projects/#{params.id}/repository/commits", params, fn

  listTags: (params={}, fn=null) =>
    @debug "Projects::listTags()"
    @get "projects/#{params.id}/repository/tags", fn

  remove: (projectId, fn = null) =>
    @debug "Projects::remove()"
    @delete "projects/#{Utils.parseProjectId projectId}", fn

  fork: (params={}, fn=null) =>
    @debug "Projects::fork()"
    @post "projects/fork/#{params.id}", params, fn

  forks: (params={}, fn=null) =>
    @debug "Projects::forks()"
    @get "projects/#{params.id}/forks", params, fn

  search: (projectName, params={}, fn=null) =>
    if 'function' is typeof params
      fn = params
      params={}

    @debug "Projects::search()"
    @get "projects/search/#{projectName}", params, fn

  listTriggers: (projectId, fn = null) =>
    @debug "Projects::listTriggers()"
    @get "projects/#{Utils.parseProjectId projectId}/triggers", fn

module.exports = (client) -> new Projects client
