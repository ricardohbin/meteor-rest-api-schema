if Meteor.isServer
  # Workaround to api support request.body
  # @see https://github.com/EventedMind/iron-router/issues/1003
  Router.onBeforeAction Iron.Router.bodyParser.urlencoded({extended: false})

  schema = @UsersSchema
  Users = @Users

  Router.route '/api/users', { where: 'server'}
    .post () ->
      params = this.request.body
      if not Match.test(params, schema)
        this.response.statusCode = 400
        return this.response.end "Wrong schema!"
      Users.insert params
      this.response.statusCode = 201
      this.response.end()

  Router.route '/api/users/:id', { where: 'server'}
    .get () ->
      user = Users.findOne this.params.id
      if not user
        this.response.statusCode = 404
        return this.response.end "Not found!"
      this.response.end JSON.stringify user
    .delete () ->
      user = Users.remove this.params.id
      if not user
        this.response.statusCode = 404
        return this.response.end "Not found!"
      this.response.statusCode = 202
      this.response.end()
    .put () ->
      params = this.request.body
      if not Match.test(params, schema)
        this.response.statusCode = 400
        return this.response.end "Wrong schema!"
      params._id = this.params.id
      Users.update params._id, params
      this.response.statusCode = 200
      this.response.end JSON.stringify Users.findOne params._id