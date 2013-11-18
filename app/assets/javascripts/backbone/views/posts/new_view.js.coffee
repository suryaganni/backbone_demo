Blog.Views.Posts ||= {}

class Blog.Views.Posts.NewView extends Backbone.View
  template: JST["backbone/templates/posts/new"]
  error_messages_template: JST["backbone/templates/error_messages"]
  events:
    "submit #new-post": "save"
  constructor: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("change:errors", () =>
      this.render()
    )
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset("errors")
    @collection.create(@model.toJSON(),
      success: (post) =>
        @model = post
        window.location.hash = "/#{@model.id}"
      error: (post, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
  render: ->
    $(@el).html(@template(@model.toJSON() ))
    $("#error_messages").html(@error_messages_template(@model.toJSON() ))
    this.$("form").backboneLink(@model)
    return this
