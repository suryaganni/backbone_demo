class Blog.Routers.PostsRouter extends Backbone.Router

  initialize: (options) ->
    @posts = new Blog.Collections.PostsCollection(options.posts, options.total_entries)
  routes:
    "index"       : "index"
    "new"         : "newPost"
    ":id"         : "show"
    ":id/edit"    : "edit"
    ".*"          : "index"
  newPost: ->
    @view = new Blog.Views.Posts.NewView(collection: @posts)
    $("#posts").html(@view.render().el)
  index: ->
    @posts.fetch()
    @view = new Blog.Views.Posts.IndexView(posts: @posts)
    $("#posts").html(@view.render().el)
    @paginatorView = new Blog.Views.PaginatedView({ collection : @posts })
  show: (id) ->
    post = @posts.get(id)
    @view = new Blog.Views.Posts.ShowView(model: post)
    $("#posts").html(@view.render().el)
  edit: (id) ->
    post = @posts.get(id)
    @view = new Blog.Views.Posts.EditView(model: post)
    $("#posts").html(@view.render().el)
