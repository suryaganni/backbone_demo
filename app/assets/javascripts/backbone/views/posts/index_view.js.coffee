Blog.Views.Posts ||= {}

class Blog.Views.Posts.IndexView extends Backbone.View
  template: JST["backbone/templates/posts/index"]

  events:
    "keyup #search input" : "search_posts"
    "change #order select" : "reorder_posts"

  reorder_posts: (e) ->
    order = $(e.target).val()
    @options.posts.order = order
    @options.posts.fetch_w_params(true)
  
  search_posts: (e) ->
    word = $(e.target).val()
    @options.posts.query = word
    @options.posts.fetch_w_params(true)

  initialize: () ->
    @options.posts.bind('reset', @addAll)
  addAll: () =>
    @$el.find('tbody tr').remove()
    @options.posts.each(@addOne)
  addOne: (post) =>
    view = new Blog.Views.Posts.PostView({model : post})
    @$("tbody").append(view.render().el)
  render: =>
    $(@el).html(@template(posts: @options.posts.toJSON() ))
    @addAll()
    return this
