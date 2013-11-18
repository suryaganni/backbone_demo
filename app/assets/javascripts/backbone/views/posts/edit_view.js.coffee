Blog.Views.Posts ||= {}

class Blog.Views.Posts.EditView extends Backbone.View
  template : JST["backbone/templates/posts/edit"]
  error_messages_template: JST["backbone/templates/error_messages"]
  events :
    "submit #edit-post" : "update"
  constructor: (options) ->
    super(options)
    @model.bind("change:errors", () =>
      this.render()
    )
  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset("errors")
    @model.save(null,
      success : (post) =>
        @model = post
        window.location.hash = "/#{@model.id}"
      error: (post, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
  render : ->
    $(@el).html(@template(@model.toJSON() ))
    $("#error_messages").html(@error_messages_template(@model.toJSON() ))
    this.$("form").backboneLink(@model)
    return this
